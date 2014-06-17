//软件集合
var softwareArray = new Array();

/**
 * 初始化
 */
$(document).ready(function() {
    if(message != EMPTY){
        showInformation(message);
    }
    transferSoftwareJson2Array();
});

/**
 * 把初始jsonStr转换成array
 */
function transferSoftwareJson2Array(){
    if(softwareJson != EMPTY) {
        var array = softwareJson.split(SYMBOL_BIT_AND);
        for(var i=0;i<array.length;i++) {
            softwareArray[softwareArray.length] = eval("(" + array[i] + ")");
        }
    }
    return softwareArray;
}

/**
 * 根据id获取软件
 * @param id
 */
function getSoftwareById(id){
    for(var i=0;i<softwareArray.length;i++) {
        if(softwareArray[i]["id"] == id){
            return softwareArray[i];
        }
    }
    return null;
}

/**
 * 查询软件
 */
function querySoftware(){
    location.href="addSoftware.jsp?kind=" + $("#kind").val();
}

/**
 * 跳转页面
 * @param page
 */
function jump2page(page){
    location.href="addSoftware.jsp?kind=" + $("#kind").val() + "&pageNum=" + page;
}

/**
 * 新增评论分类
 * @param kindId
 */
function addSoftware(){
    if(EMPTY == $("#addSoftwareName").val()){
        showAttention("请输入软件名字");
        return;
    }
    if(EMPTY == $("#addSoftwareUrl").val()){
        showAttention("请输入软件地址");
        return;
    }
    document.forms["addSoftwareForm"].submit();
}

/**
 * 删除软件
 * @param softwareId
 */
function deleteSoftware(softwareId){
    $("#deleteSoftwareId").val(softwareId)
    document.forms["deleteSoftwareForm"].submit();

}

/**
 * 修改软件
 * @param softwareId
 */
function updateSoftware(softwareId){
    updateSoftwareId = softwareId;
    $("#updateSoftwareId").val(softwareId);
    var software = getSoftwareById(softwareId);
    $("#updateSoftwareInfo").html("ID:" + softwareId + "<img src='" + software["photo"] + "' style='width: 48px;height: 48px;'>");
    $("#updateSoftwareKind").val(software["kindId"]);
    $("#updateSoftwareName").val(software["name"]);
    $("#updateSoftwareDescription").val(software["description"]);
    $("#updateSoftwareUrl").val(software["url"]);
    location.href = "#updateA";
}

/**
 * 新增评论分类
 * @param kindId
 */
function updateSoftwareSubmit(){
    if(0 == updateSoftwareId){
        showAttention("请先选择软件");
        return;
    }
    if(EMPTY == $("#updateSoftwareName").val()){
        showAttention("请输入软件名字");
        return;
    }
    if(EMPTY == $("#updateSoftwareUrl").val()){
        showAttention("请输入软件地址");
        return;
    }
    document.forms["updateSoftwareForm"].submit();
}