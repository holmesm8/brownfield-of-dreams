# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Follower PORO' do
  it 'has a login and html_url attribute' do
    follower = Follower.new({ login: 'test',
                              html_url: 'www.test.com' })

    expect(follower.login).to eq('test')
    expect(follower.html_url).to eq('www.test.com')
  end
end
