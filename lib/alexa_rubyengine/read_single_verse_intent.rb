require 'rest-client'
require 'alexa_rubykit'

class ReadSingleVerseIntent

  attr_reader :response

  ENDPOINT = "http://api.biblia.com/v1/bible/content/asv.txt.txt"

  def initialize
    @response = AlexaRubykit::Response.new
  end

  def call(request)
    book = request.slots["books"]["value"]
    chapter = request.slots["chapter"]["value"]
    verse = request.slots["verse"]["value"]

    mix = "%s%s:%s" % [book, chapter, verse]

    passage = RestClient.get ENDPOINT, {:params => {:passage => mix , 'key' => 'fd37d8f28e95d3be8cb4fbc37e15e18e'}}
    @response.add_speech(passage)
    @response
  end
end
