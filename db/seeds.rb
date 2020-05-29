# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env == 'development'
  
  Tag.create([
    { name: 'Apex'},
    { name: 'Fortnite'},
    { name: '荒野行動'},
    { name: 'スマブラ'},
    { name: 'PUBG'},
    { name: 'ランク'},
    { name: 'アリーナ'},
    { name: 'チャンピオン'},
    { name: 'ダイヤ'},
    { name: 'プレデター'},
    { name: 'エンジョイ'},
  ])
end
