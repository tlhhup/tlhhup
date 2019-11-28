<html>
<head>
    <title>菜单管理</title>
    <meta name="decorator" content="default"/>
    <#include "../../layout/header.ftl">
    <style>
        #treeTable{
            font-size: 13px;
        }
    </style>
    <link href="${ctx}/treeTable/themes/vsStyle/treeTable.min.css" rel="stylesheet" type="text/css">
    <script src="${ctx}/treeTable/jquery.treeTable.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#treeTable").treeTable({expandLevel : 3}).show();
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/sys/menu/index">菜单列表</a></li>
    <@shiro.hasPermission name="sys:menu:form">
        <li><a href="${ctx}/sys/menu/form">菜单添加</a></li>
    </@shiro.hasPermission>
</ul>
<form id="listForm" method="post">
    <table id="treeTable" class="table table-striped table-bordered table-condensed">
        <thead><tr><th>名称</th><th>链接</th><th style="text-align:center;">排序</th><th>可见</th><th>权限标识</th><@shiro.hasPermission name="sys:menu:edit"><th>操作</th></@shiro.hasPermission></tr></thead>
        <tbody>
        <#list menus as menu>
            <tr id="${menu.id}" pId="${(menu.parent??)?then(menu.parent.id!,'0')}">
                <td nowrap><i class="icon-${(menu.icon??)?then(menu.icon,'hide')}"></i><a href="${ctx}/sys/menu/form?id=${menu.id!}">${menu.title!}</a></td>
                <td title="${menu.url!}">${menu.url!}</td>
                <td style="text-align:center;">
                    ${menu.sort!}
                </td>
                <td>${menu.isShow ?then('显示','隐藏')}</td>
                <td title="${menu.permission!}">${menu.permission!}</td>
                <@shiro.hasPermission name="sys:menu:edit">
                    <td nowrap>
                        <a href="${ctx}/sys/menu/form?id=${menu.id!}">修改</a>
                        <a href="${ctx}/sys/menu/delete?id=${menu.id!}" onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)">删除</a>
                        <a href="${ctx}/sys/menu/form?parent.id=${menu.id!}">添加下级菜单</a>
                    </td>
                </@shiro.hasPermission>
            </tr>
        </#list>
        </tbody>
    </table>
</form>
</body>
</html>