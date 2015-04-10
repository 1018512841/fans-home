//= require 'controls/qiniu_control'
//保存封面图片


fans_home.common.uploadFile = function () {
    return {
        uploadFile: function (options, eventBindings) {
            var config = {
                'uptoken_url': '/qiniu/image_up_token'
            }
            var events = {
                'FileUploaded': function (up, file, info) {
                },
                'FilesAdded': function (up, files) {
                },
                'BeforeUpload': function (up, file) {
                },
                'UploadProgress': function (up, file) {

                },
                'FileUploaded': function (up, file, info) {

                },
                'Error': function (up, err, errTip) {

                },
                'UploadComplete': function (up, file) {

                }
            }
            config = $.extend({}, config, options);
            events = $.extend({}, events, eventBindings);

            var coverImageUploader = new QiniuUploader();

            config.browse_button = fans_home.common.uploadFile.getRandomId();
            fans_home.common.uploadFile.createHiddenInput(config.browse_button);

            coverImageUploader.upload(config, events);
            return config.browse_button;
        },

        createHiddenInput: function (domId) {
            var input = document.createElement('input');
            input.id = domId;
            //创建隐藏的元素，用div将其包裹，便于刷新时定位
            var $wrapper = $('<div style="display:none"></div>');
            $wrapper.append($(input));
            $('body').append($wrapper);
        },

        getRandomId: function () {
            //生成随机的ID， 如果重复，重新获取
            var domId = fans_home.common.other.getRandom(100000);
            while ($("#fans-qiniu-btn-" + domId).length > 0) {
                domId = fans_home.common.other.getRandom(100000);
            }
            return "fans-qiniu-btn-" + domId;
        },

        initUploadObj: function (options, eventBindings) {
            var config = {
                'refreshTime': 10 * 60,
                'mediaType': "image"
            }
            config = $.extend({}, config, options);

            if (config.mediaType == "video") {
                config.uptoken_url = '/qiniu/video_up_token';
            } else {
                config.uptoken_url = '/qiniu/image_up_token';
            }

            function uploadObj(options, eventBindings) {
                var that = this;
                //生成button，调用7牛的API绑定事件

                //判断上传文件的类型，如果格式不对，不进行弹出警告框，终止操作
                var media = {"image":"图片", "video":"视频"};
                var originBefore = eventBindings.BeforeUpload;
                var BeforeUpload = function(up, file){
                    if(fans_home.common.uploadFile.checkoutFormat(file.name, config.mediaType)){
                        originBefore(up, file);
                    }else{
                        fans_home.common.dialog.error(media[config.mediaType]+"格式不对!");
                    }
                }
                //修改原先的BeforeUpload事件，添加错误检测
                eventBindings.BeforeUpload = BeforeUpload;

                that.btnId = fans_home.common.uploadFile.uploadFile(options, eventBindings);
                that.refreshToken = function () {
                    //刷新token值，将隐藏的button删除
                    $("#" + that.btnId).parent().remove();
                    //重新生成button，调用7牛的API绑定事件
                    that.btnId = fans_home.common.uploadFile.uploadFile(options, eventBindings);
                };
                that.startUpload = function (target) {
                    //target为传入的DOM对象，表示点击的对象
                    that.target = target;
                    $("#" + that.btnId).click();
                }
            };
            var obj = new uploadObj(config, eventBindings);
            setInterval(function () {
                obj.refreshToken();
            }, config.refreshTime * 1000)
            return obj;

        },

        isImage: function ( url ) {
            var res, suffix = "";
            var imageSuffixes = ["png", "jpg", "jpeg", "gif", "bmp"];
            var suffixMatch = /\.([a-zA-Z0-9]+)(\?|\@|$)/;

            if ( !url || !suffixMatch.test( url ) ) {
                return false;
            }
            res = suffixMatch.exec( url );
            suffix = res[1].toLowerCase();
            for ( var i = 0, l = imageSuffixes.length; i < l; i++ ) {
                if ( suffix === imageSuffixes[i] ) {
                    return true;
                }
            }
            return false;
        },

        isVideo: function ( url ) {
            var res, suffix = "";
            var imageSuffixes = ['webm','mkv','flv','ogv','ogg','drc','mng',
                'avi','mov','qt','wmv','yuv','rm','rmvb','asf','mp4','m4p',
                'm4v','mpg','mp2','mpe','mpv','mpg','mpeg','m2v','svi',
                '3gp','mxf','roq','nsv','divx','vob'];
            var suffixMatch = /\.([a-zA-Z0-9]+)(\?|\@|$)/;

            if ( !url || !suffixMatch.test( url ) ) {
                return false;
            }
            res = suffixMatch.exec( url );
            suffix = res[1].toLowerCase();
            for ( var i = 0, l = imageSuffixes.length; i < l; i++ ) {
                if ( suffix === imageSuffixes[i] ) {
                    return true;
                }
            }
            return false;
        },

        checkoutFormat: function(fileName, type){
            if(type === "image"){
                return fans_home.common.uploadFile.isImage(fileName);
            }else if(type === "video"){
                return fans_home.common.uploadFile.isVideo(fileName);
            }
            return false;
        },

        onlyUpload: function(btn, options, eventBindings){
            var config = {
                'uptoken_url': '/qiniu/image_up_token'
            }
            var events = {
                'FileUploaded': function (up, file, info) {
                },
                'FilesAdded': function (up, files) {
                },
                'BeforeUpload': function (up, file) {
                },
                'UploadProgress': function (up, file) {

                },
                'FileUploaded': function (up, file, info) {

                },
                'Error': function (up, err, errTip) {

                },
                'UploadComplete': function (up, file) {

                }
            }
            config = $.extend({max_retries: 3}, config, options);
            events = $.extend({}, events, eventBindings);

            var coverImageUploader = new QiniuUploader();

            config.browse_button = btn;
            events['Error'] = function (up, err, errTip) {
                if(err.status == 401){
                    fans_home.common.dialog.error('页面超时，请刷新页面，重新加载！<br>错误信息：'+errTip);
                }else{
                    fans_home.common.dialog.error('上传出错了！<br>错误信息：'+errTip);
                }
                if(typeof eventBindings.Error == 'function'){
                    eventBindings.Error(up, err, errTip);
                }
            };
            return coverImageUploader.upload(config, events);
        },

        initUploadNew: function (btn, options, eventBindings) {
            var config = {
                'mediaType': "image"
            }
            config = $.extend({}, config, options);

            if (!config.uptoken) {
                if (config.mediaType == "video") {
                    config.uptoken_url = '/qiniu/video_up_token';
                } else {
                    config.uptoken_url = '/qiniu/image_up_token';
                }
            }

                //判断上传文件的类型，如果格式不对，不进行弹出警告框，终止操作
                var media = {"image":"图片", "video":"视频"};
                var originBefore = eventBindings.BeforeUpload;
                var BeforeUpload = function(up, file){
                    if(fans_home.common.uploadFile.checkoutFormat(file.name, config.mediaType)){
                        originBefore(up, file);
                    }else{
                        fans_home.common.dialog.error(media[config.mediaType]+"格式不对!");
                    }
                }
                //修改原先的BeforeUpload事件，添加错误检测
                eventBindings.BeforeUpload = BeforeUpload;

                return fans_home.common.uploadFile.onlyUpload(btn, config, eventBindings);

        },

        isImage: function(url) {
            var res, suffix = "";
            var imageSuffixes = ["png", "jpg", "jpeg", "gif", "bmp"];
            var suffixMatch = /\.([a-zA-Z0-9]+)(\?|\@|$)/;

            if (!url || !suffixMatch.test(url)) {
                return false;
            }
            res = suffixMatch.exec(url);
            suffix = res[1].toLowerCase();
            for (var i = 0, l = imageSuffixes.length; i < l; i++) {
                if (suffix === imageSuffixes[i]) {
                    return true;
                }
            }
            return false;
        }



    }
}();


