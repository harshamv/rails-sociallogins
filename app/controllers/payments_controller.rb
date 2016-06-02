class PaymentsController < ApplicationController

  def new
  end

  def create

    require 'razorpay'
    Razorpay.setup("rzp_test_V8MKauk5DAjJP4", "WHrhT3mHrMBGoYZqNByDvYaU")

    capture_response = Razorpay::Payment.fetch(params["razorpay_payment_id"]).capture({amount:5000})

    if capture_response.status == "captured"
      render plain: capture_response.inspect
    else
      render plain: capture_response.inspect
    end

  end

end
