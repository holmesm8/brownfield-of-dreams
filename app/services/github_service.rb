class GithubService

  def conn
    Faraday.new(url: "https://api.github.com'") do |f|
      f.adapter  Faraday.default_adapter
      f.params[:Authorization] = ENV['GITHUB_API_KEY']
    end
  end

  def get_json(url, params, user)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
  end

  def get_repos(user)
    api_option = {visibility: 'all'}
    get_json('/user/repos', api_option, user)
  end
end