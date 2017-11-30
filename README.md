# 🏡 Dotfiles

These are not intended for use by anyone but me, that being said feel free to
take them and make them your own.

![A screenshot of the terminal after setup](https://imgur.com/a/hA3FR)

## ✨ Init

Simply kickoff the ol' init script, browse the `init` folder to see what it
sets. Innit nice?: `curl --silent
https://raw.githubusercontent.com/jssee/dotfiles/master/init/init | sh`

after the script does its thing, you should be left with a `.dotfiles` folder in
your home directory and youre pretty much done. For the most part, I'm utilizing
[dotbot](https://github.com/anishathalye/dotbot) to manage my dotfiles, with
some light bash scripts to boostrap the whole thing on a new system. The init
script _should_ only be used to set up a new system, after that dotbot takes
over. But I don't think anything "bad" will happen if you run it again.

## 💅 Features

* syntax highlighting in the terminal
* a tasteful vim setup
* a sensible tig config
* some handy alias' but nothing crazy
* some nifty functions, like `z`
* a pretty prompt, via Pure by Sindre Sorhus
* hipster version management via asdf-vm
