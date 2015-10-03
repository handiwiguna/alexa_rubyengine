require 'rest-client'
require 'alexa_rubykit'

class TopicalIntent

  attr_reader :response

  ENDPOINT = "http://api.biblia.com/v1/bible/content/asv.txt.txt"

  TOPICS = {
    "faith" => [
      "Romans10:17",
      "Matthew21:22",
      "Hebrews11:6",
      "James2:19",
      "Mark11:22-24",
      "Ephesians2:8-9",
      "Luke1:37",
      "Hebrews11:1",
      "Ephesians2:8"
    ]
  }

  def initialize
    @response = AlexaRubykit::Response.new
  end

  def call(request)
    topic = request.slots["topic"]["value"].downcase
    verse = TOPICS[topic].sample

    passage = RestClient.get ENDPOINT, {:params => {:passage => verse , 'key' => 'fd37d8f28e95d3be8cb4fbc37e15e18e'}}
    @response.add_speech(passage)
    @response
  end
end
