class DashboardController < ApplicationController

  def index
    @filtered_orders = Order.order("created_at DESC")

    if params[:status]
      @filtered_orders = @filtered_orders.for_status(params[:status])
    end

    @restaurants = Restaurant.admin_visible
    @rejected_restaurants = Restaurant.rejected
  end
end
