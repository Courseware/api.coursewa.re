desc 'Generates API documentation'
task 'docs:api' do
  require 'json'
  require 'net/https'
  require 'erb'

  output_filename = File.expand_path(ENV['OUTPUT_FILE'] || 'public/index.html')
  filename = File.expand_path(
    ENV['FILE'] || 'doc/api_documentation.md', './')
  template_filename = File.expand_path(
    ENV['TEMPLATE'] || 'doc/templates/template.html.erb', './')

  url = URI.parse('https://api.github.com/markdown')
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(url.path.to_s)
  params = {:text => nil, :mode => :gfm}
  begin
    template = File.read(template_filename)
    params[:text] = File.read(filename)
    request.body = params.to_json
    response = http.start {|http| http.request(request) }

    if response.code != '200'
      puts 'There was an error!' and return
    end

    output = ERB.new(template).result(binding)
    puts('File: %s updated.' % output_filename) if File.write(output_filename, output)
  rescue Exception => ex
    puts 'ERROR: %s.' % ex.message
  end
end
