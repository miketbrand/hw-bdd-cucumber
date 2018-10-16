# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
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
  # Make sure that all the movies in the app are visible in the table
  #fail "Unimplemented"
end

Then /I should (not )?see the following movies: (.*)/ do |unseen, movies_list|
  movies_array = movies_list.split(", ")
  movies_array.each do |movie|
    step %Q{I should #{unseen }see "#{movie}"}
  end
  # Make sure that all the movies in the app are visible in the table
  #fail "Unimplemented"
end
