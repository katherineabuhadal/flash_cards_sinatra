require "sinatra"
require "active_record"
require "pg"

ActiveRecord::Base.establish_connection(
	adapter: "postgresql",
	database: "card_deck")

class Card < ActiveRecord::Base
end

class Deck < ActiveRecord::Base
	has_many :cards
end

get "/" do
	@decks = Deck.all
	erb :index
end

get "/new_deck" do
	erb :new_deck
end

get "/decks/:id" do
	@deck = Deck.find(params[:id])
	@card = Card.where(deck_id: @deck.id).sample

	erb :show
end

post "/decks" do
	deck = Deck.create(params[:deck])

	redirect "/decks/#{deck.id}"
end

get "/cards/:id/edit" do
	@deck = Deck.find(params[:id])
	@cards = Card.where(deck_id: @deck.id)
	erb :new_card
end

post "/cards" do
	card = Card.create(params[:card])
	redirect "/cards/#{card.id}"
	
end

delete "/decks/:id" do
	deck = Deck.find(params[:id]) 
	deck.destroy

	redirect "/"
end











