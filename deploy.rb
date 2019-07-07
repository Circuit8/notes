#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'aws-sdk'
require 'yaml'

class S3FolderUpload
  attr_reader :folder_path, :total_files, :s3_bucket
  attr_accessor :files

  def initialize(folder_path, bucket)
    aws_credentials = YAML.load(File.open("./aws_credentials.yaml"))
    
    @client            = Aws::S3::Client.new({
      access_key_id: aws_credentials["access_key_id"],
      secret_access_key: aws_credentials["secret_access_key"],
      region: "eu-west-2"
    })
    @folder_path       = folder_path
    @files             = Dir.glob("#{folder_path}/**/*")
    @total_files       = files.length
    @bucket            = bucket
  end

  def upload!(thread_count = 5)
    file_number = 0
    mutex       = Mutex.new
    threads     = []

    puts "No files to upload!" if @files.empty?

    thread_count.times do |i|
      threads[i] = Thread.new {
        until files.empty?
          mutex.synchronize do
            file_number += 1
            Thread.current["file_number"] = file_number
          end
          file = files.pop rescue nil
          next unless file

          data = File.open(file)

          if File.directory?(data)
            data.close
            next
          else
            key = file.split("/")[1..-1].join("/")
            puts "#{file} --> #{key}"
            @client.put_object({
              acl: "public-read", 
              body: data, 
              bucket: @bucket, 
              key: key,
            })
          end
        end
      }
    end
    threads.each { |t| t.join }
  end
end


uploader = S3FolderUpload.new('dist', 'circuit8')
uploader.upload!

puts "\n  Deployed!"
puts "  http://circuit8.s3-website.eu-west-2.amazonaws.com/"
