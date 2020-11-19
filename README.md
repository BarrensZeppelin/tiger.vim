# tiger.vim

Includes:
* filetype detection,
* a very old, modified syntax highlighting file for Tiger,
* and an [ALE](https://github.com/dense-analysis/ale)-linter that uses your own compiler for error detection!

The linter is designed to identify the error messages produced by the Aarhus University Compilers Course Tiger framework.
Using the linter requires you to install ALE, and that the `tigerc` binary is available somewhere on the PATH. The last requirement can be fulfilled by symlinking it into `~/.local/bin`:
```
ln -s <path-to-compiler-repository>/_build/install/default/bin/tigerc ~/.local/bin/tigerc
```
