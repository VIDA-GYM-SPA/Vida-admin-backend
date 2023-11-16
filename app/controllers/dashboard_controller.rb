class DashboardController < ApplicationController
  # before_action :authorize_request

  def status_card
    @users = User.all

    @clients = User.select { |item| item.role_id == 3 }
    @clients_unpayed = @clients.select { |item| item.status == 'unpayed' }
  
    @staff = User.select { |item| item.role_id == 2 }
    @staff_on_building = JSON.parse(redis.get("staff_on_building"))
  end

  def invoices
    redis = Redis.new
    
    render json: { 
      current_year: Date.today.strftime('%Y'), 
      invoices: 
        redis.get("invoices:#{params[:year] || Date.today.strftime('%Y')}") == nil ? 
        [] 
        : 
        JSON.parse(redis.get("invoices:#{params[:year] || Date.today.strftime('%Y')}")) }, 
      status: :ok
  end
end
