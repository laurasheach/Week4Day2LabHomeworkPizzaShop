require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('./models/pizza_order')
also_reload('./models/*')

get '/' do
  erb(:welcome)
end

# INDEX - DISPLAY ALL PIZZA

get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb(:index)
end

# NEW - DISPLAY A FORM TO MAKE A NEW PIZZA ORDER

get '/pizza-orders/new' do
  erb(:new)
end

# CREATE - CREATE A DATABASE ENTRY FOR THE NEW PIZZA ORDER

post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

# SHOW - DISPLAY ONE PIZZA

get '/pizza-orders/:id' do
  # p params[:id]
  @order = PizzaOrder.find(params[:id])
  #p @order
  erb(:show)
end

# EDIT - DISPLAY A FORM TO EDIT A PIZZA ORDER'S DETAILS

get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end

# UPDATE - UPDATES A DATABASE ENTRY FOR THE EDITED PIZZA ORDER

post '/pizza-orders/:id' do
  @order = PizzaOrder.new(params)
  @order.update()
  redirect to '/pizza-orders'
end

# DELETE - DELETES A PIZZA ORDER FROM THE THE DATABASE

post '/pizza-orders/:id/delete' do
  delete_order = PizzaOrder.find(params[:id])
  delete_order.delete()
  redirect to '/pizza-orders'
end
