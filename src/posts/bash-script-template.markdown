---
title: Bash Script Template
---

A small template to begin every bash script.

`set -e` exits immediately on error. Which prevents all hell from breaking loose. Eg if you write a script that fails halfway through, and later parts of the script assume the current working directory is different than it is.

```bash
  #!/bin/sh

  set -e
```
