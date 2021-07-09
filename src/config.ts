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
}
