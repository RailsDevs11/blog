module AuctionAdmin::ProfileHelper

  def resource_name
    :auction_admin
  end

  def resource
    @resource ||= AuctionAdmin.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:auction_admin]
  end

end
