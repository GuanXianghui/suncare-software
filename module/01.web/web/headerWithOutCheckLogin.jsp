<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="com.gxx.software.utils.PropertyUtil" %>
<%@ page import="com.gxx.software.interfaces.BaseInterface" %>
<%@ page import="com.gxx.software.utils.TokenUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //域名链接
    String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/";
    //md5 key
    String md5Key = PropertyUtil.getInstance().getProperty(BaseInterface.MD5_KEY);
    //token串
    String token = TokenUtil.createToken(request);
    //消息
    String message = StringUtils.trimToEmpty((String)request.getAttribute("message"));
    if(StringUtils.isBlank(message)){
        message = StringUtils.trimToEmpty(request.getParameter("message"));
    }

    //外层
    String outLayer = StringUtils.EMPTY;
    //内层
    String inLayer = StringUtils.EMPTY;
%>

<script type="text/javascript">
    //域名链接
    var baseUrl = "<%=baseUrl%>";
    //md5 key
    var md5Key = "<%=md5Key%>";
    //token穿
    var token = "<%=token%>";
    //弹出消息框
    var message = '<%=message%>';
</script>
<!-- 图标 -->
<%--<link rel="shortcut icon" type="image/x-icon" href="/images/logo.jpg" />--%>