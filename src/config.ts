import { workspace } from 'coc.nvim';

export type Locale = 'en-us' | 'pt-br' | 'zh-cn' | 'zh-tw';

export class Config {
  private readonly rootSection = 'sumneko-lua';

  get cfg() {
    return workspace.getConfiguration(this.rootSection);
  }

  get enabled() {
    return this.cfg.get<boolean>('enable');
  }

  get prompt() {
    return this.cfg.get<boolean>('prompt');
  }

  get locale() {
    return this.cfg.get<Locale>('locale');
  }

  get logPath() {
    return this.cfg.get<string>('logPath')!;
  }

  get nvimLuaDev() {
    return this.cfg.get<boolean>('enableNvimLuaDev');
  }

  get checkUpdate() {
    return this.cfg.get<boolean>('checkUpdate');
  }

  get serverDir() {
    return this.cfg.get<string>('serverDir');
  }
}
