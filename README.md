# my-zsh
This is a simple shell script to setup my personal zsh environment.

This shell script only installs this plugin:

- git-prompt: https://github.com/woefe/git-prompt.zsh

**Note**: I add additional completion definitions for ZSH and command sugestion, installing these packages
through my Linux package manager:

- `zsh-completions`: https://github.com/zsh-users/zsh-completions
- `zsh-autosuggestions`: https://github.com/zsh-users/zsh-autosuggestions

## Usage

```bash
 ./my-zsh.sh [-s|-u|-r]
```

Options:

- `-s`: setup `zshrc` config file and install plugins.
- `-u`: update all zsh plugins.
- `-r`: remove zsh setup and all plugins installed thru this script.
