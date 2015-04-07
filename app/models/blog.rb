require 'kramdown'
require 'nokogiri'

class Blog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :avatar, type: String
  field :body, type: String
  field :tags, type: Array, default: []
  field :origin, type: String, default: 'my'
  field :mime, type: String, default: 'markdown'

  belongs_to :user

  scope :hots, -> { order(created_at: :desc).limit(5) }
  scope :recommends, -> { where(:avatar.ne => nil).order(created_at: :desc).limit(5) }


  def html_body
    markdown.to_html
  end

  def body_text
    if mime == 'html'
      body
    else
      html_body
    end
  end

  def markdown
    Kramdown::Document.new(self.body)
  end

  def text_body
    Nokogiri::HTML(html_body).text
  end

  def next_one
    self.class.where(:id => {:$gt => self.id}).order("id ASC").first
  end

  def previous_one
    self.class.where(:id => {:$lt => self.id}).order("id DESC").first
  end
end
