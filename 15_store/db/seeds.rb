my_products = [["Laser", "325", "Good for lasering.", "http://cdn3.volusion.com/lgadk.lckwj/v/vspfiles/photos/Laser-GreenGrid-2.jpg%3F1345736697"],
              ["Shoe", "23.4", "Just the left one.", "http://c3333154.r54.cf0.rackcdn.com/etonic/bowling-shoes/500/men-s-stabilite-plus-lava-left-handed-3-day-sale-31058.jpg"],
              ["Wicker Monkey", "78.99", "It has a little wicker monkey baby.","http://farm9.static.flickr.com/8217/8296660916_635abf7a61.jpg"],
              ["Whiteboard", "125", "Can be written on. (Woman not included.)", "http://www.britevisualproducts.com/images/mfrs/18/500/721.VertSlider1-teach008.main.jpg"],
              ["Chalkboard", "100", "Can be written on.  Smells like education.", "http://www.marcopromotionalproducts.com/SiteData/Products/3_72869_117365_promotional-giveaways-GA-1310-chalkboard-magnet_large_x.jpg"],
              ["Podium", "70", "All the pieces swivel separately.", "http://www.dallaseventrentals.com/siteimages/DallasOakPodiumRentals.jpg"],
              ["Bike", "150", "Good for biking from place to place.", "http://i.walmartimages.com/i/p/00/08/78/76/05/0008787605181_500X500.jpg"],
              ["Kettle", "39.99", "Good for boiling.", "http://cdn05.mightyleaf.com/resources/mightyleaf/images/products/processed/Chantal_Tea_Kettle.a.zoom.jpg"],
              ["Toaster", "20.00", "Toasts your enemies!", "http://i.walmartimages.com/i/p/00/04/00/94/22/0004009422604_500X500.jpg"],
             ]

products = []
my_products.each do |arr|
	products << Product.create(name: arr[0], price: arr[1], description: arr[2], picture: arr[3] )
end

categories = []
categories << Category.create(name: "Lecturing", description: "Be a power lecturer")
categories << Category.create(name: "Clothing", description: "Dress your best!")
categories << Category.create(name: "Transportation", description: "Get to point B in style")
categories << Category.create(name: "Appliances", description: "Get a fully-equipped kitchen!")
categories << Category.create(name: "Furniture", description: "Your house will look spectacular!")

categories[0].products << products[0] 
categories[3].products << products[0]
categories[1].products << products[1]
categories[3].products << products[1]
categories[4].products << products[2]
categories[0].products << products[3]   
categories[0].products << products[4]
categories[0].products << products[5]
categories[3].products << products[6]
categories[3].products << products[7]
categories[3].products << products[8]   