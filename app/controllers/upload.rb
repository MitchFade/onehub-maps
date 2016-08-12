#! /usr/bin/env ruby
require 'oauth2'

# Set environment variables or use values in this program as necessary
# API_HOST should be 'ws-api.onehub.com' for testing
# API_KEY and SECRET_ACCESS_KEY are obtained by looking at the API Settings tab after logging in (or through obtain_credentials script)

options = {}
ENV['API_HOST'] = 'ws-api.example.com'

# these should be changed / omitted from example code
client_app_id = "lwf2842dgmb3lutuqxhfrejoci9hfj2"
client_app_secret = 's0zd2jdo8x1qik7s8r7r7iyqlfvv2uz'
username = 'mitchfade11@gmail.com'
password = 'weenie123'
options = { :ssl => {:verify_mode => OpenSSL::SSL::VERIFY_NONE }} # OMIT THIS WHEN USED AGAINST ONEHUB.COM


API_HOST = ENV['API_HOST'] || 'ws-api.onehub.com'

client = OAuth2::Client.new(client_app_id, client_app_secret, options.merge({:site => "https://#{API_HOST}"})) do |b|
  b.request :multipart
  b.request :url_encoded
  b.adapter Faraday.default_adapter
end

# the :device field is to uniquely identify the device/application being authorized.

token = client.password.get_token(username, password, :device => 'unique_device_id_0001')

FOLDER_ID = 4547

begin
   pathname = 'tutorial 2.html'

   # local file name ./logo_onehub_ws.png will be stored in folder FOLDER_ID as 'foo1.png'
   upload = Faraday::UploadIO.new(File.new(pathname,'rb'), 'application/octet-stream', 'foo1.png')

   payload = { :file =>  {
                          :name => File.basename(pathname),
                          :'form-data' => upload
                         }
   }
   resp = token.post("/folders/#{FOLDER_ID}/files.json", body: payload)

   puts resp.inspect

rescue OAuth2::Error => ex
  puts "Exception! #{ex}"
end
