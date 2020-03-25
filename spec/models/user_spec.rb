require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe "methods" do
    it '#github_repos', :vcr => {record: :new_episodes} do
      user = User.create!(
                      email: 'user1@example.com',
                      first_name: 'Test',
                      last_name: 'Face',
                      password: 'password',
                      role: 0,
                      github_token: "#{ENV['GITHUB_API_KEY']}")
      
      expect(user.github_repos[0].class).to eq(Repo)
      expect(user.github_repos.length).to eq(5)
    end
    
    it '#github_followers', :vcr => {record: :new_episodes} do
      user = User.create!(
                      email: 'user1@example.com',
                      first_name: 'Test',
                      last_name: 'Face',
                      password: 'password',
                      role: 0,
                      github_token: "#{ENV['GITHUB_API_KEY']}")
      
      expect(user.github_followers[0].class).to eq(Follower)
    end

    it '#github_followings', :vcr => {record: :new_episodes} do
      user = User.create!(
                      email: 'user1@example.com',
                      first_name: 'Test',
                      last_name: 'Face',
                      password: 'password',
                      role: 0,
                      github_token: "#{ENV['GITHUB_API_KEY']}")
      
      expect(user.github_followings[0].class).to eq(Follower)
    end
  end
end