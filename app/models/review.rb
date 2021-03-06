class Review < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  belongs_to :user
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :price_range
  belongs_to :evaluation

  validates :item, length: { maximum: 50 }
  validates :review_text, length: { minimum: 10, maximum: 1000 }

  with_options presence: true do
    validates :item
    validates :images
    validates :review_text
    validates :price_range_id
    validates :category_id
    validates :evaluation_id
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :price_range_id
    validates :category_id
    validates :evaluation_id
  end

  def self.search(search)
    if search != ""
      Review.where('item LIKE(?)', "%#{search}%")
    else
      Review.includes(:user).order("created_at DESC")
    end
  end
end
