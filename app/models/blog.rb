# -*- encoding : utf-8 -*-
require 'kramdown'
require 'nokogiri'

class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  include Pageable

  field :title, type: String
  field :avatar, type: String
  field :body, type: String
  field :tags, type: Array, default: []
  field :origin, type: String, default: 'my'

  belongs_to :user

  validates_presence_of :title, :body

  scope :hots, -> { order(created_at: :desc).limit(5) }
  scope :recommends, -> { where(:avatar.ne => nil).order(created_at: :desc).limit(5) }


  def html_body
    Kramdown::Document.new(self.body).to_html
  end

  def text_body
    Nokogiri::HTML(html_body).text
  end

end
