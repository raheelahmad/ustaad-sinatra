require 'sequel'

class Card < Sequel::Model
  plugin :json_serializer
end
