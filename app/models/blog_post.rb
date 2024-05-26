class BlogPost < ActiveRecord::Base
  belongs_to :user
  before_save :fetch_image

  validates :title, :content, presence: true

  private

  def fetch_image
    response = Unsplash::Photo.search(self.title).sample
    self.image_url = response.urls.regular if response.present?
  end
end
