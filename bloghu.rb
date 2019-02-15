require "nokogiri"
require "httparty"

def main
	pager
end

def get_url
	"https://hogyvolt.blog.hu"
end

def build_url page
	get_url + "/page/" + page.to_s
end

def pager
	(0...1195).each do | page |
		parse_listing_page page
	end
end

def parse_listing_page url
	Nokogiri::HTML(HTTParty.get(build_url(url))).css("h1.title > a").each do |link|
		parse_article_page link["href"]
	end
end

def parse_article_page url
	article = Nokogiri::HTML(HTTParty.get(url))
	title = article.css("article.post h1.title > a").text
	date = article.css("article.post span.date").text
	author = article.css("article.post span.author > a").text
	content = article.css("article.post div.entry").text

	puts title
	puts date
	puts author
	#puts content
end

main
