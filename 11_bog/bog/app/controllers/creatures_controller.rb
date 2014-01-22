class CreaturesController < ApplicationController
	
	def index
		@creatures = Creature.all
		render :index
	end

	def new
		render :new
	end

	def create
		creature = params.require(:creature).permit(:name, :picture, :description)
		Creature.create(creature)
		redirect_to "/creatures"
	end

	def show
		creature_id = params[:id]
		@creature = Creature.find(creature_id)
		render :show
	end

	def edit
		creature_id = params[:id]
		@creature = Creature.find(creature_id)
		render :edit
	end

	def update
		creature_id = params[:id]
		creature = Creature.find(creature_id)

		# get updated data
		updated_attributes = params.require(:creature).permit(:name, :picture, :description)
		creature.update_attributes(updated_attributes)

		redirect_to "/creatures/#{creature_id}"
	end

	def destroy
		creature_id = params[:id]
		Creature.destroy(creature_id)
		redirect_to "/creatures"
	end




end