# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  regexp  =  /#{e1}.*#{e2}/m 
  page.body.should =~  regexp
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_array = rating_list.split(", ")
  rating_array.each do |rating|
    step %Q{I #{uncheck}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  movie_table = Movie.all
  movie_titles = []
  movie_table.each do |movie|
    movie_titles.push(movie.title)
  end
  movie_titles.each do |title|
    step %Q{I should see "#{title}"}
  end
end

Then /I should (not )?see the following movies: (.*)/ do |unseen, movies_list|
  movies_array = movies_list.split(", ")
  movies_array.each do |movie|
    step %Q{I should #{unseen }see "#{movie}"}
  end
end
