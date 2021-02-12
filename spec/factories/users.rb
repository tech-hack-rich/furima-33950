FactoryBot.define do
  factory :user do
    nickname {"tarou"}
    email {Faker::Internet.free_email}
    password {"1Abcdf"}
    password_confirmation {"1Abcdf"}
    family_name {"山梨"}
    first_name {"太郎"}
    family_name_spell {"ヤマナシ"}
    first_name_spell {"タロウ"}
    birth_date {"2000-01-01"}
  end
end