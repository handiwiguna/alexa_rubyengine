# encoding: UTF-8

require 'date'
require 'alexa_rubykit'

class RandomVerseIntent

  attr_reader :response

  VERSES = [
    "John 3 verse 16. For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life",
    "Jeremiah 29 verse 11. For I know the plans I have for you, declares the LORD, plans to prosper you and not to harm you, plans to give you hope and a future",
    "Romans 8 verse 28. And we know that in all things God works for the good of those who love him, who have been called according to his purpose",
    "Philippians 4 verse 13. I can do everything through him who gives me strength",
    "Philippians 4 verse 6. Do not be anxious about anything, but in everything, by prayer and petition, with thanksgiving, present your requests to God",
    "Proverbs 3 verse 6. Trust in the LORD with all your heart and lean not on your own understanding",
    "Romans 12 verse 2. Do not conform any longer to the pattern of this world, but be transformed by the renewing of your mind. Then you will be able to test and approve what Gods will is his good, pleasing and perfect will"
  ]

  def initialize
    @response = AlexaRubykit::Response.new
  end

  def call(request)
    @response.add_speech(VERSES.sample)
    @response
  end

end
