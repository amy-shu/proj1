class PokemonsController < ApplicationController
	
	def capture
		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer = current_trainer
		@pokemon.save
		redirect_to root_path
	end

	def damage
		@pokemon = Pokemon.find(params[:idp])
		@pokemon.health = @pokemon.health - 10
		if @pokemon.health > 0
			@pokemon.save
		else
			@pokemon.destroy
		end
		redirect_to trainer_path(params[:idt])
	end

	def new
	end

	def create
		@pokemon = Pokemon.new(pokemon_params)
		@pokemon.health = 100
		@pokemon.level = 1
		@pokemon.trainer = current_trainer
		if @pokemon.save
			redirect_to trainer_path(current_trainer)
		else 
			redirect_to new_pokemon_path
			flash[:error] = @pokemon.errors.full_messages.to_sentence
		end
	end

end

private
  
# filters out unwanted params
def pokemon_params
	params.require(:pokemon).permit(:name)
end