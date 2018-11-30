FactoryBot.define do
  factory :movie do |f|
    f.title { 'Star Wars' }
    f.rating { 'PG' }
    f.description { '' }
    f.release_date { Date.parse('1977-05-25') }
    f.director { 'George Lucas' }
  end
end
