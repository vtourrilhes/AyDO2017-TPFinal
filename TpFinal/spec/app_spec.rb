require_relative 'spec_helper.rb'
require 'json'

describe 'APP' do

	it "si llamo a get/calendarios esta OK" do
	    get "/calendarios"
	    expect(last_response.status).to eq 200
	end

end