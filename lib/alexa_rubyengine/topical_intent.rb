require 'rest-client'
require 'alexa_rubykit'

class TopicalIntent

  attr_reader :response

  ENDPOINT = "http://api.biblia.com/v1/bible/content/asv.txt.txt"

  TOPICS = {
    "faith" => [
      { "Romans10:17" => "Romans 10 verse 17" },
      { "Matthew21:22" => "Matthew 21 verse 22" },
      { "Hebrews11:6" => "Hebrews 11 verse 6" },
      { "James2:19" => "James 2 verse 19" },
      { "Mark11:22-24" => "Mark 11 verse 22 to 24" },
      { "Ephesians2:8-9" => "Ephesians 2 verse 8 to 9" },
      { "Luke1:37" => "Luke 1 verse 37" },
      { "Hebrews11:1" => "Hebrews 11 verse 1" },
      { "Ephesians2:8" => "Ephesians 2 verse 8" }
    ]
  }
  #
  #
  # TOPICS = {
  #   "faith" => [
  #     "Romans10:17",
  #     "Matthew21:22",
  #     "Hebrews11:6",
  #     "James2:19",
  #     "Mark11:22-24",
  #     "Ephesians2:8-9",
  #     "Luke1:37",
  #     "Hebrews11:1",
  #     "Ephesians2:8"
  #   ]
  # }

  def initialize
    @response = AlexaRubykit::Response.new
  end

  def call(request)
    topic = request.slots["topic"]["value"].downcase
    hash = TOPICS[topic].sample
    key = hash.keys.first
    verse = hash[key]

    passage = RestClient.get ENDPOINT, {:params => {:passage => key , 'key' => 'fd37d8f28e95d3be8cb4fbc37e15e18e'}}
    @response.add_speech("%s. %s" % [verse, passage])
    @response
  end
end
