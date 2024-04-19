# ~/.config/etc

<!-- spellcheck-off -->

This folder contains files that are installed to `/etc` and `/usr/local/etc` by
various Makefiles.

## man.conf(5)

Installs custom paths and tools for [man.conf(5)] in `/etc`.

macOS-only; assumes Homebrew installed in `/usr/local`.

```sh
brew install diffutils groff less xz
make -C $XDG_CONFIG_HOME/etc/man.conf install
```

[man.conf(5)]: https://man.openbsd.org/man.conf.5

## dnsmasq

Installs [dnsmasq] configuration to `/etc/dnsmasq.d` and `/etc/resolver` which
enables a local `.test` TLD on my home network. My browser history is much more
navigable with `foo.test`, `bar.test`, `baz.test` vs. a billion entries all
under `localhost`.

```sh
brew install dnsmasq
make -C $XDG_CONFIG_HOME/etc/dnsmasq install
```

[dnsmasq]: https://dnsmasq.org/doc.html

## pam-watchid

Installs a [pam(8) plugin] to allow `sudo` authentication via Apple Watch. ⌚️

Must be re-installed after every OS update.

```sh
make -C $XDG_CONFIG_HOME/etc/pam.d install
```

[pam(8) plugin]: https://github.com/zgracem/pam-watchid

## ssh_config(5) & sshd_config(5)

Installs custom [ssh_config(5)] and [sshd_config(5)] files into
`/etc/{ssh,sshd}_config.d`, mostly per [this venerable wisdom][sssh].

```sh
make -C $XDG_CONFIG_HOME/etc/ssh install
```

[ssh_config(5)]: https://linux.die.net/man/5/ssh_config
[sshd_config(5)]: https://linux.die.net/man/5/sshd_config
[sssh]: https://stribika.github.io/2015/01/04/secure-secure-shell.html

## sudoers(5)

Installs a custom [sudoers(5)] configuration for me in `/etc/sudoers.d`.

```sh
make -C $XDG_CONFIG_HOME/etc/sudoers.d install
```

[sudoers(5)]: https://linux.die.net/man/5/sudoers
