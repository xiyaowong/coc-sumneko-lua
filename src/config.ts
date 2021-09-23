import { workspace, WorkspaceConfiguration } from 'coc.nvim';

export type Locale = 'en-us' | 'zh-cn';

export class Config {
  private readonly rootSection = 'sumneko-lua';
  private cfg: WorkspaceConfiguration;

  constructor() {
    this.cfg = workspace.getConfiguration(this.rootSection);
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

  get inlayHints() {
    const hasVirtualText = workspace.isNvim && workspace.nvim.hasFunction('nvim_buf_set_virtual_text');
    return {
      enable: hasVirtualText && workspace.getConfiguration('Lua.hint').get<boolean>('enable', false),
      typeHintsPrefix: this.cfg.get<string>('inlayHints.typeHintsPrefix', '« '),
      paramHintsPrefix: this.cfg.get<string>('inlayHints.paramHintsPrefix', '» '),
      trimSemicolon: this.cfg.get<boolean>('inlayHints.trimSemicolon', true),
      refreshOnInsertMode: hasVirtualText && this.cfg.get<boolean>('inlayHints.refreshOnInsertMode', false),
    };
  }
}
