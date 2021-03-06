<!DOCTYPE html>
<html>
<head>
    <title>Tlh 平台管理后台</title>
    <#include "header.ftl">
    <meta name="decorator" content="blank"/>
    <style type="text/css">
        #main {padding:0;margin:0;} #main .container-fluid{padding:0 4px 0 6px;}
        #header {margin:0 0 8px;position:static;} #header li {font-size:14px;_font-size:12px;}
        #header .brand {font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:26px;padding-left:33px;}
        #footer {margin:8px 0 0 0;padding:3px 0 0 0;font-size:11px;text-align:center;border-top:2px solid #0663A2;}
        #footer, #footer a {color:#999;} #left{overflow-x:hidden;overflow-y:auto;} #left .collapse{position:static;}
        #userControl>li>a{/*color:#fff;*/text-shadow:none;} #userControl>li>a:hover, #user #userControl>li.open>a{background:transparent;}
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            // 绑定菜单单击事件
            $("#menu a.menu").click(function () {
                // 一级菜单焦点
                $("#menu li.menu").removeClass("active");
                $(this).parent().addClass("active");
                // 左侧区域隐藏
                if ($(this).attr("target") == "mainFrame") {
                    $("#left,#openClose").hide();
                    wSizeWidth();
                    return true;
                }
                // 左侧区域显示
                $("#left,#openClose").show();
                if (!$("#openClose").hasClass("close")) {
                    $("#openClose").click();
                }
                // 显示二级菜单
                var menuId = "#menu-" + $(this).attr("data-id");
                if ($(menuId).length > 0) {//使用存在的数据
                    $("#left .accordion").hide();
                    $(menuId).show();
                    // 初始化点击第一个二级菜单
                    if (!$(menuId + " .accordion-body:first").hasClass('in')) {
                        $(menuId + " .accordion-heading:first a").click();
                    }
                    if (!$(menuId + " .accordion-body li:first ul:first").is(":visible")) {
                        $(menuId + " .accordion-body a:first i").click();
                    }
                } else {
                    // 获取二级菜单数据
                    $.get($(this).attr("data-href"), function (data) {
                        if (data.indexOf("id=\"loginForm\"") != -1) { //处理失效 重新登录 应该到达首页的问题 ，该为shiro处理返回登录界面
                            alert('未登录或登录超时。请重新登录，谢谢！');
                            top.location = "${ctx}";
                            return false;
                        }
                        $("#left .accordion").hide();
                        $("#left").append(data);
                        // 链接去掉虚框
                        $(menuId + " a").bind("focus", function () {
                            if (this.blur) {
                                this.blur()
                            }
                            ;
                        });
                        // 二级标题 添加点击事件，
                        $(menuId + " .accordion-heading a").click(function () {
                            //设置头部样式 设置为折叠
                            $(menuId + " .accordion-toggle i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
                            //保留当前的this对象
                            var _this=this;
                            //判断body是否是打开的，如果是折叠的则打开
                            if (!$($(this).attr('data-href')).hasClass('in')) {
                                $(_this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
                            }
                        });
                        // 二级内容
                        $(menuId + " .accordion-body a").click(function () {
                            $(menuId + " li").removeClass("active");
                            $(menuId + " li i").removeClass("icon-white");
                            $(this).parent().addClass("active");
                            $(this).children("i").addClass("icon-white");
                        });
                        // 默认选中第一个菜单
                        $(menuId + " .accordion-body a:first i").click();
                    });
                }
                // 大小宽度调整
                wSizeWidth();
                return false;
            });
            // 初始化点击第一个一级菜单
            $("#menu a.menu:first span").click();
            // 鼠标移动到边界自动弹出左侧菜单
            $("#openClose").mouseover(function () {
                if ($(this).hasClass("open")) {
                    $(this).click();
                }
            });
        });
    </script>
</head>
<body>
<div id="main">
    <div id="header" class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="brand"><span id="productName">Tlh 平台管理后台</span></div>
            <ul id="userControl" class="nav pull-right">
                <li id="userInfo" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="个人信息">您好,&nbsp;【<@shiro.principal type="org.tlh.examstack.module.sys.entity.User" property="realName"/>】 &nbsp;<span id="notifyNum" class="label label-info hide"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
                        <@shiro.hasPermission name="dashboard:user:pwd">
                            <li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  修改密码</a></li>
                        </@shiro.hasPermission>
                        <li><a href="${ctx}/oa/oaNotify/self" target="mainFrame"><i class="icon-bell"></i>&nbsp;  我的通知 <span id="notifyNum2" class="label label-info hide"></span></a></li>
                    </ul>
                </li>
                <li><a href="${ctx}/logout" title="退出登录">退出</a></li>
                <li>&nbsp;</li>
            </ul>
            <div id="user" style="position:absolute;top:0;right:0;"></div>
            <#-- top menu -->
            <div class="nav-collapse">
                <ul id="menu" class="nav" style="*white-space:nowrap;float:none;">
                    <#list topMenus as menu>
                        <@shiro.hasPermission name="${menu.permission}">
                            <li class="menu ${(menu?counter==1)?then('active','')}">
                                <a class="menu" href="javascript:" data-href="${ctx}/sys/menu/tree?parentId=${menu.id}" data-id="${menu.id}"><span>${menu.title}</span></a>
                            </li>
                        </@shiro.hasPermission>
                    </#list>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>
    <div class="container-fluid">
        <div id="content" class="row-fluid">
            <#-- left menu -->
            <div id="left"></div>
            <div id="openClose" class="close">&nbsp;</div>
            <#-- content -->
            <div id="right">
                <iframe id="mainFrame" name="mainFrame" src="" scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
            </div>
        </div>
        <#include "footer_main.ftl">
    </div>
</div>
<script type="text/javascript">
    var leftWidth = 160; // 左侧窗口大小
    var tabTitleHeight = 33; // 页签的高度
    var htmlObj = $("html"), mainObj = $("#main");
    var headerObj = $("#header"), footerObj = $("#footer");
    var frameObj = $("#left, #openClose, #right, #right iframe");
    function wSize(){
        var minHeight = 500, minWidth = 980;
        var strs = getWindowSize().toString().split(",");
        htmlObj.css({"overflow-x":strs[1] < minWidth ? "auto" : "hidden", "overflow-y":strs[0] < minHeight ? "auto" : "hidden"});
        mainObj.css("width",strs[1] < minWidth ? minWidth - 10 : "auto");
        frameObj.height((strs[0] < minHeight ? minHeight : strs[0]) - headerObj.height() - footerObj.height() - (strs[1] < minWidth ? 42 : 28));
        $("#openClose").height($("#openClose").height() - 5);
        wSizeWidth();
    }
    function wSizeWidth(){
        if (!$("#openClose").is(":hidden")){
            var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
            $("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
        }else{
            $("#right").width("100%");
        }
    }
</script>
<script src="${ctx}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>