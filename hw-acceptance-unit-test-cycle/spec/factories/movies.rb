FactoryGirl.define do
  factory :movie do |f|
    f.title { 'The Shawshank Redemption' }
    f.rating { 'R' }
    f.description { '' }
    f.release_date { Date.parse('1994-10-14') }
    f.director { 'Frank Darabont' }
  end
end
