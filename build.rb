require 'redcarpet'
require 'fileutils'

def clean_dist
  FileUtils.rm_rf('dist')
end

def convert_markdown_and_copy
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
  header = File.read("src/_header.html")

  Dir.glob("src/**/*.markdown").each do |file|
    next if file.split("/").pop[0] == "_" # skip files starting with underscore

    contents = File.read(file)
    file_html = markdown.render(contents) 

    output_html = "<!DOCTYPE html>
    <html>
    #{header}
    <body>
      <div class='contents'>#{file_html}</div>
    </body>
    </html>
    "


    write file, "html", output_html
  end
end

def concatenate_css_and_copy
  full_style = Dir.glob("src/**/*.css").map{|file| File.read file }.join

  write "src/styles.css", "css", full_style
end

def write file, extension, contents
  filename = file.split("/").pop.split(".").first
  input_dir = file.split("/")[1...-1].join("/")
  output_dir = File.join "dist", input_dir
  destination = File.join(output_dir, "#{filename}.#{extension}")

  FileUtils.mkdir_p output_dir
  File.write(destination, contents)
end


clean_dist
convert_markdown_and_copy
concatenate_css_and_copy