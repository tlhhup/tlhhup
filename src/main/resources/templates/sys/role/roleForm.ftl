<html>
<head>
    <title>角色管理</title>
    <meta name="decorator" content="default"/>
    <#include "../../layout/header.ftl">
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/sys/role/index">角色列表</a></li>
    <li class="active"><a href="${ctx}/sys/role/form?id=${role.roleId!}">角色<@shiro.hasPermission name="sys:role:edit">${(role.roleId??)?then('修改','添加')}</@shiro.hasPermission><@shiro.lacksPermission name="sys:role:edit">查看</@shiro.lacksPermission></a></li>
</ul>
<br/>
<form id="inputForm" action="${ctx}/sys/role/save" method="post" class="form-horizontal">
    <input name="roleId" type="hidden" value="${role.roleId!}"/>
    <div class="control-group">
        <label class="control-label">角色名称:</label>
        <div class="controls">
            <input name="roleName" htmlEscape="false" maxlength="50" class="required" value="${role.roleName!}"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">英文名称:</label>
        <div class="controls">
            <input name="enName" htmlEscape="false" maxlength="50" class="required" value="${role.enName!}"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">角色值:</label>
        <div class="controls">
            <input name="roleValue" htmlEscape="false" maxlength="50" class="required" value="${role.roleValue!}"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">角色授权:</label>
        <div class="controls">
            <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
            <input type="hidden" name="menuIds" id="menuIds">
        </div>
    </div>
    <#if message??>
        <div id="messageBox" class="alert alert-error">
            <button data-dismiss="alert" class="close">×</button>
        ${message}
        </div>
    </#if>
    <#-- 关闭错误提示 -->
    <script type="text/javascript">top.$.jBox.closeTip();</script>
    <div class="control-group">
        <label class="control-label">角色描述:</label>
        <div class="controls">
            <textarea name="roleDesc" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge">${role.roleDesc!}</textarea>
        </div>
    </div>
    <div class="form-actions">
        <@shiro.hasPermission name="sys:role:edit">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        </@shiro.hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form>
</body>
<link href="${ctx}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
<script src="${ctx}/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#roleName").focus();
        $("#inputForm").validate({
            rules: {
                roleValue: {required: true},
            <#if !role.roleId??>
                roleName: {
                    remote: {
                        url: "${ctx}/sys/role/checkName",
                        type: 'POST',
                        data: {
                            roleName: function () {
                                return $("#inputForm input[name='roleName']").val()
                            }
                        }
                    }
                },
                enName: {
                    remote: {
                        url: "${ctx}/sys/role/checkEnName",
                        type:'POST',
                        data: {
                            enName: function () {
                                return $("#inputForm input[name='enName']").val()
                            }
                        }
                    }
                }
            </#if>
            },
            messages: {
                roleName: {remote: "角色名已存在"},
                enName: {remote: "角色名已存在"},
                roleValue: {required: "角色值必填"}
            },
            submitHandler: function (form) {
                var ids = [], nodes = tree.getCheckedNodes(true);
                for(var i=0; i<nodes.length; i++) {
                    ids.push(nodes[i].id);
                }
                $("#menuIds").val(ids);
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorContainer: "#messageBox",
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });

        //初始化权限
        var setting = {
            check: {enable: true, nocheckInherit: true}, view: {selectedMulti: false},
            data: {simpleData: {enable: true}},
            callback: {
                beforeClick: function (id, node) {
                    tree.checkNode(node, !node.checked, true, true);
                    return false;
                }
            }
        };

        // 用户-菜单
        var zNodes=[
            <#list menus as menu>
                {id:"${menu.id}", pId:"${(menu.parent??)?then(menu.parent.id,'0')}", name:"${(menu.parent??)?then(menu.title,'权限列表')}"},
            </#list>
        ];
        // 初始化树结构
        var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
        // 不选择父节点
        tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
        // 默认选择节点
        <#if menuIds??>
            <#list menuIds as id>
                var node = tree.getNodeByParam("id", '${id}');
                try{tree.checkNode(node, true, false);}catch(e){}
            </#list>
        </#if>
        // 默认展开全部节点
        tree.expandAll(true);
    });
</script>
</html>