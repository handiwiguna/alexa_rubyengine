# encoding: UTF-8

require 'rest-client'
require 'alexa_rubykit'

class ReadVersesIntent

  attr_reader :response

  ENDPOINT = "http://api.biblia.com/v1/bible/content/asv.txt.txt"

  def initialize
    @response = AlexaRubykit::Response.new
  end

  def call(request)
    book = request.slots["books"]["value"]
    chapter = request.slots["chapter"]["value"]
    start = request.slots["start"]["value"]
    endd = request.slots["end"]["value"]

    if start && endd
      mix = "%s%s:%s-%s" % [book, chapter, start, endd]
    else
      mix = "%s%s" % [book, chapter]
    end

    passage = RestClient.get ENDPOINT, {:params => {:passage => mix , 'key' => 'fd37d8f28e95d3be8cb4fbc37e15e18e'}}
    @response.add_speech(passage)
    @response
  end
end
