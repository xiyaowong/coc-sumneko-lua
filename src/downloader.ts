import { ExtensionContext, window } from 'coc.nvim';
import extract from 'extract-zip';
import fetch, { Response } from 'node-fetch';
import path from 'path';
import * as fs from 'fs-extra';
import * as os from 'os';

const ls_name = 'sumneko-lua-ls';

export interface Release {
  version: string;
  url: string;
}

export async function getLatestRelease(): Promise<Release | undefined> {
  const headers = {
    Accept: 'application/json;api-version=6.1-preview.1;',
    'Content-Type': 'application/json',
    'user-agent': 'VSCode',
  };
  const body = JSON.stringify({
    filters: [
      {
        criteria: [
          {
            filterType: 4,
            value: '3a15b5a7-be12-47e3-8445-88ee3eabc8b2',
          },
        ],
      },
    ],
    flags: 950,
  });
  let response: Response;
  try {
    response = await fetch('https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery ', {
      method: 'POST',
      headers: headers,
      body: body,
      timeout: 10e3,
    });
  } catch (err) {
    window.showErrorMessage(`[coc-sumneko]: Request failed! Please check your internet!`);
    console.error(err);
    return;
  }

  if (!response.ok) {
    console.error(await response.text());
    return;
  }

  const targetPlatform = `${os.platform()}-${os.arch()}`;

  const release = await response.json();

  const extension = release.results[0].extensions[0].versions[0];

  return {
    version: extension.version,
    url: `${extension.assetUri}/Microsoft.VisualStudio.Services.VSIXPackage?redirect=true&targetPlatform=${targetPlatform}&install=true`,
  };
}

export async function downloadServer(context: ExtensionContext, release?: Release): Promise<void> {
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

  const resp = await fetch(release.url, {
    headers: {
      'user-agent': 'VSCode',
    },
  });
  if (!resp.ok) {
    statusItem.hide();
    throw new Error('Download failed! Maybe the provided target platform is not supported for now');
  }

  const buffer = await resp.buffer();

  const targetPath = path.join(context.storagePath, ls_name);
  const tempDir = await fs.mkdtemp(ls_name);
  const extTempFile = path.join(tempDir, ls_name);

  statusItem.text = `Writing temp file ${extTempFile}`;
  await fs.writeFile(extTempFile, buffer);

  statusItem.text = `Removing old files`;
  await fs.remove(targetPath);

  statusItem.text = `Extracting to ${targetPath}`;
  await extract(extTempFile, { dir: targetPath });

  const binPath = path.join(targetPath, 'extension', 'server', 'bin', 'lua-language-server');
  if (fs.existsSync(binPath)) {
    await fs.chmod(binPath, '777');
  }

  statusItem.text = `Removing temp file ${extTempFile}`;
  await fs.remove(tempDir);

  window.showMessage(`Installed ${targetPath} successfully`);
  statusItem.hide();
}
