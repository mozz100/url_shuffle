require 'fileutils'
require 'find'

# Get directory name
default_dir_name = "new_url_structure"
puts "Enter input directory name (#{default_dir_name}):"
input_dir_name = STDIN.gets().chomp
input_dir_name = default_dir_name if input_dir_name.empty?

output_file_name = "redirects.csv"
puts "Creating output CSV file..."
File.open(output_file_name, "w") do |output_file|
  output_file.puts "FROM,TO"   # headers for the CSV file
  Find.find(input_dir_name) do |f|
    if f.match(/\.txt\Z/)

      # Trim the .txt off the end of the filename to get the desired URL
      desired_url = f[input_dir_name.length..-" .txt".length]

      # handle index pages.  If the last two parts are the same, this is an index page
      # i.e. handle /lonestar/lonestar.txt as /lonestar
      parts = desired_url.split("/")
      if parts[-1] == parts[-2]
        desired_url = parts[0..-2].join("/")
      end

      # read the contents of the file. This contains the old URL
      existing_url = File.open(f,"r").read.chomp

      # if the URL has changed, then note this into the CSV file
      output_file.puts existing_url + "," + desired_url if existing_url != desired_url
    end
  end
end

puts "Finished."