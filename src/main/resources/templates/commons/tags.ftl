<#-- 定义图标选择 -->
<#macro iconselect id name value>
<i id="${id}Icon" class="icon-${(value??)?then(value,' hide')}"></i>&nbsp;<label id="${id}IconLabel">${(value??)?then(value,'无')}</label>&nbsp;
<input id="${id}" name="${name}" type="hidden" value="${value}"/><a id="${id}Button" href="javascript:" class="btn">选择</a>&nbsp;&nbsp;
<script type="text/javascript">
    $("#${id}Button").click(function(){
        top.$.jBox.open("iframe:${ctx}/sys/tag/iconselect?value="+$("#${id}").val(), "选择图标", 700, $(top.document).height()-180, {
            buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                if (v=="ok"){
                    var icon = h.find("iframe")[0].contentWindow.$("#icon").val();
                    icon = $.trim(icon).substr(5);
                    $("#${id}Icon").attr("class", "icon-"+icon);
                    $("#${id}IconLabel").text(icon);
                    $("#${id}").val(icon);
                }else if (v=="clear"){
                    $("#${id}Icon").attr("class", "icon- hide");
                    $("#${id}IconLabel").text("无");
                    $("#${id}").val("");
                }
            }, loaded:function(h){
                $(".jbox-content", top.document).css("overflow-y","hidden");
            }
        });
    });
</script>
</#macro>

<#-- 定义菜单选择 默认值的参数必须是在参数列表的最后-->
<#macro treeselect id name value labelName labelValue url title cssClass="" extId="" cssStyle="" module="" checked=false isAll=true notAllowSelectRoot=false
        notAllowSelectParent=false selectScopeModule=false allowClear=false allowInput=false smallBtn=false hideBtn=false disabled="" dataMsgRequired=""
>
<div class="input-append">
    <input id="${id}Id" name="${name}" class="${cssClass}" type="hidden" value="${value}"/>
    <input id="${id}Name" name="${labelName}" ${allowInput?then('','readonly="readonly"')} type="text" value="${labelValue}" data-msg-required="${dataMsgRequired}"
           class="${cssClass}" style="${cssStyle}"/>
    <a id="${id}Button" href="javascript:" class="btn ${disabled} ${hideBtn ? then('hide' , '')}" style="${smallBtn?then('padding:4px 2px;','')}">&nbsp;<i class="icon-search"></i>&nbsp;</a>&nbsp;&nbsp;
</div>
<script type="text/javascript">
    $("#${id}Button, #${id}Name").click(function(){
        // 是否限制选择，如果限制，设置为disabled
        if ($("#${id}Button").hasClass("disabled")){
            return true;
        }
        // 正常打开	
        top.$.jBox.open("iframe:${ctx}/sys/tag/treeselect?url="+encodeURIComponent("${url}")+"&module=${module}&checked=${checked?c}&extId=${extId}&isAll=${isAll?c}", "选择${title}", 300, 420, {
            ajaxData:{selectIds: $("#${id}Id").val()},buttons:{"确定":"ok", ${allowClear?then("\"清除\":\"clear\", ","")}"关闭":true}, submit:function(v, h, f){
                if (v=="ok"){
                    var tree = h.find("iframe")[0].contentWindow.tree;//h.find("iframe").contents();
                    var ids = [], names = [], nodes = [];
                    if ("${checked?c}" == "true"){
                        nodes = tree.getCheckedNodes(true);
                    }else{
                        nodes = tree.getSelectedNodes();
                    }
                    for(var i=0; i<nodes.length; i++) {
                        <#if checked && notAllowSelectParent>
                            if (nodes[i].isParent){
                                continue; // 如果为复选框选择，则过滤掉父节点
                            }
                        </#if>
                        <#if notAllowSelectRoot>
                            if (nodes[i].level == 0){
                                top.$.jBox.tip("不能选择根节点（"+nodes[i].name+"）请重新选择。");
                                return false;
                            }
                        </#if>
                        <#if notAllowSelectParent>
                            if (nodes[i].isParent){
                                top.$.jBox.tip("不能选择父节点（"+nodes[i].name+"）请重新选择。");
                                return false;
                            }
                        </#if>
                        <#if (module??) && selectScopeModule>
                            if (nodes[i].module == ""){
                                top.$.jBox.tip("不能选择公共模型（"+nodes[i].name+"）请重新选择。");
                                return false;
                            }else if (nodes[i].module != "${module}"){
                                top.$.jBox.tip("不能选择当前栏目以外的栏目模型，请重新选择。");
                                return false;
                            }
                        </#if>
                        ids.push(nodes[i].id);
                        names.push(nodes[i].name);
                        <#if !checked>
                            break; // 如果为非复选框选择，则返回第一个选择
                        </#if>
                    }
                    $("#${id}Id").val(ids.join(",").replace(/u_/ig,""));
                    $("#${id}Name").val(names.join(","));
                }
                <#if allowClear>
                    else if (v=="clear"){
                        $("#${id}Id").val("");
                        $("#${id}Name").val("");
                    }
                </#if>
                if(typeof ${id}TreeselectCallBack == 'function'){
                    ${id}TreeselectCallBack(v, h, f);
                }
            }, loaded:function(h){
                $(".jbox-content", top.document).css("overflow-y","hidden");
            }
        });
    });
</script>
</#macro>