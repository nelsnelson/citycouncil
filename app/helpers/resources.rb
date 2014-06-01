
module Sinatra::Resources
  def verify(resource)
    path = "#{settings.root}/views/#{resource}"
    raise Sinatra::NotFound unless (File.exists?(path) or Dir.exists?(path))
    resource
  end
end

helpers Sinatra::Resources

