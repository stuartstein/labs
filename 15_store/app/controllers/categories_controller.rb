class CategoriesController < ApplicationController

def index
	@categories = Category.all.order(:name)
	@selected = Category.new(name: "All")
	@products = Product.all.order(:name)
end

def new
	@category = Category.new()
end

def create
	@category = Category.new(get_category_params)
	@category.save ? redirect_to(@category) : render(:new)
end

def show
	@categories = Category.all.order(:name)
	@selected = Category.find(params[:id])
	@products = @selected.products.order(:name)
	render :index
end

def edit
	@category = Category.find(params[:id])
end

def destroy
	category = Category.find(params[:id])
	category.delete
	redirect_to("/")
end

def update
	category = Category.find(params[:id])
	category.update_attributes(get_category_params) ? redirect_to(:index) : render(:edit)
end

end

private 
def get_category_params
	params.require(:category).permit(:name, :description)
end