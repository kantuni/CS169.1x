Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do |n_seeds|
  Movie.count.should be n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  p1 = page.body.index(e1)
  p2 = page.body.index(e2)
  expect(p1).to be <= p2
end

When /I (un)?check the following ratings: (.*)/ do |boolean, rating_list|
  ratings = rating_list.split(', ')
  ratings.each do |rating|
    step 'I ' + boolean.to_s + 'check "ratings_' + rating + '"'
  end
end

Then /I should( not)? see the following movies/ do |boolean, movies_table|
  movies_table.hashes.each do |movie|
    step 'I should' + boolean.to_s + ' see "' + movie['title'] + '"'
  end
end

Then /I should see all of the movies/ do
  rows = find_by_id('movies').all('tr').size - 1
  expect(rows).to eq 10
end
