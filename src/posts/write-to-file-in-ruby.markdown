---
title: Safely write a file in ruby
---

Why do I always need to google this?!

```ruby
  require 'fileutils'

  path_to_write = "/my/path/file.txt"

  # ensure the directory /my/path exists first
  FileUtils.mkdir_p path_to_write.split("/")[0..-1].join("/")

  File.write(path_to_write, "Hello world!")
```
