# frozen_string_literal: true

class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships, force: true, id: false do |t|
      t.bigint 'user_id', null: false
      t.bigint 'friend_id', null: false
    end
  end
end
