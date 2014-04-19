require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'json'

require './models/card.rb'

class App < Sinatra::Application
  configure do
    # start with a single card
    register Sinatra::Reloader
  end

  get '/cards' do
    # return all in-memory cards
    cards = Card.all
    cards.to_json
  end

  get '/cards/:id' do
    card = Card.find id: params[:id]
    if card.nil?
      halt 400, { message: "Could not find card #{params['id']}" }.to_json
    else
      card.to_json
    end
  end

  put '/cards/:id' do
    card = Card.find id: params[:id]
    if card.nil?
      halt 400, { "message" => "Could not find card #{params['id']}" }
    else
      card.update JSON.parse(request.body.read)
      card.save
      card.to_json
    end
  end

  post '/cards' do
    # add a card read from body
    request.body.rewind
    raw_card = JSON.parse(request.body.read)
    card = Card.new raw_card

    # TODO validation and error handling
    card.save

    message = { "message" => "Card created", "card" => card }
    message.to_json
  end

  # remember that DELETE does not receive a body
  delete "/cards/:id" do
    card = Card.find id: params[:id]
    if card.nil?
      puts "Could not find id #{id_to_delete}"
      halt 400, { "message" => "Could not find card with id #{params[:id]}" }.to_json
    else
      front = card.front
      card.delete
      message = { "message" => "Deleted: #{front}" }
      message.to_json
    end
  end

end
