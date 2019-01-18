require 'rails_helper'

RSpec.feature "Products", type: :feature do
  scenario "we should see products in root page" do
  	@product = FactoryGirl.create(:product)

  	visit root_path
  	expect(page).to have_content "#{@product.title}"
  	

  	within ".card-#{@product.id}" do 
  	find_button('Add to Cart').click
  	end

  	expect(page).to have_content("Your Cart")

  end
end
