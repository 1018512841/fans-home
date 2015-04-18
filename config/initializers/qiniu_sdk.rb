# -*- encoding : utf-8 -*-
require 'qiniu'

Qiniu.establish_connection! :access_key => "381JZ6WLuJj_7Pdac67nk1rU6zo6ZuTK0cF2bLMb",
                                :secret_key => "fZc42pZdwmcmUIX9pKpPJaS3HfmgDB-zUmYGJ645"

$qlog = Logger.new("#{Rails.root}/log/qiniu.log")

$gtlog = Logger.new("#{Rails.root}/log/getui.log")


QiniuDomain = 'http://7xigap.com1.z0.glb.clouddn.com/'
