module LifePostsHelper

  def next_one_path(post)
    result = "/life_posts/"+post.next_one.id.to_s if post.next_one
    result || "####"
  end

  def previous_one_path(post)
    result = "/life_posts/"+post.previous_one.id.to_s if post.previous_one
    result || "####"
  end
end
