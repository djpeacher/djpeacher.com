---
title: 'Python Version Manager 101 (pyenv)'
description: 'If you are trying to use "System Python" or manually install other versions, you could be saving yourself a lot of grief by using a version manager instead.'
date: 2022-02-28
---

When you boot up a new machine, it will usually come preinstalled with a version of Python. You can verify this by running the following:

```
# This shows the version installed.
$ python -V
Python 2.7.18

# This shows the location of the installation.
$ which python
/usr/bin/python
```

That's great, but **do not use "System Python."** It came with your operating system because it is a dependency that should not be tampered with. Doing so could harm your system or the very least, cause you a lot of grief down the road.

You could work around this by manually installing other versions of Python, but that is hard to manage and can get messy fast, especially if you have multiple projects depending on **different** versions of Python.

Instead of dealing with all that, you might want to invest of few minutes setting up a **Python Version Manager**, in this case, `pyenv`, that will let you easily switch between multiple versions of Python.

If that sounds good to you, continue reading to learn how to install and use `pyenv`.

## Installation

I'm not going to get super specific on the installation of `pyenv` because it depends on the machine you are working with. These instructions are what got me set up on my specific machine (M1 Mac using Zsh), so your mileage may vary. Here are the official instructions if these don't work for you.

- [homebrew](https://brew.sh), the missing package manager for macOS.
- [pyenv](https://github.com/pyenv/pyenv#installation), the python version manager.
- [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv#installation), a virtualenv plugin for `pyenv`.

### Dependencies

Before you can install `pyenv`, you need to install all its dependencies.

```
# Install Xcode Command Line Tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'export PATH=/opt/homebrew/bin:$PATH' >> ~/.zshrc

# Install Python build dependencies
brew install openssl readline sqlite3 xz zlib
```

### Install `pyenv`

Now we can install `pyenv` using `brew` and configure your terminal to let `pyenv` dictate which version of Python you are using.

```
# Install pyenv
brew install pyenv pyenv-virtualenv

# Configure shell environment
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
echo 'if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi' >> ~/.zprofile
```

You know you've set everything up correctly if you see the following:

```
# You've installed pyenv!
$ pyenv --version
pyenv 2.2.4

# pyenv put itself between your system and terminal!
# Notice that the installation path is different now.
$ which python
/Users/<user>/.pyenv/shims/python
```

## Usage

With `pyenv` installed, we can do some powerful stuff!

- Install pretty much whatever version of Python we want.
- Create virtualenvs that act like separate Python installations.
- Set the global, local, and shell versions of Python we want to use.

### How It Works

By default, `pyenv` will use "System Python," which as I mentioned we shouldn't use, so we need to install other versions. When you install a new version of Python using `pyenv`, it stores them in its root directory (`~/.pyenv`).

After we install the versions of Python we want, we need to tell `pyenv` where and when we want to use each version by using the `global`, `local`, and `shell` commands.

- When we use the `global` command, we are setting the global Python version. `pyenv` records this information in this file `~/.pyenv/version`.
- When we use the `local` command, we are setting the local application-specific Python version. This will apply to all its subdirectories as well! `pyenv` records this information by creating a file in the current directory called `.python-version`.
- When we use the `shell` command, we are setting the shell-specific Python version. `pyenv` records this information by setting the `$PYENV_VERSION` environment variable.

#### So how does `pyenv` decide which version to use?

As we move between directories `pyenv` searches for the files and environment variable we set above and processes them in the following order:

1. `$PYENV_VERSION`. This version will be used if set.
2. `.python-version`. This version will be used if this file exists.
3. `~/.pyenv/version`. This version will be used if this file exists.
4. If none of these exist, it will use "System Python".

#### What about virtualenvs?

Working with virtualenvs is extremely simple. All we have to do is use the `virtualenv` command and specify the version of Python we want to use. `pyenv` then creates the virtualenv it's root directory which we can use with the `global`, `local`, and `shell` commands, just like the full Python installations!

And if you configured your shell correctly, you don't even have to run any `activate` or `deactivate` commands, `pyenv` will handle that when you enter and leave directories.

### Command Overview

Now that you have a basic understanding of how `pyenv` works, here is an overview of its available commands.

#### `install`

Install a Python version using python-build. `pyenv` builds each installation from source, so it could be a few seconds for this command to complete.

```
$ pyenv install 3.10.2
```

#### `uninstall`

Uninstall a specific Python version.

```
$ pyenv uninstall 3.10.2
```

#### `versions`

List all Python versions available to pyenv.

```
$ pyenv versions
  system
* 3.10.2 (set by /Users/<user>/.pyenv/version)
```

Notice that there is a `*` indicating what is the active version of Python and it tells you how `pyenv` decided to use that version.

#### `global`

Set or show the global Python version.

```
$ pyenv global
system

$ pyenv global 3.10.2
$ pyenv global
3.10.2
$ python -V
Python 3.10.2
```

This will update the `/Users/<user>/.pyenv/version` file.

#### `local`

Set or show the local application-specific Python version.

```
$ pyenv local
pyenv: no local version configured for this directory

$ pyenv local 3.10.2
$ pyenv local
3.10.2
$ python -V
Python 3.10.2
```

This will create or update the `.python-version` file in the current directory.

#### `shell`

Set or show the shell-specific Python version.

```
$ pyenv shell
pyenv: no shell-specific version configured

$ pyenv shell 3.10.2
$ pyenv shell
3.10.2
$ python -V
Python 3.10.2
```

This will set the `$PYENV_VERSION` environment variable.

#### `virtualenv`

Creates a Python virtualenv in the `pyenv` root directory.

```
$ pyenv virtualenv [version] <name>
```

If no version number is given, the current active version will be used. You can name the virtualenv whatever you want, but it is best practice to name it the same as the relevant project.

#### `virtualenv-delete`

Uninstall a specific Python virtualenv.

```
$ pyenv virtualenv-delete <name>
```

#### `virtualenvs`

List all Python virtualenvs.

```
$ pyenv virtualenv project
$ pyenv virtualenvs
  3.10.2/envs/project (created from /Users/<user>/.pyenv/versions/3.10.2)
  project (created from /Users/<user>/.pyenv/versions/3.10.2)
```

You will see two entries per virutalenv (`pyenv versions` does the same thing). In this example, `3.10.2/envs/project` is the actual virtualenv and `project` is a shorthand simlink to that folder.

Once a vitualenv is created, we can use it along with the `global`, `local`, and `shell` commands!

```
$ pyenv local project
$ pyenv local
project
```

## Conclusion

I hope by reading this post you see how useful having a version manager like `pyenv` can be and were able to get up and running quickly. I know I sure have!

If you have any feedback, click the button below. I'd love to hear from you!
