require 'json'

class Card
  attr_accessor :id, :front, :back, :title

  def initialize(params)
    @front = params["front"]
    @back = params["back"]
    @title = params["title"]
    @id = params["id"]
  end

  def to_json(*a)
    { id:@id, front:@front, back:@back, title:@title }.to_json(*a)
  end
end
