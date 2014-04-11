require 'rubygems'
require 'sinatra'
require 'json'

require './models/card.rb'

class App < Sinatra::Application
  configure do
    # start with a single card
    raw_card = { "id" => 0, "front" => "What is the capital of India?", "back" => "New Delhi" }
    card = Card.new(raw_card)
    set :cards, [card]
  end

  get '/cards' do
    # return all in-memory cards
    content_type :json
    cards = settings.cards
    cards.to_json
  end

  post '/cards' do
    content_type :json

    # add a card read from body
    cards = settings.cards
    request.body.rewind
    raw_card = JSON.parse(request.body.read)
    raw_card["id"] = cards.length
    card = Card.new raw_card

    # add to in-memory array
    cards << card
    message = { "message" => "Card created", "card" => card }
    message.to_json
  end

  # remember that DELETE does not receive a body
  delete "/cards/:id" do
    content_type :json

    cards = settings.cards
    unless params["id"].nil?
      id_to_delete = params["id"].to_i
      match = cards.select {|card| card.id == id_to_delete }
      if match.nil? || match.length == 0
        puts "Could not find id #{id_to_delete}"
        halt 400
      else
        card = match.first
        front = card.front
        cards.delete card
        message = { "message" => "Deleted: #{front}" }
        message.to_json
      end
    else
      puts "Did not provide id"
      halt 400
    end
  end
end
