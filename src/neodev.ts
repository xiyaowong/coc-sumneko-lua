import path from 'node:path'
import { exec } from 'node:child_process'
import { promisify } from 'node:util'
import type { ExtensionContext } from 'coc.nvim'
import { window, workspace } from 'coc.nvim'
import * as fs from 'fs-extra'

const typesDirName = 'neodev'

export class Neodev {
  constructor(private readonly context: ExtensionContext) {}
  autoDownloaded = false

  async downloadTypes(): Promise<void> {
    // TODO: check updates
    window.showInformationMessage('Start downloading nvim lua types')
    await fs.remove(this.repoDir)
    await promisify(exec)(`git clone https://github.com/folke/neodev.nvim.git ${this.repoDir} --depth=1`)
    if (this.typesExist)
      window.showInformationMessage(`Download nvim lua types successfully!`)
    else
      window.showErrorMessage('Download nvim lua types failed!')
  }

  private get repoDir(): string {
    return path.join(this.context.storagePath, typesDirName)
  }

  private get typesExist(): boolean {
    return fs.existsSync(this.repoDir)
  }

  async getTypesPath(): Promise<string> {
    if (!this.typesExist && !this.autoDownloaded) {
      this.autoDownloaded = true
      await this.downloadTypes()
    }
    if (this.typesExist) {
      return path.join(
        this.repoDir,
        'types',
        workspace.isNvim && Boolean(await workspace.nvim.call('luaeval', 'vim.version().prerelease')) ? 'nightly' : 'stable',
      )
    }
    else {
      window.showWarningMessage('Please run command: installNvimLuaTypes')
      return ''
    }
  }
}
