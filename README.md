# chezmoi

https://chezmoi.io

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://git.sr.ht/~beleap/dotfiles
```

# `~/.chezmoi_hostmeta.toml`

```toml
airgapped = false
personal = true
```

Caveat: run `chezmoi init` twice after changing value.
