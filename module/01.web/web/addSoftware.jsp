<html>
<head>
    <%@ page import="com.gxx.software.entities.Kind" %>
    <%@ page import="java.util.List" %>
    <%@ page import="com.gxx.software.utils.BaseUtil" %>
    <%@ page import="com.gxx.software.dao.SoftwareDao" %>
    <%@ page import="com.gxx.software.entities.Software" %>
    <%@ page import="com.gxx.software.dao.KindDao" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="headerWithOutCheckLogin.jsp" %>
    <%
        //外层
        outLayer = "后台模块";
        //内层
        inLayer = "软件维护";
        //获取session中的分类集合
        List<Kind> kinds = BaseUtil.getSessionKindList(request);

        /**
         * 查询
         */
        //分类
        String kindId = StringUtils.trimToEmpty(request.getParameter("kind"));
        //当前页数
        String pageStr = StringUtils.trimToEmpty(request.getParameter("pageNum"));
        //当前页数
        int pageNum;
        try {
            pageNum = Integer.parseInt(pageStr);
        } catch (Exception e) {
            pageNum = 1;
        }
        //软件页面每页大小
        int pageSize = Integer.parseInt(PropertyUtil.getInstance().getProperty(BaseInterface.SOFTWARE_PAGE_SIZE));
        //软件总数
        int count = SoftwareDao.countSoftwareByKind(kindId);
        //是否为空
        boolean isEmpty = count == 0;
        //总页数
        int pageCount = (count - 1) / pageSize + 1;
        //删除最后一条，可能会少掉一页
        if(pageNum > pageCount){
            pageNum = pageCount;
        }
        //软件列表
        List<Software> softwareList = SoftwareDao.querySoftwareByKind(kindId, pageNum);
    %>
    <title>软件维护</title>
    <script type="text/javascript" src="scripts/jquery-min.js"></script>
    <script type="text/javascript" src="scripts/base.js"></script>
    <script type="text/javascript" src="scripts/addSoftware.js"></script>
    <!-- 页面样式 -->
    <link rel="stylesheet" href="css/reset.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/style.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="css/invalid.css" type="text/css" media="screen"/>
    <script type="text/javascript" src="scripts/simpla.jquery.configuration.js"></script>
    <script type="text/javascript">
        //分类，逗号分隔
        var kindJson = "<%=BaseUtil.getJsonArrayFromKinds(kinds)%>";
        //软件，逗号分隔
        var softwareJson = "<%=BaseUtil.getJsonArrayFromSoftwareList(softwareList)%>";
        //修改软件id
        var updateSoftwareId = 0;
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
                <h3>软件查询</h3>
            </div>
            <div class="content-box-content">
                <div class="tab-content default-tab">
                    <form onsubmit="return false;" style="text-align: center;">
                        选择分类：
                        <select id="kind" class="text-input small-input">
                            <option value="">全部</option>
                            <%
                                for(Kind kind : kinds){
                            %>
                            <option value="<%=kind.getId()%>"><%=kind.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                        <input class="button" type="button" value="查询" onclick="querySoftware()">
                    </form>

                    <form>
                            <table>
                                <thead>
                                <tr>
                                    <th>软件id</th>
                                    <th>图片</th>
                                    <th>名字</th>
                                    <th>所属分类</th>
                                    <th>描述</th>
                                    <th>下载次数</th>
                                    <th>地址</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <td colspan="8">
                                        <div class="pagination">
                                            <a href="javascript: jump2page(1)" title="首页">&laquo; 首页</a>
                                            <%
                                                if(pageNum > 1){
                                            %>
                                            <a href="javascript: jump2page(<%=pageNum-1%>)" title="上一页">&laquo; 上一页</a>
                                            <%
                                                }
                                            %>
                                            <%
                                                //显示前2页，本页，后2页
                                                for(int i=pageNum-2;i<pageNum+3;i++){
                                                    if(i >= 1 && i <= pageCount){
                                            %>
                                            <a href="javascript: jump2page(<%=i%>)" class="number<%=(i==pageNum)?" current":""%>" title="<%=i%>"><%=i%></a>
                                            <%
                                                    }
                                                }
                                            %>
                                            <%
                                                if(pageNum < pageCount){
                                            %>
                                            <a href="javascript: jump2page(<%=pageNum+1%>)" title="下一页">下一页 &raquo;</a>
                                            <%
                                                }
                                            %>
                                            <a href="javascript: jump2page(<%=pageCount%>)" title="尾页">尾页 &raquo;</a>
                                        </div>
                                        <div class="clear"></div>
                                    </td>
                                </tr>
                                </tfoot>
                                <tbody>
                                <%
                                    //判是否为空
                                    if (isEmpty) {
                                %>
                                <tr>
                                    <td colspan="8" style="text-align: center">
                                        没找到符合条件的软件
                                    </td>
                                </tr>
                                <%
                                } else {//非空
                                    for (Software software : softwareList) {
                                %>
                                <tr>
                                    <td><%=software.getId()%></td>
                                    <td>
                                        <img src="<%=software.getPhoto()%>" style="width: 48px; height: 48px;">
                                    </td>
                                    <td><%=software.getName()%></td>
                                    <td>
                                        <%
                                            Kind kind = KindDao.getKindById(software.getKindId());
                                            if(kind == null){
                                                out.print("暂未分类");
                                            }else {
                                                out.print(kind.getName());
                                            }
                                        %>
                                    </td>
                                    <td><%=software.getDescription()%></td>
                                    <td><%=software.getDownloadTimes()%></td>
                                    <td><%=software.getUrl()%></td>
                                    <td>
                                        <input class="button" type="button" value="修改" onclick="updateSoftware(<%=software.getId()%>)">
                                        <input class="button" type="button" value="删除" onclick="deleteSoftware(<%=software.getId()%>)">
                                    </td>
                                </tr>
                                <%
                                    }
                                }
                                %>
                                </tbody>
                        </table>
                    </form>

                    <form name="deleteSoftwareForm" method="post" action="deleteSoftware.do" style="display: none;">
                        <input type="hidden" name="token" value="<%=token%>">
                        <input type="hidden" name="softwareId" id="deleteSoftwareId">
                    </form>
                </div>
            </div>
        </div>

        <div class="content-box">
            <div class="content-box-header">
                <h3>软件新增</h3>
            </div>
            <div class="content-box-content">
                <div class="tab-content default-tab">
                    <form name="addSoftwareForm" method="post" autocomplete="off" action="addSoftware.do?token=<%=token%>"
                          enctype="multipart/form-data">
                        <table>
                            <tr>
                                <td colspan="4" style="text-align: center;">分类:
                                    <select id="addSoftwareKind" name="kind" class="text-input small-input">
                                        <option value="">全部</option>
                                        <%
                                            for(Kind kind : kinds){
                                        %>
                                        <option value="<%=kind.getId()%>"><%=kind.getName()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>名字:</td>
                                <td>
                                    <input id="addSoftwareName" name="name" class="text-input large-input" type="text">
                                </td>
                                <td>图片:</td>
                                <td>
                                    <input id="addSoftwarePhoto" name="photo" class="text-input large-input" type="file">
                                </td>
                            </tr>
                            <tr>
                                <td>描述:</td>
                                <td>
                                    <input id="addSoftwareDescription" name="description" class="text-input large-input" type="text">
                                </td>
                                <td>软件地址:</td>
                                <td>
                                    <input id="addSoftwareUrl" name="url" class="text-input large-input" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align: center">
                                    <input class="button" type="button" value="新增" onclick="addSoftware()">
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>

        <a name="updateA"></a>

        <div class="content-box">
            <div class="content-box-header">
                <h3>软件修改</h3>
            </div>
            <div class="content-box-content">
                <div class="tab-content default-tab">
                    <form name="updateSoftwareForm" method="post" autocomplete="off" action="updateSoftware.do?token=<%=token%>"
                          enctype="multipart/form-data">
                        <input type="hidden" name="softwareId" id="updateSoftwareId">
                        <table>
                            <tr>
                                <td colspan="4" id="updateSoftwareInfo">

                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align: center;">分类:
                                    <select id="updateSoftwareKind" name="kind" class="text-input small-input">
                                        <option value="0">全部</option>
                                        <%
                                            for(Kind kind : kinds){
                                        %>
                                        <option value="<%=kind.getId()%>"><%=kind.getName()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>名字:</td>
                                <td>
                                    <input id="updateSoftwareName" name="name" class="text-input large-input" type="text">
                                </td>
                                <td>图片:</td>
                                <td>
                                    <input id="updateSoftwarePhoto" name="photo" class="text-input large-input" type="file">
                                </td>
                            </tr>
                            <tr>
                                <td>描述:</td>
                                <td>
                                    <input id="updateSoftwareDescription" name="description" class="text-input large-input" type="text">
                                </td>
                                <td>软件地址:</td>
                                <td>
                                    <input id="updateSoftwareUrl" name="url" class="text-input large-input" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align: center">
                                    <input class="button" type="button" value="修改" onclick="updateSoftwareSubmit()">
                                </td>
                            </tr>
                        </table>
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