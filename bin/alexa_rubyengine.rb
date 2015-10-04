# encoding: UTF-8

require 'sinatra'
require 'json'
require 'bundler/setup'
require 'alexa_rubykit'
require 'alexa_rubyengine'

before do
  content_type('application/json')
end

#enable :sessions
post '/' do
  request_json = JSON.parse(request.body.read.to_s)
  request = AlexaRubykit.build_request(request_json)

  #p "#{request.to_s}"
  #p "#{request.request_id}"

  session = request.session
  p session.new?
  p session.has_attributes?
  p session.session_id
  p session.user_defined?

  response = AlexaRubykit::Response.new

  if (request.type == 'LAUNCH_REQUEST')
    response.add_speech('Ruby running ready!')
  end

  if (request.type == 'INTENT_REQUEST')
    clazz = Object.const_get(request.name)
    response = clazz.new.call(request)
  end

  if (request.type =='SESSION_ENDED_REQUEST')
    p "#{request.type}"
    p "#{request.reason}"
    halt 200
  end

  response.build_response
end
