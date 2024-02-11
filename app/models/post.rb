class Post < ApplicationRecord

  validates :title, presence: { message: "Title can't be blank"}
  validates :body,  presence: { message: "Body can't be blank"}

end
