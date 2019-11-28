<html>
<head>
    <title>分配角色</title>
    <meta name="decorator" content="blank"/>
    <#include "../../layout/header.ftl">
</head>
<body>
<div id="assignRole" class="row-fluid span12">
    <div class="span3">
        <p>待选人员：</p>
        <div id="userTree" class="ztree"></div>
    </div>
    <div class="span3" style="padding-left:16px;border-left: 1px solid #A8A8A8;">
        <p>已选人员：</p>
        <div id="selectedTree" class="ztree"></div>
    </div>
</div>
<link href="${ctx}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
<script src="${ctx}/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
<script type="text/javascript">

    var selectedTree;//zTree已选择对象

    // 初始化
    $(document).ready(function(){
        selectedTree = $.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
        $.fn.zTree.init($("#userTree"), setting, allUsers);
    });

    var setting = {view: {selectedMulti:false,nameIsHTML:true,showTitle:false,dblClickExpand:false},
        data: {simpleData: {enable: true}},
        callback: {onClick: treeOnClick}};

    //所有用户信息
    var allUsers=[
    <#list users as user>
        {id:"${user.userId}",
            pId:"0",
            name:"${user.userName}"
        },
    </#list>
    ]

    //缓存数据用,原始选择的用户
    var pre_selectedNodes =[
    <#list inUsers as user>
        {id:"${user.userId}",
            pId:"0",
            name:"<font color='red' style='font-weight:bold;'>${user.userName}</font>"
        },
    </#list>
    ];

    var selectedNodes =[
    <#list inUsers as user>
        {id:"${user.userId}",
            pId:"0",
            name:"<font color='red' style='font-weight:bold;'>${user.userName}</font>"
        },
    </#list>
    ];

    //保存原始数据
    var pre_ids = [
    <#list inUsers as user>
        '${user.userId}',
    </#list>
    ];
    var ids = [
    <#list inUsers as user>
        '${user.userId}',
    </#list>
    ];

    //点击选择项回调
    function treeOnClick(event, treeId, treeNode, clickFlag){
        $.fn.zTree.getZTreeObj(treeId).expandNode(treeNode);
        if("userTree"==treeId){
            if($.inArray(String(treeNode.id), ids)<0){
                selectedTree.addNodes(null, treeNode);
                ids.push(String(treeNode.id));
            }
        };
        if("selectedTree"==treeId){
            if($.inArray(String(treeNode.id), pre_ids)<0){
                selectedTree.removeNode(treeNode);
                ids.splice($.inArray(String(treeNode.id), ids), 1);
            }else{
                top.$.jBox.tip("角色原有成员不能清除！", 'info');
            }
        }
    };
    function clearAssign(){
        var submit = function (v, h, f) {
            if (v == 'ok'){
                var tips="";
                if(pre_ids.sort().toString() == ids.sort().toString()){
                    tips = "未给角色【${role.roleName}】分配新成员！";
                }else{
                    tips = "已选人员清除成功！";
                }
                ids=pre_ids.slice(0);
                selectedNodes=pre_selectedNodes;
                $.fn.zTree.init($("#selectedTree"), setting, selectedNodes);
                top.$.jBox.tip(tips, 'info');
            } else if (v == 'cancel'){
                // 取消
                top.$.jBox.tip("取消清除操作！", 'info');
            }
            return true;
        };
        tips="确定清除角色【${role.roleName}】下的已选人员？";
        top.$.jBox.confirm(tips, "清除确认", submit);
    };
</script>
</body>
</html>
