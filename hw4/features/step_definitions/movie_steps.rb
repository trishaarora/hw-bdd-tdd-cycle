Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then /the director of (.+) should be (.+)$/ do |e1, e2|
  expect(Movie.where(title: e1, director: e2)).not_to eq(nil)
end 

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body =~ /#{e1}.*#{e2}/m).not_to eq(nil)
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb)
  rating_list.split(",").each do |rating|
    rating = "ratings[#{rating}]"
    if uncheck.nil? then
      check(rating)
    else
      uncheck(rating)
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  displayed = page.body.scan(/More about /).size
  Movie.count("title").should == displayed
end
