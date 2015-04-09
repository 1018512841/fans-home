json.array!(@all_blogs) do |blog|
  json.text blog.title
  json.color "##{"%06x" % (rand * 0xffffff)}"
  json.size ['0', '1', '1']
  json.position 0
  json.time rand(@all_blogs.size*10)
  json.opacity 1
  json.data_blog blog.id.to_s
  json.isnew(true) if rand(5) == 1
end

