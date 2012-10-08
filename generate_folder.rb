require 'fileutils'
@@existing_urls = []

# create a timestamped folder
output_fldr_name = "urls_" + Time.now.strftime("%Y%m%d_%H%M%S")
Dir.mkdir(output_fldr_name)

# load existing_urls.txt into memory, 1 line at a time.
# perform chomp to get rid of trailing whitespace/newlines added by windows
File.open("existing_urls.txt").each{|url|  @@existing_urls << url.chomp }

def is_index_page?(test_url)
  # return true if this path is found as a subpath elsewhere in the existing urls.
  # For example, if /lonestar exists and so does /lonestar/technology, then /lonestar is an index page
  @@existing_urls.select{|u| u.start_with?(test_url + "/")}.length > 0
end

Dir.open(output_fldr_name) do |output_dir|
  puts "Created #{output_dir.path}..."

  @@existing_urls.each do |existing_url|
    # split URL into parts on /
    parts = existing_url.split("/").map(&:chomp)

    # if it's an index page, double up on the last part so /lonestar ends up as /lonestar/lonestar.txt
    parts << parts[-1] if is_index_page?(existing_url)

    # for all except the last part, create the directory tree (mkdir -p)
    if parts[1..-2].length > 0
      FileUtils.mkdir_p(File.join([output_fldr_name] + parts[1..-2]))
    end
    
    # place a text file into the directory
    # its name should equal the last part of the URL
    File.open(File.join([output_fldr_name] + parts[1..-1]) + ".txt", "w") do |output_file|
      # put the original url inside the text file
      output_file.write(existing_url)
    end
  end

end

puts "Finished."