class GithubService
  def get_repos(user)
    parsed = JSON.parse(api_response('/user/repos', user).body, symbolize_names: true)
  end

  def get_followers(user)
    parsed = JSON.parse(api_response('/user/followers', user).body, symbolize_names: true)
  end

  private

  def conn
    conn = Faraday.new('https://api.github.com')
  end

  def api_response(url, user) 
    response = conn.get(url, nil, {:Authorization => user.github_token})
  end
end