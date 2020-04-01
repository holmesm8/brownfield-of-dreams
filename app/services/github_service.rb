# frozen_string_literal: true

class GithubService
  def get_repos(user)
    JSON.parse(api_response('/user/repos', user).body, symbolize_names: true)
  end

  def get_followers(user)
    JSON.parse(api_response('/user/followers', user).body, symbolize_names: true)
  end

  def get_followings(user)
    JSON.parse(api_response('/user/following', user).body, symbolize_names: true)
  end

  def user_info(handle)
    connection = Faraday.get("https://api.github.com/users/#{handle}")
    JSON.parse(connection.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new('https://api.github.com')
  end

  def api_response(url, user)
    conn.get(url, nil, { Authorization: "token #{user.github_token}" })
  end
end
