require 'webmock'
                               
include WebMock::API           

WebMock.enable!                

# Mocking requests             
stub_request(                  
  :get,
  'www.shastic-challenge.fake-data.com'
).to_return(
  body: File.read(File.expand_path('../public/sample.json', __FILE__))
) 
