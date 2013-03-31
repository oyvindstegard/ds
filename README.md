README - ds
===========

ds is a command line tool for manual, but quick and easy one-way
syncing/mirroring of pre-configured data sets to/from remote hosts. It primarily
uses rsync(1) and ssh(1) to accomplish its tasks. GConf and dconf sync requires
a typical Linux desktop installation (optional).

The script is mainly a convenient wrapper around rsync, allowing you to define
named sets of data (typically files/directories under your $HOME directory) in a
simple, flexible and easily readable config file format. These `sync items' can
then be pushed or fetched to/from remote hosts with ease. It is meant to be used
interactively and has support for generating Bash-compatible command line
auto-completion code. Ds itself is written in POSIX compliant plain Bourne shell
and is compatible with for instance dash, which runs much faster than standard
GNU bash. Dash also happens to be the default `/bin/sh' implementation on
Ubuntu/Debian.

The only documentation currently available is the built-in help:
    $ ds -H          # detailed help

To get a rather elaborte configuration file example, issue:
    $ ds conf example


Configuration and usage example
-------------------------------

    $ cat ~/.ds.conf              # contents of a minimal config file
    # Default host to sync to/from
    default_host host.net

    # The Foo item, with files/dirs relative to $HOME
    # Directories are always synced recursively.
    item Foo
      files foofile1 foofile2 foofile3
      dirs foodir1/ bardir2
      group default



    $ ds push Foo to host.net     # update Foo on host.net
    # .. Do stuff with Foo resoures on host.net ..

    $ ds fetch                    # fetch Foo (synced by default) from default host (host.net)

    $ ds log                      # show sync log
    $ ds log remote host.net      # show sync log on remote host host.net

    $ ds -H                       # show detailed help
    $ ds conf example             # show example config


A note about default sync behaviour
-----------------------------------

The default behaviour of ds is to do proper mirroring when pushing or fetching
data. This means that it can delete files or overwrite newer files at the
destination of a synchronization (rsync(1) `--delete' and `-a' options). This is
default behaviour to ensure consistency of typical application configuration
data, but can be overridden in the config either for particular items or
globally. Also, there is no conflict handling, because that is what I consider
out of scope for this tool. Using the sync log, you can determine when and where
an item was last synced and act accordingly. See help and config examples and
make sure you understand it.
