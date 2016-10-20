###
# Pretty Urls
###
activate :directory_indexes

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

page "about.html.erb", :layout => false
page "live.html.erb", :layout => false
page "links.html.erb", :layout => false
page "contact.html.erb", :layout => false
page "preorder.html.erb", :layout => false
page "dallas-acid-preorder.html.erb", :layout => false
page "erin-durant-preorder.html.erb", :layout => false

# Assumes the file source/about/template.html.erb exists
["dallas-acid", "muyassar-kurdi","ed-askew", "erin-durant", "tim-kuhl",
 "george-sand", "hairy-sands", "kyle-forester"].each do |name|
  proxy "/artists/#{name}.html", "/artist.html", :locals => { :artist_name => name }, :ignore => true
end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'img'

## Build Instagram directory
def get_media_for_tag(client, tag)
  tags = client.tag_search(tag)
  images = []
  for media_item in client.tag_recent_media(tags[0].name)
    images << media_item.images.low_resolution.url
  end
  images
end   

def get_media_for_user(client)
  user = 'jaypluck@gmail.com'
  images = Array.new
  for media_item in client.user_recent_media
    images << media_item.images.thumbnail.url
  end
  images
end 

def get_instagram_photos()
  require 'instagram'
  
  Instagram.configure do |config|
    config.client_id = "ce0b97d852a248a9a7b3d7681ab2fd31"
    config.client_secret = "16d647f98b79437f8cad4ba593cd93a6" 
  end

  client = Instagram.client()
  
  tags = [
    'flyingmoonlight',
    'muyassarkurdi',
    'georgesand',
    'hairysands',
    'dallasacid',
    'timkuhl',
    'edaskew'
  ]

  images = Hash[tags.map {|tag| [tag, get_media_for_tag(client, tag)]}]
  photos_yml_file images 
end 

def photos_yml_file(images)
  require 'yaml'
  File.open('data/photos.yml', 'w') {|f| f.write images.to_yaml }
end 

# get_instagram_photos()

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = 'flyingmoonlight.com'
  deploy.path   = '/srv/www/flyingmoonlight.com/public_html'
  deploy.user  = 'hcnewsom' # no default
  deploy.port  = 22
  deploy.clean = true # remove orphaned files on remote host, default: false
end
