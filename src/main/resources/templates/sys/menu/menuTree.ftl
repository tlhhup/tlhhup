<#--<html>
<head>
    <title>菜单导航</title>
    <meta name="decorator" content="blank"/>
    <#include "../../commons/header.ftl">
    <script type="text/javascript">
        $(document).ready(function() {
            $(".accordion-heading a").click(function(){
                $('.accordion-toggle i').removeClass('icon-chevron-down');
                $('.accordion-toggle i').addClass('icon-chevron-right');
                if(!$($(this).attr('href')).hasClass('in')){
                    $(this).children('i').removeClass('icon-chevron-right');
                    $(this).children('i').addClass('icon-chevron-down');
                }
            });
            $(".accordion-body a").click(function(){
                $("#menu-${parentId} li").removeClass("active");
                $("#menu-${parentId} li i").removeClass("icon-white");
                $(this).parent().addClass("active");
                $(this).children("i").addClass("icon-white");
                //loading('正在执行，请稍等...');
            });
            //$(".accordion-body a:first i").click();
            //$(".accordion-body li:first li:first a:first i").click();
        });
    </script>
</head>
<body>-->
<div class="accordion" id="menu-${parentId}">
    <#list leftMenus as menu>
        <@shiro.hasPermission name="${menu.permission}">
            <div class="accordion-group">
                <div class="accordion-heading">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#menu-${parentId}" data-href="#collapse-${menu.id}" href="#collapse-${menu.id}" title="${menu.remarks}"><i class="icon-chevron-${(menu?counter==1) ?then( 'down' , 'right')}"></i>&nbsp;${menu.title}</a>
                </div>
                <#-- 通过添加 in 实现默认打开 -->
                <div id="collapse-${menu.id}" class="accordion-body collapse ${(menu?counter==1) ?then('in' , '')}">
                    <div class="accordion-inner">
                        <ul class="nav nav-list">
                            <#list menu.children as menu2>
                                <@shiro.hasPermission name="${menu2.permission}">
                                    <#if (menu2.parent.id == menu.id) && menu2.isShow>
                                        <li>
                                            <a data-href=".menu3-${menu2.id}"
                                               href="${ctx}/${menu2.url}"
                                               target="${(menu2.target??)?then(menu2.target , 'mainFrame')}">
                                                <i class="icon-${(menu2.icon??)?then(menu2.icon , 'circle-arrow-right')}"></i>&nbsp;${menu2.title}
                                            </a>
                                            <ul class="nav nav-list hide" style="margin:0;padding-right:0;"></ul>
                                        </li>
                                    </#if>
                                </@shiro.hasPermission>
                            </#list>
                        </ul>
                    </div>
                </div>
            </div>
        </@shiro.hasPermission>
    </#list>
</div>
<#--
</body>
</html>-->
