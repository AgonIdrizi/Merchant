require 'spec_helper'
require 'rails_helper'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

RSpec.feature "Confirms", type: :feature do
	before(:each) do
  	@product = FactoryGirl.create(:product)
  	@user = FactoryGirl.create(:user)
  	@address = @user.addresses.create(line1: "testline1",line2: "testline2",city: "Tetovo",state: 'VA', zip: 23321)
  end
 
  describe 'select and address', js: true do
  	
  it 'we can select address from select option when user is logged in' do
  	
  	#visit(new_user_registration_path)
  	 # within('form#new_user') do
      #fill_in 'Email', :with => @user.email
      #fill_in 'Password', :with => @user.password
      #fill_in 'Password confirmation', :with => @user.password
    #end
    
    #click_on('Sign up')


  	visit(new_user_session_path)
    within('form#new_user') do
      fill_in 'Email', :with => 'vigan@vigan.com'
      fill_in 'Password', :with => '123456'
    end
    
    click_on('Log in')
    #find('input[type="submit"]').click


  	  
  	  page.should have_content('First')
  	

  	  within ".card-2" do 
  	    find_button('Add to Cart').click
  	  end

  	expect(page).to have_text("Your Cart")
  	

  	visit new_confirm_path
  	#page.should have_content(@user.addresses.first.line1)
  	expect(page).to have_selector("input[id='confirm_form_city']")
  	save_and_open_page
  	  #expect(find(:css, 'input[id="confirm_form_city"]').text).to have_content('Tetovo')
  	within ('input[id="confirm_form_city"]') do
  		expect(page).to have_content('Tetovo')
  	end
  end
  end
end
