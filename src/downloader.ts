import { ExtensionContext, window } from 'coc.nvim';
import extract from 'extract-zip';
import fetch from 'node-fetch';
import path from 'path';
import * as fs from 'fs-extra';

const ls_name = 'sumneko-lua-ls';

interface Asset {
  name: string;
  browser_download_url: string;
}

interface GithubRelease {
  tag_name: string;
  published_at: string;
  assets: Array<Asset>;
}

export interface ReleaseTag {
  tag: string;
  url: string;
  asset?: Asset;
}

export async function getLatestRelease(): Promise<ReleaseTag | undefined> {
  const releaseURL = 'https://api.github.com/repos/sumneko/vscode-lua/releases/latest';
  const response = await fetch(releaseURL);
  if (!response.ok) {
    console.error(await response.text());
    return;
  }

  const release: GithubRelease = await response.json();
  const asset = release.assets[0];

  const tag = release.tag_name;

  return { asset, tag, url: asset.browser_download_url };
}

export async function downloadServer(context: ExtensionContext, release?: ReleaseTag): Promise<void> {
  const statusItem = window.createStatusBarItem(0, { progress: true });
  statusItem.show();

  if (!release) {
    statusItem.text = 'Fetching latest release information';
    release = await getLatestRelease();
    if (!release) {
      statusItem.hide();
      window.showMessage('Get latest release information failed', 'error');
      return;
    }
  }

  statusItem.text = 'Downloading latest sumneko lua-language-server';

  const resp = await fetch(release.url);
  if (!resp.ok) {
    statusItem.hide();
    throw new Error('Request failed');
  }

  const targetPath = path.join(context.storagePath, ls_name);
  const tempDir = await fs.mkdtemp(ls_name);
  const extTempFile = path.join(tempDir, ls_name);

  statusItem.text = `Writing temp file ${extTempFile}`;
  await fs.writeFile(extTempFile, await resp.buffer());

  statusItem.text = `Removing old files`;
  await fs.remove(targetPath);

  statusItem.text = `Extracting to ${targetPath}`;
  await extract(extTempFile, { dir: targetPath });
  await fs.chmod(path.join(targetPath, 'extension', 'server', 'bin', 'Linux', 'lua-language-server'), '777');
  await fs.chmod(path.join(targetPath, 'extension', 'server', 'bin', 'macOS', 'lua-language-server'), '777');

  statusItem.text = `Removing temp file ${extTempFile}`;
  await fs.remove(tempDir);

  window.showMessage(`Installed ${targetPath} successfully`);
  statusItem.hide();
}
