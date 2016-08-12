require 'oauth2'

class WelcomeController < ApplicationController
  before_action :setup_client

  def index
    @controller_message =  10
    @controller_message2 =  20  

    options = {}
    #def method for oauth 
    # these should be changed / omitted from example code
    
    # => OAuth2::Response"

    @workspaces = @client.list_workspaces

    #def method for uploading 

    #rescue OAuth2::Error => ex
    #  puts "Exception! #{ex}"

    # pathname = File.join(Rails.root, 'public/test3.csv')

    # # local file name ./logo_onehub_ws.png will be stored in folder FOLDER_ID as 'foo1.png'
    # upload = Faraday::UploadIO.new(File.new(pathname, 'rb'), 'application/octet-stream', 'foo1.png')

    # payload = {
    #   :file =>  {
    #     :name => File.basename(pathname),
    #     :'form-data' => upload
    #   }
#}


    # File.open(pathname, 'w') { |file| file.write(@formvar) }   # overwrites data before its uploaded 




#if mystring.include? "file2"
 #  @test = "text"
#end
   





    file_id = params[:file_id] || 890157

    @coords = @client.download_file(4547, file_id)
    @point1 = @coords.split(',')

    @uploaded_filename = flash[:uploaded_filename]
  end

  def create
    file = params[:file_upload]

    flash[:uploaded_filename] = file.original_filename
    
    @client.upload(file)

    redirect_to controller: :welcome, action: :index
  end

  protected

  def setup_client
    @client = Onehub.new('mitchfade11@gmail.com', 'weenie123')
  end
end
