namespace :db do
  desc "生成测试数据"
  task populate: :environment do
    make_users
  end
end

def make_users
  99.times do |n|
    name = "example#{n + 1}"
    email = "example-#{n + 1}@example.com"
    password = "password"
    User.create!(name: name, email: email, password: password, password_confirmation: password)
  end
end
