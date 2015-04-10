/*
 This is the base object. All the other js function are a attribute of fans_home

 */

var fans_home = {
    dashboard: {},
    user_screen:{},
    life_post:{},
    blog:{},
    common:{}
};

fans_home.common.other = function () {
    return {
        //生成随机数字
        getRandom: function (n) {
            return Math.floor(Math.random() * n + 1)
        },

        //绑定事件，使input只能输入数字
        onlyNumber: function ( $dom ) {
            var reg =  /[^0-9]/g;
            fans_home.common.other.onlyRegular($dom, reg);
        },

        //绑定事件，使input只能输入数字和点
        onlyPrice: function ( $dom ) {
            var reg =  /[^0-9]/g;
            fans_home.common.other.onlyRegular($dom, reg);
        },

        //绑定事件，使input只能输入数字和－
        onlyPhoneNum: function ( $dom ) {
            var reg = /[^0-9\-]/g;
            fans_home.common.other.onlyRegular($dom, reg);
        },

        //绑定事件，保留匹配的正则表达式
        onlyRegular: function($dom, reg){
            $dom.keyup( function () {
                $( this ).val( $( this ).val().replace( reg, '' ) );
            } ).bind( "paste", function () {  //CTR+V事件处理
                $( this ).val( $( this ).val().replace( reg, '' ) );
            } );
        },
        //光标定位到元素上
        elementFocus: function ( $dom ) {
            $( "html,body" ).animate( {"scrollTop": $dom.offset().top - 50}, 500, function () {
                $dom.focus();
            } );
        },

        //检测邮箱号，返回常见邮箱的登录页面
        detect_email: function(email){
            var hash = {
                'qq.com': 'http://mail.qq.com',
                'gmail.com': 'http://mail.google.com',
                'sina.com': 'http://mail.sina.com.cn',
                '163.com': 'http://mail.163.com',
                '126.com': 'http://mail.126.com',
                'yeah.net': 'http://www.yeah.net/',
                'sohu.com': 'http://mail.sohu.com/',
                'tom.com': 'http://mail.tom.com/',
                'sogou.com': 'http://mail.sogou.com/',
                '139.com': 'http://mail.10086.cn/',
                'hotmail.com': 'http://www.hotmail.com',
                'live.com': 'http://login.live.com/',
                'live.cn': 'http://login.live.cn/',
                'live.com.cn': 'http://login.live.com.cn',
                '189.com': 'http://webmail16.189.cn/webmail/',
                'eyou.com': 'http://www.eyou.com/',
                '21cn.com': 'http://mail.21cn.com/',
                '188.com': 'http://www.188.com/',
                'foxmail.com': 'http://mail.foxmail.com'
            };
            var url = email.split( '@' )[1];

            if ( hash[url] ) {
                return hash[url];
            } else {
                return 'http://www.baidu.com/s?wd=' + url + '%20邮箱'
            }
        },

        baiduMapImage: function(lngTemp, latTemp, width, height){
            var mapUrl = "http://api.map.baidu.com/staticimage?center=";
            mapUrl+=lngTemp;
            mapUrl+=",";
            mapUrl+=latTemp;
            mapUrl+="&width="+width+"&height="+height+"&zoom=11&markers=";
            mapUrl+=lngTemp;
            mapUrl+=",";
            mapUrl+=latTemp;
            mapUrl+="&markerStyles=-1";
            return mapUrl
        },

        replaceEmoji: function(str){
            var reg = /\[.*?\]/ig;
            return str.replace(reg,fans_home.common.other.emoji);
        },

        emoji:function(m,p1,str){
            var emojiMap = {
                "大笑": "daxiao",
                "两眼放光": "fangguang",
                "抠鼻": "koubi",
                "不高兴": "bugaoxing",
                "吐舌": "tushe",
                "委屈": "weiqu",
                "微笑": "weixiao",
                "吓": "xia",
                "鄙视": "bishi",
                "不高": "bugaoxing",
                "大哭": "daku",
                "鼓掌": "guzhang",
                "汗": "han",
                "酷": "ku",
                "亲亲": "qinqin",
                "生气": "shengqi",
                "喜欢": "xihuan",
                "晕": "yun",
                "抓狂": "zhuakuang",
                "打": "da",
                "哈欠": "haqian",
                "哼": "heng",
                "撇嘴": "piezui",
                "睡觉": "shuijiao",
                "微笑": "weixiao",
                "再见": "zaijian",
                "坏笑": "huaixiao",
                "可怜": "kelian",
                "贱笑": "jianxiao",
                "疑问": "yiwen",
                "无语": "wuyu",
                "怒骂": "numa",
                "困": "kun",
                "口罩": "kouzhao",
                "赞": "zan",
                "ok": "ok",
                "耶": "ye",
                "闭嘴": "bizui"
            }
            var key = arguments[0];
            key = key.substring(1,key.length-1);
            var img = '';
            if(emojiMap[key]){
                img =  "/assets/backend/emoji/"+emojiMap[key]+"@2x.png";
                return '<img src="'+img+'" class="emoji-img">';
            }else{
                return arguments[0];
            }
        },

        changeUrl: function(url){
            var stateObject = {};
            var title = document.title;
            var newUrl = url;
            history.pushState(stateObject,title,newUrl);
        }
    }
}();
