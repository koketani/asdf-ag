<div align="center">

# asdf-ag [![Build](https://github.com/koketani/asdf-ag/actions/workflows/build.yml/badge.svg)](https://github.com/koketani/asdf-ag/actions/workflows/build.yml) [![Lint](https://github.com/koketani/asdf-ag/actions/workflows/lint.yml/badge.svg)](https://github.com/koketani/asdf-ag/actions/workflows/lint.yml)


[ag](https://geoff.greer.fm/ag/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add ag
# or
asdf plugin add ag https://github.com/koketani/asdf-ag.git
```

ag:

```shell
# Show all installable versions
asdf list-all ag

# Install specific version
asdf install ag latest

# Set a version globally (on your ~/.tool-versions file)
asdf global ag latest

# Now ag commands are available
ag --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/koketani/asdf-ag/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [koketani](https://github.com/koketani/)
