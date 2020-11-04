# frozen_string_literal: true

class Post < ApplicationRecord

  belongs_to :user

  has_one_attached :picture
  has_one_attached :banner
  has_rich_text :content

  self.per_page = 10

  # @return [Image] after resize
  # @params: x is width, y is height
  def scale_picture(x, y)
    picture.variant(resize_to_fill: [x, y]).processed
  end

  # @return [Datetime] after format
  # Ex: Tuesday, November, 3, 2020
  def updated_date_formater
    updated_at.strftime('%A, %B, %e, %Y')
  end

  # @return [String] truncated 50 words
  def truncated_content
    content.try(:to_plain_text).truncate_words(50)
  end

end
