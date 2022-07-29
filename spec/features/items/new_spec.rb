require 'rails_helper'

RSpec.describe 'Add new item to fridge' do
    describe "happy path" do
        before :each do
            user = User.new({name: "Tom", email: "Tom@gmail.com"})
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
            json = JSON.parse(File.read('./spec/fixtures/items_data.json'), symbolize_names: true) 
            items = json[:data].map do |item_data|
                Item.new(item_data)
            end
            allow(UserFacade).to receive(:user_items).and_return(items)
        end
        it "has a form to add a new item" do

            visit '/dashboard'
            click_link 'Add Item'
            expect(current_path).to eq(new_item_path)
            expect(page).to have_content('Add a New Item to Your Fridge') 
            expect(page).to have_content('Name:') 
            expect(page).to have_content('Expiration Date:') 
        end
    
        it "submits request to add new item when form is filled out" do
            new_item = Item.new({name: 'Spinach', expiration_date: '10/15/2022'})
            allow(ItemFacade).to receive(:create_item).and_return(new_item)

            visit new_item_path
            fill_in :name, with: 'Spinach'
            fill_in :expiration_date, with: '10/15/2022'
            click_button 'Submit Item'

            expect(current_path).to  eq('/dashboard')
        end  
    end
    
end