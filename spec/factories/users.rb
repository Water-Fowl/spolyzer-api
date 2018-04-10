FactoryBot.define do
  factory :user do
    4.times.each do |i|
      name "test#{i}"
      email "test#{i}@test.com"
      password "test#{i}"
    end
  end
end
