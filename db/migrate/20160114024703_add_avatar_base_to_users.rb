class AddAvatarBaseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_base, :string

    User.all.each do |user|
      user.update_attribute(:avatar_base, RubyIdenticon.create_base64(user.name))
    end
  end
end
