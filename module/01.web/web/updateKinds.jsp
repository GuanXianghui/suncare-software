<html>
<head>
    <%@ page import="com.gxx.software.entities.Kind" %>
    <%@ page import="java.util.List" %>
    <%@ page import="com.gxx.software.utils.BaseUtil" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="headerWithOutCheckLogin.jsp" %>
    <%
        //外层
        outLayer = "后台模块";
        //内层
        inLayer = "分类修改";
        //获取session中的分类集合
        List<Kind> kinds = BaseUtil.getSessionKindList(request);
    %>
    <title>分类修改</title>
    <script type="text/javascript" src="scripts/jquery-min.js"></script>
    <script type="text/javascript" src="scripts/base.js"></script>
    <script type="text/javascript" src="scripts/updateKinds.js"></script>
    <!-- 页面样式 -->
    <link rel="stylesheet" href="css/reset.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/invalid.css" type="text/css" media="screen"/>
    <script type="text/javascript" src="scripts/simpla.jquery.configuration.js"></script>
    <script type="text/javascript">
        //分类id，逗号分隔
        var kindIds = EMPTY;
        <%
            for(int i=0;i<kinds.size();i++){
            if(i>0){
            %>
        kindIds += SYMBOL_COMMA;
        <%
            }
         %>
        kindIds += <%=kinds.get(i).getId()%>;
        <%
            }
        %>
    </script>
    <style type="text/css">
        th{
            text-align: center;
        }
        td{
            text-align: center;
        }
    </style>
</head>
<body>
<div id="body-wrapper">
    <div id="sidebar">
        <div id="sidebar-wrapper">
            <h1 id="sidebar-title"><a href="#">申成软件</a></h1>
            <div align="center">
                <img id="logo" src="images/logo.jpg" height="48" alt="Simpla Admin logo"/>
            </div>
            <div id="profile-links">
                Hello, 申成软件欢迎您！
                <br/>
                <br/>
                <a href="index.jsp" title="首页">首页</a>
            </div>
            <%@ include file="layers.jsp" %>
        </div>
    </div>
    <div id="main-content">
        <div id="message_id" class="notification information png_bg" style="display: none;">
            <a href="#" class="close">
                <img src="images/icons/cross_grey_small.png" title="关闭" alt="关闭"/>
            </a>

            <div id="message_id_content"> 提示信息！</div>
        </div>
        <div class="content-box">
            <div class="content-box-header">
                <h3>新增分类</h3>
            </div>
            <div class="content-box-content">
                <div class="tab-content default-tab">
                    <form onsubmit="return false;">
                        <table>
                            <tr>
                                <td>
                                    新增分类：
                                    <input id="create_kind" class="text-input medium-input"
                                           type="text" value="">
                                    <input class="button" type="button" value="新增" onclick="createKind()">
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>

        <div class="content-box">
            <div class="content-box-header">
                <h3>修改分类</h3>
            </div>
            <div class="content-box-content">
                <div class="tab-content default-tab">
                    <form>
                        <table>
                            <thead>
                            <tr>
                                <th>分类id</th>
                                <th>分类名</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <%
                                for(int i=0;i<kinds.size();i++){
                            %>
                            <tr>
                                <td>
                                    <%=kinds.get(i).getId()%>
                                </td>
                                <td>
                                    <input id="kind<%=kinds.get(i).getId()%>" class="text-input between-medium-large-input"
                                           type="text" value="<%=kinds.get(i).getName()%>">
                                </td>
                                <td>
                                    <input class="button" type="button" value="删除" onclick="deleteKind(<%=kinds.get(i).getId()%>)">
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            <%
                                if(kinds.size() > 0){
                            %>
                            <tr>
                                <td colspan="3">
                                    <input class="button" type="button" value="保存" onclick="updateKind()">
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                    </form>
                    <form name="createKindForm" method="post" action="createKind.do" style="display: none;">
                        <input type="hidden" name="token" value="<%=token%>">
                        <input type="hidden" name="kind" id="create_kind_val">
                    </form>
                    <form name="deleteKindForm" method="post" action="deleteKind.do" style="display: none;">
                        <input type="hidden" name="token" value="<%=token%>">
                        <input type="hidden" name="id" id="delete_kind_id">
                    </form>
                    <form name="updateKindsForm" method="post" action="updateKinds.do" style="display: none;">
                        <input type="hidden" name="token" value="<%=token%>">
                        <input type="hidden" name="kindIds" id="update_kind_ids">
                        <input type="hidden" name="kinds" id="update_kinds">
                    </form>
                </div>
            </div>
        </div>

        <div class="clear"></div>
        <div id="footer">
            <small>
                &#169; Copyright 2014 by 关向辉
            </small>
        </div>
    </div>
</div>
</body>
</html>