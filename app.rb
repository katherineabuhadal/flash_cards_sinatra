require "sinatra"
require "active_record"
require "pg"

ActiveRecord::Base.establish_connection(
	adapter: "postgresql",
	database: "card_deck")

class Card < ActiveRecord::Base
end

class Deck < ActiveRecord::Base
end

get "/" do
	
	@decks = Deck.all
	erb :index
end




get "/decks/:id" do
	@deck = Deck.find(params[:id])
	@cards = Card.where(deck_id: @deck_id)

	erb :show
end


