# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

Thread.new do 
	while true do
		sleep 10.minutes
    	Rails.cache.write("beer top 3", Beer.top(3))
    	Rails.cache.write("brewery top 3", Brewery.top(3))
    	Rails.cache.write("style top 3", Style.top(3))
    	Rails.cache.write("user most active 3", User.most_active(3))
    	Rails.cache.write("all ratings", Rating.all)
  	end
end
