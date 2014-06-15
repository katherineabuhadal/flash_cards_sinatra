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

get "/decks/:id/play" do
	@deck = Deck.find(params[:id])
	@card = Card.where(deck_id: @deck.id).sample

	erb :play
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

get "/cards/:deck_id/edit/:card_id" do
	@deck = Deck.find(params[:deck_id])
	@card = Card.find(params[:card_id])
	
	erb :delete_card
end


get "/cards/:id/edit" do
	@deck = Deck.find(params[:id])
	@cards = Card.where(deck_id: @deck.id)
	erb :new_card
end

get "/cards/:deck_id" do
	@deck = Deck.find(params[:deck_id])
	erb :show_cards
end

post "/cards/:deck_id" do
	deck = Deck.find(params[:deck_id])
	deck.cards.create(params[:card])
	redirect "/cards/#{deck.id}/edit"
end

delete "/decks/:id" do
	deck = Deck.find(params[:id]) 
	deck.destroy

	redirect "/"
end















