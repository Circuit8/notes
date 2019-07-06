require 'redcarpet'
require 'fileutils'

def has_ext? file, extension
  file.split(".").pop == extension
end

def convert_markdown_and_copy file, header, markdown
  contents = File.read(file)
  file_html = markdown.render(contents) 

  output_html = "<!DOCTYPE html>
  <html>
  #{header}
  <body>#{file_html}</body>
  </html>
  "

  filename = file.split("/").pop.split(".").first
  input_dir = file.split("/")[1...-1].join("/")
  output_dir = File.join "dist", input_dir
  output_file_path = File.join output_dir, "#{filename}.html"

  write output_dir, output_file_path, output_html
end

def copy_normal file
  filename = file.split("/").pop
  input_dir = file.split("/")[1...-1].join("/")
  output_dir = File.join "dist", input_dir
  output_file_path = File.join output_dir, filename

  write output_dir, output_file_path, File.read(file)
end

def write dir, path, contents
  puts path

  FileUtils.mkdir_p dir
  File.write(path, contents)
end

FileUtils.rm_rf('dist')
markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
header = File.read("src/_header.html")

Dir.glob("src/**/*").each do |file|
  if has_ext? file, "markdown"
    convert_markdown_and_copy file, header, markdown
  elsif has_ext? file, "css"
    copy_normal file
  end
end