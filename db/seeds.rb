# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

tags=["子連れ多い", "清潔感がある", "トイレが近い", "キッズメニューあり", "個室がある", "お座敷がある", "離乳食可", "ベビーカー可（お店が広い）", "
その他"]

tags.each do | tag |
    Tag.find_or_create_by(name: tag)
end