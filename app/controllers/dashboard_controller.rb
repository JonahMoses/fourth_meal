class DashboardController < ApplicationController

  def index
    @filtered_orders = Order.order("created_at DESC")

    if params[:status]
      @filtered_orders = @filtered_orders.for_status(params[:status])
    end

    @restaurants = Restaurant.admin_visible.page(params[:page]).per(20)
    @rejected_restaurants = Restaurant.rejected
  end
end
