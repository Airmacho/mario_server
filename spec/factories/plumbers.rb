FactoryBot.define do
  factory :plumber do
    name { "MyString" }
    address { "MyString" }
    vehicles { "MyString" }
  end

  factory :plumber_mario, class: 'Plumber' do
    name { 'Mario' }
    address { 'Mushroom Kingdom' }
    vehicles { 'Racing Car' }
  end

  factory :plumber_luigi, class: 'Plumber' do
    name { 'Luigi' }
    address { 'Mushroom Kingdom' }
    vehicles { 'Racing Motor' }
  end
end