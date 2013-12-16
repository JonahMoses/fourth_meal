class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order("created_at DESC")
  end

  def show
  end

  def new
    @item = Item.new
    @current_restaurant = current_restaurant
  end

  def edit
  end

  def create
    @item = Item.new(item_params)


    # assign current restaurant's ID to restaurant_id for item

    respond_to do |format|
      if @item.save
        @item.update(restaurant_id: current_restaurant.id)
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        @item.categories = categories(params[:item][:item_categories])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
    end
  end

private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description, :price, :active, :item_categories, :image, :restaurant_id)
  end

  def categories(ids)
    ids.map {|id| Category.find_by_id(id) }.compact
  end

end
