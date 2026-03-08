not used anymore see https://github.com/BeLeap/nix-configuration

# chezmoi

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply beleap
```

# `~/.chezmoi_hostmeta.toml`

```toml
airgapped = false
personal = true
```

Caveat: run `chezmoi init` twice after changing value.
