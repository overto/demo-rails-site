# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include Faker


#Article.destroy_all # Never run on production site!


=begin
100.times do
  rand_published_true_or_false = [true, false].sample
  if rand_published_true_or_false == true
    article = Article.create(title: Book.title,
                             author: Book.author,
                             published_date: rand(100.years).seconds.ago, # Faker::Date(100.years.ago, Date.today), # not working gets error!
                             is_published: true,
                             content: Lorem.paragraph,
                             author_thumbnail_avatar_url: Placeholdit.image("50x50")
    )
  else
    article = Article.create(title: Book.title,
                             author: Book.author,
                             is_published: false,
                             content: Lorem.paragraph,
                             author_thumbnail_avatar_url: Placeholdit.image("50x50")
    )
  end
  #puts article.inspect
end
=end

# Review.destroy_all
# Product.destroy_all
#
# 100.times do
#
#   uniq_prod_name = Food.dish
#   counter = 1
#   while Product.exists?(name: uniq_prod_name)
#     uniq_prod_name += counter.to_s
#     counter += 1
#   end
#
#   product = Product.create(name: uniq_prod_name ,
#                            description: Food.ingredient,
#                            quantity_on_hand: Number.number(3),
#                            selling_price: Number.decimal(2),
#                            cost_of_product: Number.decimal(2),
#                            shipping_weight: Number.decimal(2),
#                            product_thumbnail_image_url: LoremPixel.image("50x50", false, 'food'),
#                            product_fullsize_image_url: LoremPixel.image("150x150", false, 'food')
#   )
#   (rand(0..10)).times do
#     product.reviews.create(
#         author: "#{Name.first_name} #{Name.last_name}",
#         comment: Lorem.paragraph,
#         rating: rand(1..10)
#     )
#   end
#   #puts product.inspect
# end

# # Add fake blog & comment entries
# Blog.destroy_all
# 100.times do
#   blog = Blog.create(title: Lorem.sentence,
#                            published_date: Faker::Date.between(5.years.ago, Date.today),
#                            author: Name.name,
#                            content: Lorem.paragraph
#   )
#   (rand(0..10)).times do
#     blog.comments.create(
#         author: Name.name,
#         content: Lorem.paragraph,
#         avatar_image: LoremPixel.image("50x60", false,'people'),
#         rating: rand(1..5)
#     )
#   end
# end
#
# # Add fake articles
# Article.destroy_all
# 100.times do
#   pub_chance = rand(0..1)
#   pub_date = nil
#   pub_date = Faker::Date.between(5.years.ago, Date.today) if pub_chance == 1
#   is_pub = false
#   is_pub = true if pub_date != nil
#
#   article = Article.create(title: Lorem.sentence,
#                      author: Name.name,
#                      published_date: pub_date,
#                      is_published: is_pub,
#                      content: Lorem.paragraph(20, true, 6),
#                      author_thumbnail_avatar_url: LoremPixel.image("50x60", false,'people')
#   )
# end


# Add fake puzzle data
# Puzzle.destroy_all
#
# 50.times do
#   rand_select = rand(1..3)
#   words = ""
#   rand(25..50).times do
#     case rand_select
#       when 1
#         words = words + Food.dish + "\n"
#       when 2
#         words = words + Food.ingredient + "\n"
#       when 3
#         words = words + Food.spice + "\n"
#     end
#   end
#   uniq_puzzle_name = Superhero.name + " Puzzle"
#   counter = 1
#   while Puzzle.exists?(puzzle_name: uniq_puzzle_name)
#     uniq_puzzle_name += counter.to_s
#     counter += 1
#   end
#   puzzle = Puzzle.create(puzzle_name: uniq_puzzle_name , word_list: words)
# end