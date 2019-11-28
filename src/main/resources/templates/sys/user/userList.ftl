<html>
<head>
    <title>用户管理</title>
    <meta name="decorator" content="default"/>
    <#include "../../layout/header.ftl">
    <style>
        #contentTable{
            font-size: 13px;
        }
    </style>
</head>
<body>
<div id="importBox" class="hide">
    <form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
          class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
        <input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
        <input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
        <a href="${ctx}/sys/user/import/template">下载模板</a>
    </form>
</div>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/sys/user/index">用户列表</a></li>
    <@shiro.hasPermission name="sys:user:form">
        <li><a href="${ctx}/sys/user/form">用户添加</a></li>
    </@shiro.hasPermission>
</ul>
<form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/index" method="post" class="breadcrumb form-search ">
    <input id="pageNo" name="page" type="hidden" value="${users.number}"/>
    <input id="pageSize" name="size" type="hidden" value="${users.size}"/>
    <ul class="ul-form">
        <li><label>登录名：</label><input name="userName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
        <li><label>姓&nbsp;&nbsp;&nbsp;名：</label><input name="realName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
        <li class="btns">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
            <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
            <input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li>
        <li class="clearfix"></li>
    </ul>
</form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead><tr><th class="sort-column login_name">登录名</th><th class="sort-column name">姓名</th><th>电话</th><th>邮箱</th><th>创建日期</th><th>最后登录</th><th>是否可用</th><@shiro.hasPermission name="sys:user:edit"><th>操作</th></@shiro.hasPermission></tr></thead>
    <tbody>
    <#list users.content as user>
        <tr>
            <td><a href="${ctx}/sys/user/form?id=${user.userId}">${user.userName}</a></td>
            <td>${user.realName}</td>
            <td>${user.phoneNum}</td>
            <td>${user.email}</td>
            <td>${user.createTime}</td>
            <td>${user.lastLoginTime}</td>
            <td>${user.enabled?then('可用','禁用')}</td>
            <@shiro.hasPermission name="sys:user:edit">
                <td>
                    <a href="${ctx}/sys/user/form?id=${user.userId}">修改</a>
                    <a href="${ctx}/sys/user/delete?id=${user.userId}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
                </td>
            </@shiro.hasPermission>
        </tr>
    </#list>
    </tbody>
</table>

<div class="pagination">
    <ul>
        <#if users.first>
            <li class="disabled"><a href="javascript:">« 上一页</a></li>
        <#else>
            <li><a href="javascript:" onclick="page(${users.number-1},${users.size},'');">« 上一页</a></li>
        </#if>
        <#assign pages=(users.totalPages>3)?then(3,users.totalPages)>
        <#list 0..<pages as pageNumber>
            <li class="${((users.number)==pageNumber)?then('active','')}"><a href="javascript:" onclick="page(${pageNumber},${users.size},'');">${pageNumber+1}</a></li>
        </#list>
        <#if users.last>
            <li class="disabled"><a href="javascript:">下一页 »</a></li>
        <#else>
            <li><a href="javascript:" onclick="page(${users.number+1},${users.size},'');">下一页 »</a></li>
        </#if>
        <li class="disabled controls">
            <a href="javascript:">
                当前
                <input type="text" value="${users.number+1}"
                       onkeypress="var e=window.event||event;var c=e.keyCode||e.which;if(c==13)page(${users.number},${users.size},'');"
                       onclick="this.select();"> /
                <input type="text"
                       value="${users.size}"
                       onkeypress="var e=window.event||event;var c=e.keyCode||e.which;if(c==13)page(0,this.value,'');"
                       onclick="this.select();">
                条，共 ${users.totalElements} 条
            </a>
        </li>
    </ul>
    <div style="clear:both;"></div>
</div>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        $("#btnExport").click(function(){
            top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
                if(v=="ok"){
                    $("#searchForm").attr("action","${ctx}/sys/user/export");
                    $("#searchForm").submit();
                }
            },{buttonsFocus:1});
            top.$('.jbox-body .jbox-icon').css('top','55px');
        });
        $("#btnImport").click(function(){
            $.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
                bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
        });
    });
    function page(n,s){
        if(n>=0) $("#pageNo").val(n);
        if(s) $("#pageSize").val(s);
        $("#searchForm").attr("action","${ctx}/sys/user/index");
        $("#searchForm").submit();
        return false;
    }
</script>
</html>