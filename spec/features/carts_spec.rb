require 'rails_helper'

RSpec.feature "Carts", type: :feature do
  before(:each) do
  	@product = FactoryGirl.create(:product)
  end
    scenario "we should see items in cart" do
  	  

  	  visit root_path
  	  expect(page).to have_content "#{@product.title}"
  	

  	  within ".card-#{@product.id}" do 
  	    find_button('Add to Cart').click
  	  end

  	expect(page).to have_content("Your Cart")
  	expect(page).to have_content(@product.title)
  end

  scenario "we can edit quantity of items" do
  	visit root_path
  	expect(page).to have_content "#{@product.title}"
  	

  	within ".card-#{@product.id}" do 
  	  find_button('Add to Cart').click
  	end

  	expect(page).to have_content("Successfully added product to cart.")

  	within ".show-cart" do
  	  find('a[class="edit-order-item"]').click
  	end
  	expect(page).to have_content "Editing order_item"

  	within ".edit_order_item" do
  	  find('input[name="order_item[quantity]"]').fill_in with: 4
  	  within ".actions" do
  	  	find('input[name="commit"]').click
  	  end
  	end
  	expect(page).to have_content "Successfully updated the order item."
  end

  scenario "empty a card" do
  	visit root_path
  	expect(page).to have_content "#{@product.title}"
  	

  	within ".card-#{@product.id}" do 
  	  find_button('Add to Cart').click
  	end

  	expect(page).to have_content("Successfully added product to cart.")
  	url = URI.parse(current_url).path
  	puts url
  	within ".show-cart" do
  		find("a[href='#{url}']").click
  	end
  	expect(URI.parse(current_url).path).to eq(root_path)
  end
end
