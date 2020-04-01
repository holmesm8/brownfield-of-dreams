# frozen_string_literal: true

class AddConfirmationsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_confirm, :boolean, default: false
    add_column :users, :confirm_token, :string
  end
end
