require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'pg'

def dbname
  "garage"
end

def with_db
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  yield c
  c.close
end

get '/' do
  erb :index
end

# The Products machinery:

# Get the index of products
get '/products' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)

  # Get all rows from the products table.
  @products = c.exec_params("SELECT * FROM products;")
  c.close
  erb :products
end

get '/categories' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)

  # Get all rows from the products table.
  @categories = c.exec_params("SELECT * FROM categories;")
  c.close
  erb :categories
end

# Get the form for creating a new product
get '/products/new' do
  erb :new_product
end

get '/categories/new' do
  erb :new_category
end

# POST to create a new product
post '/products' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)

  # Insert the new row into the products table.
  c.exec_params("INSERT INTO products (name, price, description) VALUES ($1,$2,$3)",
                  [params["name"], params["price"], params["description"]])

  # Assuming you created your products table with "id SERIAL PRIMARY KEY",
  # This will get the id of the product you just created.
  new_product_id = c.exec_params("SELECT currval('products_id_seq');").first["currval"]
  c.close
  redirect "/products/#{new_product_id}"
end

# POST to create a new category
post '/categories' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)

  # Insert the new row into the products table.
  c.exec_params("INSERT INTO categories (name) VALUES ($1)",
                  [params["name"]])

  # Assuming you created your products table with "id SERIAL PRIMARY KEY",
  # This will get the id of the product you just created.
  new_category_id = c.exec_params("SELECT currval('categories_id_seq');").first["currval"]
  c.close
  redirect "/categories/#{new_category_id}"
end

# Update a product
post '/products/:id' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)

  # Update the product.
  c.exec_params("UPDATE products SET (name, price, description, picture) = ($2, $3, $4, $5) WHERE products.id = $1",
                [params["id"], params["name"], params["price"], params["description"], params["picture"]])
  c.exec_params("UPDATE catalog SET (categories_id) WHERE products.id = $1",
                [params["id"], params["name"], params["price"], params["description"], params["picture"]])
  c.close
  redirect "/products/#{params["id"]}"
end

# Rename a category
post '/categories/:id' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)

  # rename the category.
  c.exec_params("UPDATE categories SET (name) = ($2) WHERE categories.id = $1 ",
                [params["id"], params["name"]])
  c.close
  redirect "/categories/#{params["id"]}"
end

get '/products/:id/edit' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  @product = c.exec_params("SELECT * FROM products WHERE products.id = $1", [params["id"]]).first

 selected_categories = c.exec_params("SELECT categories.name FROM categories INNER JOIN catalog ON catalog.category_id = categories.id INNER JOIN products ON catalog.product_id = products.id WHERE products.id = $1;", [params[:id]])

 @picked =[]
 selected_categories.each { |cat| @picked << cat["name"]}

  @all_categories = c.exec_params("SELECT * FROM categories;")
  c.close
  erb :edit_product
end

get '/categories/:id/edit' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  @category = c.exec_params("SELECT * FROM categories WHERE categories.id = $1", [params["id"]]).first
  c.close
  erb :edit_category
end

# DELETE to delete a product
post '/products/:id/destroy' do

  c = PGconn.new(:host => "localhost", :dbname => dbname)
  c.exec_params("DELETE FROM products WHERE products.id = $1", [params["id"]])
  c.exec_params("DELETE FROM catalog WHERE catalog.product_id = $1", [params["id"]])
  c.close
  redirect '/products'
end

# DELETE to delete a category
post '/categories/:id/destroy' do

  c = PGconn.new(:host => "localhost", :dbname => dbname)
  c.exec_params("DELETE FROM categories WHERE categories.id = $1", [params["id"]])
  c.exec_params("DELETE FROM catalog WHERE catalog.category_id = $1", [params["id"]])
  c.close
  redirect '/categories'
end

# GET the show page for a particular product
get '/products/:id' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  @product = c.exec_params("SELECT * FROM products WHERE products.id = $1;", [params[:id]]).first
  @categories = c.exec_params("SELECT categories.name, categories.id FROM categories INNER JOIN catalog ON catalog.category_id = categories.id INNER JOIN products ON catalog.product_id = products.id WHERE products.id = $1;", [params[:id]])
  c.close
  erb :product
end

# GET the show page for a particular product
get '/products/:id/add-category/' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  @product_id = params[:id]
  @categories = c.exec_params("SELECT categories.name FROM categories INNER JOIN catalog ON catalog.category_id != categories.id JOIN products ON catalog.product_id = products.id WHERE products.id = $1;", [params[:id]])
  c.close
  erb :add_category
end

post '/products/:id/add-category' do
   c = PGconn.new(:host => "localhost", :dbname => dbname)
   #INSERT into foo_bar (foo_id, bar_id) VALUES ((select id from foo where name = 'selena'), (select id from bar where type = 'name'));    
  c.exec_params("INSERT INTO catalog (product_id, category_id) VALUES ($1, (SELECT id FROM categories WHERE name=$2));", [params["id"], params["category"]])
  c.close
  redirect "/products/#{params["id"]}"
end

get '/products/:id/remove-category/' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  @product_id = params[:id]
  @categories = c.exec_params("SELECT categories.name, categories.id FROM catalog LEFT JOIN categories ON catalog.category_id = categories.id WHERE catalog.product_id = $1;", [params[:id]])
  c.close
  erb :remove_category
end

post '/products/:id/remove-category' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  c.exec_params("DELETE FROM catalog USING categories WHERE categories.id = catalog.category_id AND categories.name = $2 AND catalog.product_id = $1;", [params["id"], params["category"]])
  c.close
  redirect "/products/#{params["id"]}"
end

# GET the show page for a particular product
get '/products/:id' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  @product = c.exec_params("SELECT * FROM products WHERE products.id = $1;", [params[:id]]).first
  @categories = c.exec_params("SELECT categories.name, categories.id FROM categories INNER JOIN catalog ON catalog.category_id = categories.id INNER JOIN products ON catalog.product_id = products.id WHERE products.id = $1;", [params[:id]])
  c.close
  erb :product
end

# GET the show page for a particular category
get '/categories/:id' do
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  @category = c.exec_params("SELECT * FROM categories WHERE categories.id = $1;", [params[:id]]).first
  @products = c.exec_params("SELECT products.name, products.id FROM products INNER JOIN catalog ON catalog.product_id = products.id INNER JOIN categories ON catalog.category_id = categories.id WHERE categories.id = $1;", [params[:id]])
  c.close
  erb :category
end


# Create and seed all tables
def create_products_table
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  c.exec %q{
  CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name varchar(255),
    price decimal,
    description text,
    picture text
  );
  }
  c.close
end

def drop_products_table
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  c.exec "DROP TABLE products;"
  c.close
end

def seed_products_table
  products = [["Laser", "325", "Good for lasering.", "http://cdn3.volusion.com/lgadk.lckwj/v/vspfiles/photos/Laser-GreenGrid-2.jpg%3F1345736697"],
              ["Shoe", "23.4", "Just the left one.", "http://c3333154.r54.cf0.rackcdn.com/etonic/bowling-shoes/500/men-s-stabilite-plus-lava-left-handed-3-day-sale-31058.jpg"],
              ["Wicker Monkey", "78.99", "It has a little wicker monkey baby.","http://farm9.static.flickr.com/8217/8296660916_635abf7a61.jpg"],
              ["Whiteboard", "125", "Can be written on. (Woman not included.)", "http://www.britevisualproducts.com/images/mfrs/18/500/721.VertSlider1-teach008.main.jpg"],
              ["Chalkboard", "100", "Can be written on.  Smells like education.", "http://www.marcopromotionalproducts.com/SiteData/Products/3_72869_117365_promotional-giveaways-GA-1310-chalkboard-magnet_large_x.jpg"],
              ["Podium", "70", "All the pieces swivel separately.", "http://www.dallaseventrentals.com/siteimages/DallasOakPodiumRentals.jpg"],
              ["Bike", "150", "Good for biking from place to place.", "http://i.walmartimages.com/i/p/00/08/78/76/05/0008787605181_500X500.jpg"],
              ["Kettle", "39.99", "Good for boiling.", "http://cdn05.mightyleaf.com/resources/mightyleaf/images/products/processed/Chantal_Tea_Kettle.a.zoom.jpg"],
              ["Toaster", "20.00", "Toasts your enemies!", "http://i.walmartimages.com/i/p/00/04/00/94/22/0004009422604_500X500.jpg"],
             ]
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  products.each do |p|
    c.exec_params("INSERT INTO products (name, price, description, picture) VALUES ($1, $2, $3, $4);", p)
  end
  c.close
end

def create_categories_table
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  c.exec %q{
  CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name varchar(255)
  );
  }
  c.close
end

def seed_categories_table
  categories = [["Lecturing"], ["Clothing"], ["Transportation"], ["Applicances"], ["Furniture"]]
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  categories.each do |cat|
    c.exec_params("INSERT INTO categories (name) VALUES ($1);", cat)
  end
  c.close
end

def create_catalog_table
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  c.exec %q{
  CREATE TABLE catalog (
    id SERIAL PRIMARY KEY,
    product_id integer,
    category_id integer
  );
  }
  c.close
end

def seed_catalog_table
  entries = [[1, 1], [1, 4], [2, 2], [2, 3], [3, 5], [4, 1], [5, 1], [6, 1], [7, 3], [8, 4], [9, 4]]
  c = PGconn.new(:host => "localhost", :dbname => dbname)
  entries.each do |entry|
    c.exec_params("INSERT INTO catalog (product_id, category_id) VALUES ($1, $2);", entry)
  end
  c.close
end