class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, presence: true
  validates :url, url: true

  def gist?
    uri = URI.parse(url)
    uri.hostname == 'gist.github.com' && uri.path&.length > 2
  end
end
