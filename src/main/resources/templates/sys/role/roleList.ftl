<html>
<head>
    <title>角色管理</title>
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
    <li class="active"><a href="${ctx}/sys/role/index">角色列表</a></li>
    <@shiro.hasPermission name="sys:role:form">
        <li><a href="${ctx}/sys/role/form">角色添加</a></li>
    </@shiro.hasPermission>
</ul>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <tr><th>角色名称</th><th>英文名称</th><th>角色描述</th><th>角色值</th><@shiro.hasPermission name="sys:role:edit"><th>操作</th></@shiro.hasPermission></tr>
    <#list roles.content as role>
        <tr>
            <td><a href="${ctx}/sys/role/form?id=${role.roleId}">${role.roleName!}</a></td>
            <td><a href="${ctx}/sys/role/form?id=${role.roleId}">${role.enName!}</a></td>
            <td>${role.roleDesc!}</td>
            <td>${role.roleValue!}</td>
            <@shiro.hasPermission name="sys:role:edit">
                <td>
                    <a href="${ctx}/sys/role/assign?roleId=${role.roleId}">权限分配</a>
                    <a href="${ctx}/sys/role/form?id=${role.roleId}">修改</a>
                    <a href="${ctx}/sys/role/delete/${role.roleId}" onclick="return confirmx('确认要删除该角色吗？', this.href)">删除</a>
                </td>
            </@shiro.hasPermission>
        </tr>
    </#list>
</table>
</body>
</html>