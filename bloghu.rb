require "nokogiri"
require "httparty"

(0...1187).each do | page |
	Nokogiri::HTML(HTTParty.get("https://hogyvolt.blog.hu/page/" + page.to_s)).css("h1.title > a").each do |link|
		article = Nokogiri::HTML(HTTParty.get(link["href"]))
		puts "Title: " + article.css("h1.title > a").text
		puts "Date: " + article.css("article.post span.date").text
		puts "Author: " + article.css("article.post span.author > a").text
		#puts "Content: " + article.css("article.post div.entry").text
		puts "--------------------"
	end
end
