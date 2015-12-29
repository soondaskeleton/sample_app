require 'spec_helper'

describe "User pages" do

subject { page }
describe "index" do 
  before do 
    sign_in FactoryGirl.create(:user)
    FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
    FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
    visit users_path
  end

it { should have_title('All users') }
    it { should have_content('All users') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end

describe "profile page" do
let(:user) { FactoryGirl.create(:user) }
before { visit user_path(user) }

it { should have_selector('h1', text: user.name) }
it { should have_selector('title', text: user.name) }
end

describe "signup page" do
 before { visit signup_path }

it { should have_content('Sign up') }
it { should have_title(full_title('Sign up')) }
end

describe "signup" do

before { visit signup_path }

describe "with invalid information" do
it "should not create a user" do
  expect { click_button "Create my account" }.not_to change(User, :count)
end

describe "after submission" do 
  before { click_button submit }

  it { should have_title('Sign up') }
  it { should have_content('error') }
end

describe "after saving the user" do 
  before { click_button submit }
  let(:user) { User.find_by(email: 'user@example.com') }

  it { should have_title(user.name) }
  it { should have_content('div.alert.alert-success', text: 'Welcome') }
end
end