<html>
<head>
    <title>个人信息</title>
    <meta name="decorator" content="default"/>
    <#include "../../layout/header.ftl">
    <script type="text/javascript">
        $(document).ready(function() {
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/sys/user/info">个人信息</a></li>
    <@shiro.hasPermission name="dashboard:user:pwd">
        <li><a href="${ctx}/sys/user/modifyPwd">修改密码</a></li>
    </@shiro.hasPermission>
</ul><br/>
<form id="inputForm"  action="${ctx}/sys/user/info" method="post" class="form-horizontal">
    <input type="hidden" name="userId" value="${user.userId}">
    <#if message??>
        <div id="messageBox" class="alert alert-error">
            <button data-dismiss="alert" class="close">×</button>
            ${message}
        </div>
    </#if>
    <#-- 关闭错误提示 -->
    <script type="text/javascript">top.$.jBox.closeTip();</script>
    <div class="control-group">
        <label class="control-label">用户名:</label>
        <div class="controls">
            <input name="userName" htmlEscape="false" maxlength="50" class="required" readonly="true" value="${user.userName!}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">姓名:</label>
        <div class="controls">
            <input name="realName" htmlEscape="false" maxlength="50" class="required" value="${user.realName!}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">邮箱:</label>
        <div class="controls">
            <input name="email" htmlEscape="false" maxlength="50" class="email" value="${user.email!}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">电话:</label>
        <div class="controls">
            <input name="phoneNum" htmlEscape="false" maxlength="50" value="${user.phoneNum!}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">上次登录:</label>
        <div class="controls">
            <label class="lbl">时间：<#if user.lastLoginTime??>${user.lastLoginTime?datetime}</label></#if>
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
    </div>
</form>
</body>
</html>