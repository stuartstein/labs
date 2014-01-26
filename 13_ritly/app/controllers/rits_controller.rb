class RitsController < ApplicationController

	def index
		@rits = Rit.last(5).reverse
	end

	def preview
		code = params[:code]
		@rit = Rit.find_by(code: code)
	end

	def visited

		code = params[:code]
		rit = Rit.find_by(code: code)
		Rit.increment_counter(:visits, rit.id)

		redirect_to rit.link

	end

	def create
	    rit_attributes = rit_link_param
		rit_attributes[:code] = Rit.make_code
		rit = Rit.create(rit_attributes)
		redirect_to "/preview/#{rit.code}"

	end

	def update
		rit_attributes = rit_params
		rit = Rit.find(rit_attributes[:id])
		rit.code = rit_attributes[:code]
		rit.save
		redirect_to "/preview/#{rit.code}"
	end


  private
	  def rit_link_param
	  	#raise params.inspect
	    params[:rit].permit(:link)
	  end

	  def rit_params
	  	
	    params[:rit].permit(:id, :code)
	  end
end
