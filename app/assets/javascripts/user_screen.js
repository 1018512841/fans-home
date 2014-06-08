/*
 * Javascript function for User screen
 * @author：fanxiaopeng
 */

fans_home.user_screen = function () {
    return {
        /*
         * @function： init_user_index
         * @param：none
         */
        init_user_index: function () {
            var selected_row_number = 0;
            var $user_table_edit_btn = $("#user_table_edit_btn");
            var $user_table_delete_btn = $("#user_table_delete_btn");
            var $user_table_list = $('#user_table_list');
            var oLanguage = {};
            if ($("#i18n_locale").val() == "zh") {
                oLanguage = {
                    "sProcessing": "处理中...",
                    "sLengthMenu": "显示_MENU_ 项结果",
                    "sZeroRecords": "没有匹配结果",
                    "sInfo": "显示第_START_ 至_END_ 项结果，共_TOTAL_ 项",
                    "sInfoEmpty": "显示第0 至0 项结果，共0 项",
                    "sInfoFiltered": "(由_MAX_项结果过滤)",
                    "sSearch": "搜索:",
                    "oPaginate": {
                        "sPrevious": "前一页",
                        "sNext": "后一页"
                    }
                };
            }

            // 使用datatable插件请求数据，POST方式
            var user_datatable_obj = $user_table_list.dataTable({
                "ajax": '/users/user_list',
                "sServerMethod": "POST",
                "oLanguage": oLanguage//国际化

            });

            var $user_table_body = $user_table_list.find('tbody');

            // 为表格中的每一行添加click事件，切换选中的颜色和button的状态
            $user_table_body.on('click', 'tr', function () {

                if ($(this).find("td").attr("class") == "dataTables_empty") {
                    return;
                }

                $(this).toggleClass('selected');
                fans_home.user_screen.controle_btn_status(selected_row_number, $user_table_body, $user_table_edit_btn, $user_table_delete_btn);
            });

            // 点击删除button时，获取选中的记录，并删除选中的记录
            $user_table_delete_btn.click(function () {
                if (confirm("Are you sure?")) {
                    var delete_user_id_list = [];
                    $user_table_body.find(".selected").each(function (i) {
                        delete_user_id_list.push($(this).find(".user_link").attr("user_id"));
                    });

                    if (delete_user_id_list.length == 0) {
                        return;
                    }
                    fans_home.user_screen.delete_users_by_ajax(delete_user_id_list, $user_table_body, user_datatable_obj);
                }

            });

            // 点击编辑button时，获取选中的记录的user ID，并跳转到编辑页面
            $user_table_edit_btn.click(function () {
                var delete_user_id = $user_table_body
                    .find(".selected").first()
                    .find(".user_link").attr("user_id");
                fans_home.user_screen.jump_to_edit_page(delete_user_id)
            })
        },

        /*
         * controle button status by selected rows
         * @function： controle_btn_status
         * @param：{array} selected row list
         * @param：{object} User table body element of jQuery object
         * @param：{object} Edit button element of jQuery object
         * @param：{object} Delete button element of jQuery object
         * @returns null
         */
        controle_btn_status: function (selected_row_number, $user_table_body, $user_table_edit_btn, $user_table_delete_btn) {
            selected_row_number = $user_table_body.find(".selected").length;
            if (selected_row_number == 1) {
                $user_table_edit_btn.removeAttr("disabled");
            } else {
                $user_table_edit_btn.attr("disabled", "disabled");
            }

            if (selected_row_number > 0) {
                $user_table_delete_btn.removeAttr("disabled");
            } else {
                $user_table_delete_btn.attr("disabled", "disabled");
            }
        },

        /*
         * Send selected user IDs to server by ajax, show response message
         * @function： delete_users_by_ajax
         * @param：{array} selected User ID list
         * @param：{object} User table body element of jQuery object
         * @param：{object} jQuery datatable object of User table
         * @returns null
         */
        delete_users_by_ajax: function (delete_user_id_list, $user_table_body, user_datatable_obj) {
            var option = {
                url: "/users/destroy_users",
                type: "post",
                data: {
                    user_ids: delete_user_id_list
                },
                success: function (data) {
                    var row, row_index;
                    $user_table_body.find(".selected").each(function () {
                        row = $(this).closest("tr").get(0);
                        row_index = user_datatable_obj.fnGetPosition(row);
                        user_datatable_obj.fnDeleteRow(row_index, null, false);
                    });

                    user_datatable_obj.fnDraw();

                    var message_html = '<div class="alert alert-' + data.status + '">' +
                        data.message.join("<br>") + '</div>'

                    $(".user_operation_message").html(message_html);
                    $("#user_table_delete_btn").attr("disabled", "disabled");
                }
            };
            $.ajax(option);
        },

        /*
         * Juno to edit page of selected User by javascript Location fucntion
         * @function： jump_to_edit_page
         * @param：{string} selected User ID
         * @returns null
         */
        jump_to_edit_page: function (delete_user_id) {
            window.location = "/users/" + delete_user_id + "/edit";
        },

        /*
         * control the submit button for User form
         * @function： user_new_edit_form_panel
         * @param：null
         * @returns null
         */
        user_new_edit_form_panel: function () {
            $("#user_name_field, #user_email_field, #user_password_field, #user_password_confirmation_field")
                .on("keyup change", function () {
                    var name_length = $("#user_name_field").val().trim().length;
                    var email_length = $("#user_email_field").val().trim().length;
                    var password_length = $("#user_password_field").val().trim().length;
                    var password_confirmation_length = $("#user_password_confirmation_field").val().trim().length;
                    var $submit_btn = $(".user_new_edit_form .user_form_btn");
                    if (name_length > 0 && email_length > 0 && password_length > 0 && password_confirmation_length > 0) {
                        $submit_btn.removeAttr("disabled");
                    } else {
                        $submit_btn.attr("disabled", "disabled");
                    }
                });
        },

        init_user_login_screen: function () {
            fans_home.user_screen.init_status_of_login_form();
            $("#inputEmail, #inputPassword").on("keyup change", function () {
                fans_home.user_screen.init_status_of_login_form();
            });

            $("#user_login_btn").click(function () {
                var validation_valid = true;
                var $email = $("#inputEmail");
                var $password = $("#inputPassword");
                if ($.trim($email.val()).length == 0) {
                    $email.parents(".control-group").addClass("error");
                    $email.siblings("span").text($("#i18n_can_not_be_blank").val());
                    validation_valid = false;
                }
                if ($.trim($password.val()).length == 0) {
                    $password.parents(".control-group").addClass("error");
                    $password.siblings("span").text($("#i18n_can_not_be_blank").val());
                    validation_valid = false;
                }
                if (validation_valid) {
                    fans_home.user_screen.check_user_login_by_ajax();
                }
            })
        },

        init_status_of_login_form: function () {
            var email_length = $("#inputEmail").val().trim().length;
            var password_length = $("#inputPassword").val().trim().length;
            var $submit_btn = $("#user_login_btn");
            if (email_length > 0 && password_length > 0) {
                $submit_btn.removeAttr("disabled");
            } else {
                $submit_btn.attr("disabled", "disabled");
            }
        },

        check_user_login_by_ajax: function () {
            var options = {
                url: "/users/check_login",
                type: "POST",
                data: $("#user_login_form").serialize(),
                success: function (data) {
                    var back_url = $("#login_success_jump_url").val();
                    if (data.status == "success") {
                        window.location = back_url;
                    } else {
                        $.each(data.message, function (id, message) {
                            $("#" + id).next().text(message);
                        })
                    }

                }

            };
            $.ajax(options);
        }

    }
}();
