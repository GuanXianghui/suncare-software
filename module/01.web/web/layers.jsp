<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<ul id="main-nav">
    <li><a href="#" class="nav-top-item<%=outLayer.equals("后台模块")?" current":""%>"> 后台模块 </a>
        <ul>
            <li><a href="<%=baseUrl%>updateKinds.jsp"<%=inLayer.equals("分类修改")?" class=\"current\"":""%>>分类修改</a></li>
            <li><a href="<%=baseUrl%>addSoftware.jsp"<%=inLayer.equals("软件维护")?" class=\"current\"":""%>>软件维护</a></li>
        </ul>
    </li>
</ul>