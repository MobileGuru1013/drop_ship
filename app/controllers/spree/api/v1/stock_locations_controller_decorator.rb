Spree::Api::V1::StockLocationsController.class_eval do
  before_action :supplier_locations, only: [:index]
  before_action :supplier_transfers, only: [:index]

  private

  def supplier_locations
    params[:q] ||= {}
    params[:q][:supplier_id_eq] = spree_current_user.supplier_id
  end

  def supplier_transfers
    params[:q] ||= {}
    params[:q][:supplier_id_eq] = spree_current_user.supplier_id
  end
end
