Dir[File.join(File.dirname(__FILE__), "../lib", "*.rb")].each {|f| require f}


RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  #you can do global before/after here like this:
  #config.before(:each) do
  #  #code
  #end
end
