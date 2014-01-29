class ProductsController < ApplicationController

	def new
		@product = Product.new()
	end

	def create
		@product = Product.new(get_product_params)
		@product.save ? redirect_to(@product) : render(:new) 
	end

	def show
		@product = Product.find(params[:id])
	end

	def edit
		@product = Product.find(params[:id])
		@categories = Category.all
	end

	def update
		@product = Product.find(params[:id])

		@product.categories.clear
		params[:cat_ids].each { |i| @product.categories << Category.find(i) }
		@product.save
		
		@product.update_attributes(get_product_params) ? render(:show) : render(:edit)
	end

	def destroy
		product = Product.find(params[:id])
		product.delete
		redirect_to("/")
 	end

	private 
	def get_product_params
		params.require(:product).permit(:name, :price, :description, :picture)
	end

end
