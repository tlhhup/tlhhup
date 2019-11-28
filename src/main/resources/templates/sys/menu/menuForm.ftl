<html>
<head>
    <title>菜单管理</title>
    <meta name="decorator" content="default"/>
    <#include "../../layout/header.ftl">
    <#include "../../commons/tags.ftl">
    <script type="text/javascript">
        $(document).ready(function() {
            $("#name").focus();
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
    <li><a href="${ctx}/sys/menu/index">菜单列表</a></li>
    <li class="active"><a href="${ctx}/sys/menu/form">菜单<@shiro.hasPermission name="sys:menu:edit">${(menu.id??)?then('修改','添加')}</@shiro.hasPermission><@shiro.lacksPermission name="sys:menu:edit">查看</@shiro.lacksPermission></a></li>
</ul><br/>
<form id="inputForm" action="${ctx}/sys/menu/save" method="post" class="form-horizontal">
    <input type="hidden" name="id" value="${menu.id!}">
    <div class="control-group">
        <label class="control-label">上级菜单:</label>
        <div class="controls">
            <@treeselect id="menu" name="parent.id" value="${(menu.parent??)?then(menu.parent.id,'')}" labelName="parent.title" labelValue="${(menu.parent??)?then(menu.parent.title,'')}"
                            title="菜单" url="/sys/menu/treeData" extId="${menu.id!}" cssStyle="height: 30px;background-color: #ffffff"/>
        </div>
    </div>
    <script type="text/javascript">top.$.jBox.closeTip();</script>
    <div class="control-group">
        <label class="control-label">名称:</label>
        <div class="controls">
            <input name="title" htmlEscape="false" maxlength="50" class="required input-xlarge" value="${menu.title!}"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">链接:</label>
        <div class="controls">
            <input name="url" htmlEscape="false" maxlength="2000" class="input-xxlarge" value="${menu.url!}"/>
            <span class="help-inline">点击菜单跳转的页面</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">目标:</label>
        <div class="controls">
            <input name="target" htmlEscape="false" maxlength="10" class="input-small" value="${menu.target!}"/>
            <span class="help-inline">链接地址打开的目标窗口，默认：mainFrame</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">图标:</label>
        <div class="controls">
            <@iconselect id="icon" name="icon" value="${menu.icon!}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">排序:</label>
        <div class="controls">
            <input name="sort" htmlEscape="false" maxlength="50" class="required digits input-small" value="${menu.sort!}"/>
            <span class="help-inline">排列顺序，升序。</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">可见:</label>
        <div class="controls">
            <input name="isShow" type="radio" htmlEscape="false" value="1" class="required" ${(menu.isShow??)?then(menu.isShow?then('checked',''),'checked')}>显示
            <input name="isShow" type="radio" htmlEscape="false" value="0" class="required" ${(menu.isShow??)?then((!menu.isShow)?then('checked',''),'')}>隐藏
            <span class="help-inline">该菜单或操作是否显示到系统菜单中</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">权限标识:</label>
        <div class="controls">
            <input name="permission" htmlEscape="false" maxlength="100" class="required input-xxlarge" value="${menu.permission!}"/>
            <span class="help-inline">控制器中定义的权限标识，如：@RequiresPermissions("权限标识")</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <textarea name="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xxlarge">${menu.remarks!}</textarea>
        </div>
    </div>
    <div class="form-actions">
        <@shiro.hasPermission name="sys:menu:edit">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        </@shiro.hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form>
</body>
</html>