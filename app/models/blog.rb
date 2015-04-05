require 'kramdown'
class Blog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String
  belongs_to :user

  scope :hots, ->{order(created_at: :desc).limit(5)}
  scope :recommends, ->{order(created_at: :desc).limit(5)}


  def html_body
    markdown.to_html
  end

  def markdown
    Kramdown::Document.new(self.body, remove_block_html_tags: true)
  end

  def text_body
    markdown.remove_block_html_tags
  end
end
