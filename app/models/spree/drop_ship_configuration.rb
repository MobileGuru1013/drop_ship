module Spree
  class DropShipConfiguration < Preferences::Configuration
    # Automatically deliver drop ship orders by default.
    preference :automatically_deliver_orders_to_supplier, :boolean, default: true

    # Default flat rate to charge suppliers per order for commission.
    preference :default_commission_flat_rate, :float, default: 0.0

    # Default percentage to charge suppliers per order for commission.
    preference :default_commission_percentage, :float, default: 0.0

    # Determines whether or not to email a new supplier their welcome email.
    preference :send_supplier_email, :boolean, default: true
  end
end
