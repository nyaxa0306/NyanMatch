# 保護主ユーザー
user = User.find_or_create_by!(email: "hogonushi@example.com") do |u|
  u.password = "password"
  u.nickname = "保護主"
end

# 猫データ
cats_data = [
  { name: "うり", age: 13, gender: "メス", breed: "雑種", personality: "臆病で神経質", helth:"避妊済み、猫風邪持ち", status: "募集中", image: "cats/uri.jpg", prefecture_id: 12 },
  { name: "かぼちゃ", age: 14, gender: "オス", breed: "雑種", personality: "豪胆で食いしん坊、喧嘩っ早い", helth:"去勢済み、尿路結石になったことあり", status: "トライアル中", image: "cats/kabocha.jpg", prefecture_id: 12 },
  { name: "へちま", age: 7, gender: "オス", breed: "雑種", personality: "おとなしくて甘えん坊、喧嘩は非常に強い", helth:"去勢済み、腎不全", status: "譲渡済み", image: "cats/hechima.jpg", prefecture_id: 12 },
  { name: "よもぎ", age: 3, gender: "メス", breed: "雑種", personality: "臆病で人見知りが激しい、とても甘えん坊", helth:"避妊済み", status: "募集中", image: "cats/yomogi.jpg", prefecture_id: 12 },
  { name: "きなこ", age: 3, gender: "メス", breed: "雑種", personality: "おとなしくて人間好き、なんでも食べる悪癖あり", helth:"避妊済み", status: "募集中", image: "cats/kinako.jpg", prefecture_id: 12 },
  { name: "ちまき", age: 0, gender: "オス", breed: "雑種", personality: "好奇心旺盛で暴れん坊", helth:"猫風邪持ち、未去勢、右目に白濁あり", status: "募集中", image: "cats/chimaki.jpg", prefecture_id: 12 }
]

cats_data.each do |cat_attrs|
  cat = Cat.find_or_create_by!(name: cat_attrs[:name]) do |c|
    c.age = cat_attrs[:age]
    c.gender = cat_attrs[:gender]
    c.breed = cat_attrs[:breed]
    c.personality = cat_attrs[:personality]
    c.helth = cat_attrs[:helth]
    c.status = cat_attrs[:status]
    c.user = user
    c.prefecture_id = cat_attrs[:prefecture_id]
  end

  # 画像がまだ添付されていなければ ActiveStorage に attach
  unless cat.image.attached?
    cat.image.attach(
      io: File.open(Rails.root.join("app/assets/images/#{cat_attrs[:image]}")),
      filename: File.basename(cat_attrs[:image])
    )
  end
end

puts "Seed 完了！猫 6匹と画像を登録しました。"
