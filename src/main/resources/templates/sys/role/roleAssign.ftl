<html>
<head>
    <title>分配角色</title>
    <meta name="decorator" content="default"/>
    <#include "../../layout/header.ftl">
    <style>
        #contentTable{
            font-size: 13px;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/sys/role/index">角色列表</a></li>
    <li class="active"><a href="${ctx}/sys/role/assign?id=${role.roleId!}">角色分配</a></li>
</ul>
<div class="container-fluid breadcrumb">
    <div class="row-fluid span12">
        <span class="span4">角色名称: <b>${role.roleName!}</b></span>
        <span class="span4">英文名称: ${role.enName!}</span>
    </div>
</div>
<div class="breadcrumb">
    <#-- 分配用户信息 -->
    <form id="assignRoleForm" action="${ctx}/sys/role/assignrole" method="post" class="hide">
        <input type="hidden" name="roleId" value="${role.roleId}"/>
        <input id="idsArr" type="hidden" name="userIds" value=""/>
    </form>
    <input id="assignButton" class="btn btn-primary" type="submit" value="分配角色"/>
    <script type="text/javascript">
        $("#assignButton").click(function(){
            top.$.jBox.open("iframe:${ctx}/sys/role/usertorole?roleId=${role.roleId}", "分配角色",810,$(top.document).height()-240,{
                buttons:{"确定分配":"ok", "清除已选":"clear", "关闭":true}, bottomText:"通过选择部门，然后为列出的人员分配角色。",submit:function(v, h, f){
                    var pre_ids = h.find("iframe")[0].contentWindow.pre_ids;
                    var ids = h.find("iframe")[0].contentWindow.ids;
                    //nodes = selectedTree.getSelectedNodes();
                    if (v=="ok"){
                        // 删除''的元素
                        if(ids[0]==''){
                            ids.shift();
                            pre_ids.shift();
                        }
                        if(pre_ids.sort().toString() == ids.sort().toString()){
                            top.$.jBox.tip("未给角色【${role.roleName}】分配新成员！", 'info');
                            return false;
                        };
                        // 执行保存
                        loading('正在提交，请稍等...');
                        var idsArr = "";
                        for (var i = 0; i<ids.length; i++) {
                            idsArr = (idsArr + ids[i]) + (((i + 1)== ids.length) ? '':',');
                        }
                        $('#idsArr').val(idsArr);
                        $('#assignRoleForm').submit();
                        return true;
                    } else if (v=="clear"){
                        h.find("iframe")[0].contentWindow.clearAssign();
                        return false;
                    }
                }, loaded:function(h){
                    $(".jbox-content", top.document).css("overflow-y","hidden");
                }
            });
        });
    </script>
</div>
<script type="text/javascript">top.$.jBox.closeTip();</script>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr><th>登录名</th><th>姓名</th><th>电话</th><th>邮件</th><th>操作</th></tr></thead>
    <tbody>
    <#list users as user>
        <tr>
            <td><a href="${ctx}/sys/user/form?id=${user.userId}">${user.userName}</a></td>
            <td>${user.realName!}</td>
            <td>${user.phoneNum!}</td>
            <td>${user.email!}</td>
            <td>
                <a href="${ctx}/sys/role/outrole?userId=${user.userId}&roleId=${role.roleId}"
                   onclick="return confirmx('确认要将用户<b>[${user.userName}]</b>从<b>[${role.roleName}]</b>角色中移除吗？', this.href)">移除</a>
            </td>
        </tr>
    </#list>
    </tbody>
</table>
</body>
</html>
