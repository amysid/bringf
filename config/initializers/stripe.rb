


# Rails.configuration.stripe = {
#   :publishable_key => "pk_live_eznV68jT2JlmEsnDdYkSFIIw", #steve _p
#   :secret_key      => "sk_live_hNmDmX8nwYfbHCYFOrHkVClF"
# }

Rails.configuration.stripe = {
  :publishable_key => "pk_test_PNQjTIwKN0dxTlRbCbRX8MAY", #steve _p
  :secret_key      => "sk_test_GtUVbxSSYg4PpRh5LzCcYxRF"
}


Stripe.api_key = Rails.configuration.stripe[:publishable_key]
Stripe.api_key = Rails.configuration.stripe[:secret_key]





