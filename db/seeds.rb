ActiveRecord::Base.transaction do
  10.times do |i|
    User.create(
      email: "#{i}test@test.test",
      password: "#{i}testtest"
    )
  end
end
