# frozen_string_literal: true

class AddGitHubUrlToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_url, :string
  end
end
