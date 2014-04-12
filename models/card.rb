require 'json'

class Card
  attr_accessor :id, :front, :back, :title

  def initialize(params)
    update params
  end

  def to_json(*a)
    { id:@id, front:@front, back:@back, title:@title }.to_json(*a)
  end

  def update(params)
    @front = params["front"] unless params["front"].nil?
    @back = params["back"] unless params["back"].nil?
    @title = params["title"] unless params["title"].nil?
    @id = params["id"].to_i unless params["id"].nil?
  end
end
