/**
 * 初始化
 */
$(document).ready(function() {
    if(message != EMPTY){
        showInformation(message);
    }
});

/**
 * 修改分类
 * @param kindId
 */
function updateKind(kindId){
    var kindIdArray = kindIds.split(SYMBOL_COMMA);
    var newKinds = EMPTY;
    for(var i=0;i<kindIdArray.length;i++){
        if(EMPTY == $("#kind" + kindIdArray[i]).val()){
            showAttention("请输入分类");
            return;
        }
        if(newKinds != EMPTY){
            newKinds += SYMBOL_COMMA;
        }
        newKinds += $("#kind" + kindIdArray[i]).val();
    }
    $("#update_kind_ids").val(kindIds);
    $("#update_kinds").val(newKinds);
    document.forms["updateKindsForm"].submit();
}

/**
 * 删除评论分类
 * @param kindId
 */
function deleteKind(kindId){
    $("#delete_kind_id").val(kindId);
    document.forms["deleteKindForm"].submit();
}

/**
 * 新增评论分类
 * @param kindId
 */
function createKind(){
    if(EMPTY == $("#create_kind").val()){
        showAttention("请输入分类");
        return;
    }
    $("#create_kind_val").val($("#create_kind").val());
    document.forms["createKindForm"].submit();
}