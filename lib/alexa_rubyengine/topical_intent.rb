#encoding: UTF-8

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
    ],
    "hope" => [
      { "Jeremiah29:11" => "Jeremiah 29 verse 11" },
      { "John14:14" => "John 14 verse 14" },
      { "Philippians4:6-7" => "Philippians 4 verse 6 to 7" },
      { "2Timothy1:7" => "2 Timothy 1 verse 7" },
      { "Acts17:11" => "Acts 17 verse 11" },
    ],
    "love" => [
      { "1John4:7" => "1 John 4 verse 7" },
      { "1Corinthians10:13" => "1 Corinthians 10 verse 13" },
      { "John14:27" => "John 14 verse 27" },
      { "Genesis2:24" => "Genesisi 2 verse 24" },
      { "Colossians3:5" => "Colossians 3 verse 5" },
    ]
  }

  def initialize
    @response = AlexaRubykit::Response.new
  end

  def call(request)
    topic = request.slots["topic"]["value"].downcase
    hash = TOPICS[topic].sample
    key = hash.keys.first
    verse = hash[key]

    passage = RestClient.get ENDPOINT, {:params => {:passage => key , 'key' => 'fd37d8f28e95d3be8cb4fbc37e15e18e'}}
    passage = passage.encode('ASCII', invalid: :replace, replace: "")
    @response.add_speech("%s. %s" % [verse, passage])
    @response
  end
end
