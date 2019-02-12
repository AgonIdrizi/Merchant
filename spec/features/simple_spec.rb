require 'spec_helper'
require 'rails_helper'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

describe 'some stuff which requires js', :js => true do
	before {@user = User.create(email: 'Agon@agon.com',password: '123456', password_confirmation: '123456')}
  it 'will take a screenshot' do
    visit("http://google.com")
    page.driver.render('./file.png', :full => true)
    expect(@user.email).to eq 'agon@agon.com'
  end
end