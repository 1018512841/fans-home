
fans_home.common.dialog = function () {
    return {


        layerTip: function(str, dom, args){
            var config = {
                guide: 1,
                time:0,
                style: ['background-color:#f90; color:#fff', '#f90'],
                maxWidth:240
            }
            config = $.extend({}, config, args);
            layer.tips(str, dom, config);
        },

        //显示警示信息	第二个参数为 多少秒后消失
        warn: function (msg, time) {
            if (arguments.length >= 2) {
                layer.msg(msg || '警告', time || 0, 0);
            } else {
                layer.alert(msg || '警告', 0, '');
            }
        },

        //显示错误信息
        error: function(str){
            layer.alert(str, 8, '错误'); //风格一
        },

        //显示错误信息
        alert: function(title, msg){
            if((typeof msg=='undefined') || (msg.length == 0)){
                msg = "－"
            }
            if((typeof title=='undefined') || (title.length == 0)){
                title = "标题"
            }
            layer.alert(msg, 8, title); //风格一
        },

        success: function(title, msg){
            if((typeof msg=='undefined') || (msg.length == 0)){
                msg = "－"
            }
            if((typeof title=='undefined') || (title.length == 0)){
                title = "标题"
            }
            layer.alert(msg, 1, title); //风格一
        },

        //显示成功信息	第二个参数为 多少秒后消失
        successTime: function(msg,time,fn){
            if(arguments.length >= 2){
                layer.msg(msg || '成功', time || 0,1);
            } else{
                layer.alert(msg || '成功',1,'');
            }
        },

        //弹出加载中的提示
        startLoading: function(str){
            return layer.load(str,0);
        },

        //关闭loading
        closeLoading: function(loadi){
            layer.close(loadi);
        },

        //弹出信息输入框
        prompt: function(str,val,fun){
            layer.prompt({title: str,type: 0, val: val}, function(pass){
                fun(pass);
            });
        },

        image: function(imgId,width,height,title){
            var i = $.layer({
                type : 1,
                title : title,
                fix : true,
//                offset:[$(window ).width()/4+'px' , $(window ).height()/4+'px'],
                area : ['auto','auto'],
                shadeClose : true,
                page : {dom : '#'+imgId}
            });

        },

        //对话框 默认可不传
        confirm: function (msg, btn, ok, esc) {
            var btns = 2;
            if (btn == undefined) {
                btns = 1;
            }
            var idx = $.layer({
                shade: [0.8, '#fff'],
                offset: ['10%', ''],
                title: ['', 'background:none; border:none; height: 0;'],
                move: false,
                closeBtn: false,
                border: [0],
                shadeClose: false,
                area: ['auto', 'auto'],
                dialog: {
                    msg: msg || '成功',
                    btns: btns,
                    type: -1,
                    btn: btn || ['确定', '取消'],
                    yes: function () {
                        if (ok) {
                            ok();
                        }
                        layer.close(idx);
                    }, no: function () {
                        if (esc) {
                            esc();
                        }
                    }
                }
            });
            //return $.layer(defaults);
        },

        //页面层
        page: function (id, top, title) {
            layer.closeAll();
            title == undefined ? title = ['', 'background:none; border: none'] : title = [title, 'background:none;'];
            var obj = $.layer({
                type: 1,
                shade: [0.6, '#000'],
                offset: [top || '20%', ''],
                title: title || '0',
                move: false,
                closeBtn: [0, true],
                border: [0],
                shadeClose: false,
                area: ['auto', 'auto'],
                page: {dom: id}
            });
            //将调用layer时返回的索引值保存起来
            $(id).data('layerObj', obj)
        }
    }

}();