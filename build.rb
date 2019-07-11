require 'rubygems'
require 'bundler/setup'

require 'redcarpet'
require 'fileutils'
require 'htmlbeautifier'
require 'yaml'

def clean_dist
  FileUtils.rm_rf('dist')
end

def convert_markdown_and_copy
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
  head = File.read('src/_head.html')
  header = File.read('src/_header.html')

  Dir.glob('src/**/*.markdown').each do |file|
    next if file.split('/').pop[0] == '_' # skip files starting with underscore

    contents = File.read(file)

    if contents[0..2] == '---'
      end_of_config_index = contents[3..-1].index('---') + 3
      config_string = contents[3...end_of_config_index]
      config = YAML.safe_load(config_string)
      # puts config
      contents = contents[end_of_config_index + 3..-1]
    end

    file_html = markdown.render(contents)

    page_title = "<h2>> #{config['title']}</h2>" if config['title']

    created_at = Time.at(File.ctime(file)).strftime('%m/%d/%Y')

    output_html = "<!DOCTYPE html>
    <html>
    #{head}
    <body>
      #{header}
      <div class='title'>
        #{page_title}
        <div class='metadata'>
          <div class='metadatum'>Created #{created_at}</div>
        </div>
      </div>
      <div class='contents'>#{file_html}</div>
    </body>
    </html>
    "

    write file, 'html', HtmlBeautifier.beautify(output_html)
  end
end

def concatenate_css_and_copy
  full_style = Dir.glob('src/**/_*.css').map { |file| File.read file }.join
  full_style += File.read 'src/style/styles.css'

  write 'src/styles.css', 'css', full_style
end

def copy_js
  Dir.glob('src/**/*.js').each do |file|
    contents = File.read file
    write file, 'js', contents
  end
end

def write(file, extension, contents)
  filename = file.split('/').pop.split('.').first
  input_dir = file.split('/')[1...-1].join('/')
  output_dir = File.join 'dist', input_dir
  destination = File.join(output_dir, "#{filename}.#{extension}")

  FileUtils.mkdir_p output_dir
  File.write(destination, contents)
end

puts 'Building...'
clean_dist
convert_markdown_and_copy
concatenate_css_and_copy
copy_js
puts 'Built!'
