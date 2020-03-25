class GithubFacade

  def get_repos(user)
    conn = Faraday.new('https://api.github.com')

    response = conn.get('user/repos', {visibility: 'all'}, {'Accept' => 'application/json', :Authorization => user.github_token})

    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end