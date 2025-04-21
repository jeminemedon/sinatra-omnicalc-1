require "sinatra"
require "sinatra/reloader"
require "active_support/all"

get("/") { erb(:home) }

get("/square/new") { erb(:square_form) }

get("/square/results") do
  @user_number = params.fetch("user_number").to_f
  @square = @user_number ** 2
  erb(:square_results)
end

get("/square_root/new") { erb(:square_root_form) }

get("/square_root/results") do
  @user_number = params.fetch("user_number").to_f
  @square_root = Math.sqrt(@user_number)
  erb(:square_root_results)
end

get("/random/new") { erb(:random_form) }

get("/random/results") do
  @min = params.fetch("user_min").to_f
  @max = params.fetch("user_max").to_f
  @random_number = rand(@min..@max)
  erb(:random_results)
end

get("/payment/new") { erb(:payment_form) }

get("/payment/results") do
  apr = params.fetch("user_apr").to_f
  years = params.fetch("user_years").to_i
  pv = params.fetch("user_pv").to_f

  r = apr / 100 / 12
  n = years * 12

  numerator = r * pv
  denominator = 1 - (1 + r) ** (-n)

  payment = numerator / denominator

  @raw_payment = payment.round(2) # for unformatted test
  @monthly_payment = @raw_payment.to_fs(:currency) # for formatted test
  @formatted_apr = (apr / 100).to_fs(:percentage, { :precision => 4 })

  erb(:payment_results)
end

