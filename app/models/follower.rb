# frozen_string_literal: true

class Follower
  attr_reader :login,
              :html_url

  def initialize(follower_hash)
    @login = follower_hash[:login]
    @html_url = follower_hash[:html_url]
  end
end
