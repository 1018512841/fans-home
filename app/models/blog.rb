require 'kramdown'
require 'nokogiri'

class Blog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :avatar, type: String
  field :body, type: String
  field :tags, type: Array

  belongs_to :user

  scope :hots, ->{order(created_at: :desc).limit(5)}
  scope :recommends, ->{order(created_at: :desc).limit(5)}


  def html_body
    markdown.to_html
  end

  def markdown
    Kramdown::Document.new(self.body)
  end

  def text_body
    Nokogiri::HTML(html_body).text
  end
end
