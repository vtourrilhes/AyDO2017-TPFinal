require_relative 'spec_helper.rb'
require 'json'

describe 'APP' do

	it "si llamo a get/calendarios esta OK" do
	    get "/calendarios"
	    expect(last_response.status).to eq 200
	end

		#it "si llamo a post/calendarios con parametros esta OK" do
	  # parametro = { nombre: "calendario1" }.to_json
		#	post "/calendarios"
	  #  expect(last_response.status).to eq 200
	  #end
	
end