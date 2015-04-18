# -*- encoding : utf-8 -*-
require 'net/http/post/multipart'
require 'hmac-sha1'
require 'httparty'
require 'open-uri'
class QiniuCheck

  class << self

    def media_process(media_path, kind)
      if kind == "1"
        self.image_process(media_path)
      elsif kind == "2"
        self.video_process(media_path)
      end
    end

    def image_process(image_path)
      rb = %Q({"#{image_path}":$(key),"width":$(imageInfo.width),"height":$(imageInfo.height)})
      put_policy = Qiniu::Auth::PutPolicy.new('marry')
      put_policy.return_body = rb

      token = Qiniu::Auth.generate_uptoken(put_policy)

      path = image_path.path

      code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
          put_policy,
          path
      )

      result["#{image_path}"] = "#{QiniuDomain}" + result["#{image_path}"]
      # puts "-----------"
      # puts result
      result
    end

    def video_process(video_path)
      put_policy = Qiniu::Auth::PutPolicy.new('marry')
      #put_policy.return_body = rb
      time = Time.now.to_i
      file_name_1 = "#{Random.new(time).rand}" + SecureRandom.hex
      file_name_2 = "#{Random.new(time).rand}" + SecureRandom.hex
      file_name_base64_1 = Qiniu::Utils.urlsafe_base64_encode("marry:#{file_name_1}.m3u8")
      file_name_base64_2 = Qiniu::Utils.urlsafe_base64_encode("marry:#{file_name_2}.m3u8")
      # if type == "opu"
      #   put_policy.persistent_ops = "avthumb/mp4/vb/1000k/vcodec/libx264/acodec/libfaac/s/640x480;avthumb/mp4/vb/1500k/vcodec/libx264/acodec/libfaac/s/1024x768;avthumb/flv/ar/44100/vb/512k/vcodec/flv/acodec/libmp3lame/s/320x240;avthumb/m3u8/segtime/10/vb/1000k/vcodec/libx264/acodec/libfaac/s/640x480|saveas/#{file_name_base64_1};avthumb/m3u8/segtime/10/vb/1500k/vcodec/libx264/acodec/libfaac/s/1024x768|saveas/#{file_name_base64_2};vframe/jpg/offset/10/rotate/auto"
      # elsif type == "story"
      put_policy.persistent_ops = "avthumb/mp4/vb/1000k/vcodec/libx264/acodec/libfaac/s/640x480;avthumb/mp4/vb/1500k/vcodec/libx264/acodec/libfaac/s/1024x768;avthumb/flv/ar/44100/vb/512k/vcodec/flv/acodec/libmp3lame/s/320x240;avthumb/m3u8/segtime/10/vb/1000k/vcodec/libx264/acodec/libfaac/s/640x480|saveas/#{file_name_base64_1};avthumb/m3u8/segtime/10/vb/1500k/vcodec/libx264/acodec/libfaac/s/1024x768|saveas/#{file_name_base64_2};vframe/jpg/offset/1/rotate/auto"
      # end
      put_policy.persistent_notify_url = APP_HOST + "qiniu/qiniu_persistent_result"
      put_policy.expires_in = 600

      token = Qiniu::Auth.generate_uptoken(put_policy)

      path = video_path.path

      code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
          put_policy,
          path
      )


      # puts "-----------------"

      #todo 不该有硬编码的链接 写入配置文件
      result["#{video_path}"] = "#{QiniuDomain}" + result["key"]
      # puts result
      result
    end


    def upload_image_with_path(path, token)
      url = URI.parse('http://up.qiniu.com/')
      File.open(path) do |jpg|
        req = Net::HTTP::Post::Multipart.new url.path,
                                             "token" => token,
                                             "file" => UploadIO.new(jpg, "image/jpeg")
        res = Net::HTTP.start(url.host, url.port) do |http|
          http.request(req)
        end
        #puts res.body
        result = JSON.parse res.body
      end
    end

    #七牛剪切图片，另存为一个新名字
    def image_save_as(url, w, h, x, y)
      return '' if url.blank?
      save_as(url, "imageMogr2/crop/!#{w}x#{h}a#{x}a#{y}")
    end

    #七牛添加水印，另存为一个新用户
    def watermark(url, mark_url, options={})
      return if url.blank? or mark_url.blank?
      mark_url = Qiniu::Utils.urlsafe_base64_encode(mark_url)
      dissolve = options[:dissolve] || "100"
      gravity = options[:gravity] || "SouthEast"
      dx = options[:dx] || "10"
      dy = options[:dy] || "10"

      handle = "watermark/1/image/#{mark_url}/dissolve/#{dissolve}/gravity/#{gravity}/dx/#{dx}/dy/#{dy}"
      save_as(url, handle)
    end

    #将一个图片的网址下载然后上传到七牛上
    def upload_url(url)
      rb = %Q({"image_path":$(key),"domain":"http://qnpic.hunliji.com/"})
      token = Qiniu.generate_upload_token(scope: 'qnpic',
                                          return_body: rb,
                                          deadline: (Time.now + 30.seconds).to_i,
                                          expires_in: 12*60*60)

      result = upload_image_with_path(open(url).path, token)
      result["domain"]+result["image_path"]
    end

    def up_load_file(file)
      path = file.path
      rb = %Q({"image_path":$(key),"domain":"http://qnpic.hunliji.com/"})
      token = Qiniu.generate_upload_token(scope: 'qnpic',
                                          return_body: rb,
                                          deadline: (Time.now + 30.seconds).to_i,
                                          expires_in: 12*60*60)
      result = QiniuCheck.upload_image_with_path(path, token)
      result["domain"]+result["image_path"]
    end

    def save_as(url, handle)
      #解析URL，删除"http://"
      url = URI.parse(url)
      parse_url = url.host+url.path

      #另存操作的目标空间与资源名
      time = Time.now.to_i
      file_name_1 = Digest::MD5.hexdigest(parse_url+"#{Random.new(time).rand}").upcase
      #编码结果,对签名进行URL安全的Base64编码
      file_name_base64_1 = Qiniu::Utils.urlsafe_base64_encode("marry:#{file_name_1}")

      #需要签名的部分
      signing_str = "#{parse_url}?#{handle}%7Csaveas/#{file_name_base64_1}"


      #使用SecretKey对新的下载URL进行HMAC1-SHA1签名：
      sign = HMAC::SHA1.new(Qiniu::Config.settings[:secret_key]).update(signing_str).digest
      encoded_sign = Qiniu::Utils.urlsafe_base64_encode(sign)
      ### 生成管理授权凭证
      acctoken = "#{Qiniu::Config.settings[:access_key]}:#{encoded_sign}"

      #最终得到的完整下载UR
      result_url = signing_str+'/sign/'+acctoken

      response = HTTParty.get('http://'+result_url)
      result = JSON.parse response.body
      return "#{QiniuDomain}" + result["key"]
    end
  end
end
