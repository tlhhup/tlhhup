<html>
<head>
    <title>用户管理</title>
    <meta name="decorator" content="default"/>
    <#include "../../layout/header.ftl">
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/sys/user/index">用户列表</a></li>
    <li class="active"><a href="${ctx}/sys/user/form?id=${user.userId!}">用户<@shiro.hasPermission name="sys:user:edit">${(user.userId??)?then('修改','添加')}</@shiro.hasPermission><@shiro.lacksPermission name="sys:user:edit">查看</@shiro.lacksPermission></a></li>
</ul><br/>
<form id="inputForm" action="${ctx}/sys/user/save" method="post" class="form-horizontal">
    <script type="text/javascript">top.$.jBox.closeTip();</script>
    <input type="hidden" name="userId" value="${user.userId!}">
    <div class="control-group">
        <label class="control-label">登录名:</label>
        <div class="controls">
            <input name="userName" htmlEscape="false" maxlength="50" class="required userName" ${(user.userId??)?then('readonly','')} value="${user.userName!}"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">姓名:</label>
        <div class="controls">
            <input name="realName" htmlEscape="false" maxlength="50" class="required" value="${user.realName!}"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">密码:</label>
        <div class="controls">
            <input id="newPassword" name="password" type="password" value="${user.password!}" maxlength="50" minlength="3" class="${(!user.userId??)?then('required','')}"/>
            <#if !user.userId??><span class="help-inline"><font color="red">*</font> </span></#if>
            <#if user.userId??><span class="help-inline">若不修改密码，请留空。</span></#if>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">确认密码:</label>
        <div class="controls">
            <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="${user.password!}" maxlength="50" minlength="3" equalTo="#newPassword"/>
            <#if !user.userId??><span class="help-inline"><font color="red">*</font> </span></#if>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">邮箱:</label>
        <div class="controls">
            <input name="email" htmlEscape="false" maxlength="100" class="email" value="${user.email!}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">电话:</label>
        <div class="controls">
            <input name="phoneNum" htmlEscape="false" maxlength="100" value="${user.phoneNum!}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">是否允许登录:</label>
        <div class="controls">
            <input name="enabled" type="radio" htmlEscape="false" class="required" value="1" ${(user.enabled??)?then(user.enabled?then('checked',''),'checked')}>是
            <input name="enabled" type="radio" htmlEscape="false" class="required" value="0" ${(user.enabled??)?then((!user.enabled)?then('checked',''),'')}>否
            <span class="help-inline"><font color="red">*</font> “是”代表此账号允许登录，“否”则表示此账号不允许登录</span>
        </div>
    </div>
    <#if user.userId??>
        <div class="control-group">
            <label class="control-label">创建时间:</label>
            <div class="controls">
                <label class="lbl">${user.createTime!}</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">最后登陆:</label>
            <div class="controls">
                <label class="lbl">${user.lastLoginTime!}</label>
            </div>
        </div>
    </#if>
    <div class="form-actions">
        <@shiro.hasPermission name="sys:user:edit">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        </@shiro.hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        $("#no").focus();
        $("#inputForm").validate({
            rules: {
                <#if !user.userId??>
                userName: {
                    remote: "${ctx}/sys/user/checkLoginName"
                }
                </#if>
            },
            messages: {
                userName: {remote: "用户登录名已存在"},
                confirmNewPassword: {equalTo: "输入与上面相同的密码"}
            },
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
</html>