/**
 * Temporary local copy of extract-zip behavior until upstream is fixed.
 *
 * https://github.com/max-mapper/extract-zip/issues/154
 */
import path from 'node:path'
import stream from 'node:stream'
import { text } from 'node:stream/consumers'
import { promisify } from 'node:util'
import fs from 'fs-extra'
import yauzl from 'yauzl'

const pipeline = promisify(stream.pipeline)

export interface UnzipOpts {
  dir: string
  defaultDirMode?: number | string
  defaultFileMode?: number | string
  onEntry?: (entry: yauzl.Entry, zip: yauzl.ZipFile) => void
}

function openZip(zipPath: string, options: yauzl.Options): Promise<yauzl.ZipFile> {
  return new Promise((resolve, reject) => {
    yauzl.open(zipPath, options, (err, zipfile) => {
      if (err != null || zipfile == null) {
        reject(err ?? new Error(`Unable to open zip file: ${zipPath}`))
        return
      }

      resolve(zipfile)
    })
  })
}

class Extractor {
  private readonly zipPath: string
  private readonly opts: UnzipOpts
  private canceled = false

  constructor(zipPath: string, opts: UnzipOpts) {
    this.zipPath = zipPath
    this.opts = opts
  }

  async extract(): Promise<void> {
    const zipfile = await openZip(this.zipPath, {
      lazyEntries: true,
    })

    return new Promise((resolve, reject) => {
      zipfile.on('error', (err) => {
        this.canceled = true
        reject(err)
      })
      zipfile.readEntry()

      zipfile.on('close', () => {
        if (!this.canceled)
          resolve()
      })

      zipfile.on('entry', async (entry) => {
        /* istanbul ignore if */
        if (this.canceled)
          return

        if (entry.fileName.startsWith('__MACOSX/')) {
          zipfile.readEntry()
          return
        }

        const destDir = path.dirname(path.join(this.opts.dir, entry.fileName))

        try {
          await fs.mkdir(destDir, { recursive: true })

          const canonicalDestDir = await fs.realpath(destDir)
          const relativeDestDir = path.relative(this.opts.dir, canonicalDestDir)

          if (relativeDestDir.split(path.sep).includes('..'))
            throw new Error(`Out of bound path "${canonicalDestDir}" found while processing file ${entry.fileName}`)

          await this.extractEntry(entry, zipfile)
          zipfile.readEntry()
        }
        catch (err) {
          this.canceled = true
          zipfile.close()
          reject(err)
        }
      })
    })
  }

  private async extractEntry(entry: yauzl.Entry, zipfile: yauzl.ZipFile): Promise<void> {
    /* istanbul ignore if */
    if (this.canceled)
      return

    if (this.opts.onEntry)
      this.opts.onEntry(entry, zipfile)

    const dest = path.join(this.opts.dir, entry.fileName)

    const mode = (entry.externalFileAttributes >> 16) & 0xFFFF
    const fileTypeMask = 0o170000
    const directoryFlag = 0o040000
    const symlinkFlag = 0o120000
    const symlink = (mode & fileTypeMask) === symlinkFlag
    let isDir = (mode & fileTypeMask) === directoryFlag

    if (!isDir && entry.fileName.endsWith('/'))
      isDir = true

    const madeBy = entry.versionMadeBy >> 8
    if (!isDir)
      isDir = (madeBy === 0 && entry.externalFileAttributes === 16)

    const procMode = this.getExtractedMode(mode, isDir) & 0o777

    const destDir = isDir ? dest : path.dirname(dest)

    const mkdirOptions: fs.MakeDirectoryOptions = { recursive: true }
    if (isDir)
      mkdirOptions.mode = procMode

    await fs.mkdir(destDir, mkdirOptions)
    if (isDir)
      return

    const readStream = await this.openReadStream(zipfile, entry)

    if (symlink) {
      const link = await text(readStream)
      await fs.symlink(link, dest)
    }
    else {
      await pipeline(readStream, fs.createWriteStream(dest, { mode: procMode }))
    }
  }

  private openReadStream(zipfile: yauzl.ZipFile, entry: yauzl.Entry): Promise<NodeJS.ReadableStream> {
    return new Promise((resolve, reject) => {
      zipfile.openReadStream(entry, (err, readStream) => {
        if (err != null || readStream == null) {
          reject(err ?? new Error(`Unable to open stream for entry: ${entry.fileName}`))
          return
        }

        resolve(readStream)
      })
    })
  }

  private getExtractedMode(entryMode: number, isDir: boolean): number {
    let mode = entryMode

    if (mode === 0) {
      if (isDir) {
        if (this.opts.defaultDirMode != null)
          mode = Number.parseInt(`${this.opts.defaultDirMode}`, 10)

        if (!mode)
          mode = 0o755
      }
      else {
        if (this.opts.defaultFileMode != null)
          mode = Number.parseInt(`${this.opts.defaultFileMode}`, 10)

        if (!mode)
          mode = 0o644
      }
    }

    return mode
  }
}

export async function extract(zipPath: string, opts: UnzipOpts): Promise<void> {
  if (!path.isAbsolute(opts.dir))
    throw new Error('Target directory is expected to be absolute')

  await fs.mkdir(opts.dir, {
    recursive: true,
  })

  const normalizedOpts: UnzipOpts = {
    ...opts,
    dir: await fs.realpath(opts.dir),
  }

  return new Extractor(zipPath, normalizedOpts).extract()
}
