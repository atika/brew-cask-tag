#!/usr/bin/ruby

# https://github.com/atika/brew-cask-tag

tagname="Cask App"

tagapp=`which tag`.strip
if tagapp.empty? then
	puts "\e[31mtag\e[0m - app not found, install with: brew install tag"
	exit(1)
end

casks=`brew cask list`.strip.split
casks.each { |app|
	appinfo = `brew cask list #{app}`	
	if appname = /\/Applications\/(.*)\.app/.match(appinfo)
		appname = "#{appname[1]}.app"
		apppath = File.join("/Applications", appname)
		if File.exists?(apppath) then
			puts "[ \e[32mOK\e[0m ] #{appname}"
			system("#{tagapp} -a \"#{tagname}\" \"#{apppath}\"")
		else
			puts "[ \e[31mFAILED\e[0m ] App not found #{appname}."
		end
	else
		puts "[ \e[31mFailed\e[0m ] App (#{app}) not found or not in Application folder"
	end
}