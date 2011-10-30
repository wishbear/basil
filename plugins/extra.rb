#
# Simple echo
#
Basil::Plugin.respond_to(/^echo (.*)/) {

  says @match_data[1]

}.description = "echos what it's told"

#
# Google for something
#
Basil::Plugin.respond_to(/^g(oogle)? *(.*)$/) {

  require 'cgi'
  require 'json'
  require 'net/http'

  url  = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=#{CGI::escape(@match_data[2])}"
  resp = Net::HTTP.get_response(URI.parse(url))
  json = JSON.parse(resp.body)

  results = json['responseData']['results'] rescue []

  if results.empty?
    replies "Nothing found."
  else
    result = results.first
    replies "#{result['url']} - #{result['title']}"
  end

}.description 'googles for some phrase'