# my-zsh
This is a simple shell script to setup my personal zsh environment.

At the moment I am using these plugins:

- zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions
- git-prompt: https://github.com/woefe/git-prompt.zsh

## Usage

```bash
 ./my-zsh.sh [-s|-u]
```

Options:

- `-s`: setup `zshrc` config file and install plugins.
- `-u`: update all zsh plugins.

## Note:
I add additional completion definitions for Zsh installing `zsh-completions` package through my
Linux package manager. More information [here](https://github.com/zsh-users/zsh-completions)
