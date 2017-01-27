class ApplicationController < ActionController::API
  def dollars_to_cents
    return params["unit_price"] = (params["unit_price"].to_f * 100).round(0) if params["unit_price"]
    params
  end
end
