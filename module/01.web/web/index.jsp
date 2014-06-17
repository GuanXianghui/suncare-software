<!DOCTYPE html>
<html lang="en" id="index">
<head>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.gxx.software.entities.Kind" %>
    <%@ page import="java.util.List" %>
    <%@ page import="com.gxx.software.utils.BaseUtil" %>
    <%@ page import="com.gxx.software.dao.SoftwareDao" %>
    <%@ page import="com.gxx.software.entities.Software" %>
    <%@ page import="com.gxx.software.dao.KindDao" %>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ include file="headerWithOutCheckLogin.jsp" %>
    <%
        /**
         * 查询
         */
        //分类
        String kindId = StringUtils.trimToEmpty(request.getParameter("kind"));
        //当前页数
        String pageStr = StringUtils.trimToEmpty(request.getParameter("pageNum"));
        //当前页数
        int pageNum;
        //分类
        Kind kind;
        //分类描述
        String kindDesc;
        try {
            pageNum = Integer.parseInt(pageStr);
        } catch (Exception e) {
            pageNum = 1;
        }
        try {
            if(StringUtils.isNotBlank(kindId)){
                kind = KindDao.getKindById(Integer.parseInt(kindId));
                if(null == kind){
                    kindId = StringUtils.EMPTY;
                    kindDesc = "全部";
                } else {
                    kindDesc = kind.getName();
                }
            } else {
                kindDesc = "全部";
            }
        } catch (Exception e) {
            kindId = StringUtils.EMPTY;
            kindDesc = "全部";
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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="./index/softSite.css">
    <style type="text/css">
        #page a{
            font-size:12px; color:#333; font-weight:normal;
        }
    </style>
    <script type="text/javascript">
        //分类id
        var kindId = "<%=kindId%>";
        //翻页
        function jump2page(pageNum){
            location.href="index.jsp?kind=" + kindId + "&pageNum=" + pageNum;
        }
        //下载软件
        function downloadSoftware(id, url){
            //ajax退出
            var SUCCESS_STR = "success";//成功编码
            $.ajax({
                type:"post",
                async:false,
                url:baseUrl + "downloadSoftware.do",
                data:"id=" + id + "&token=" + token,
                success:function (data, textStatus) {
                    if ((SUCCESS_STR == textStatus) && (null != data)) {
                        data = eval("(" + data + ")");
                        //判退出是否成功
                        if (false == data["isSuccess"]) {
                        } else {
                        }
                        //更新token
                        if (data["hasNewToken"]) {
                            token = data["token"];
                        }
                    } else {
                        alert("服务器连接异常，请稍后再试！");
                    }
                },
                error:function (data, textStatus) {
                    alert("服务器连接异常，请稍后再试！");
                }
            });
            location.href = url;
        }
    </script>
</head>

<body>

<!--index header-->
<div id="topBar">
    <div id="topNav" style="text-align: center;">
        <img src="images/logo.jpg" height="80" ondblclick="location.href='updateKinds.jsp'">
    </div>
</div>

<div class="container">
    <div class="sort">
    <span class="sortTitle">
        <%=kindDesc%>
    </span>
        <ul class="sortDetail">
            <li><a href="index.jsp">全部</a></li>
            <%
                //获取session中的分类集合
                List<Kind> kinds = BaseUtil.getSessionKindList(request);
                for(Kind kind2 : kinds){
            %>
            <li><a href="index.jsp?kind=<%=kind2.getId()%>"><%=kind2.getName()%></a></li>
            <%
                }
            %>
        </ul>
    </div>
    <!--index main-->
    <div class="main index_main">
        <div id="mainContent">
            <div class="index_softHolder">
                <dl class="softSet" id="softSet1">
                    <dt>
                    <p class="topic">
                        <%=kindDesc%>
        <span style="float: right;" id="page">
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
        </span>
                    </p>

                    <p class="line1"></p></dt>
                    <dd>
                        <ul style="height: 500px">

                            <%
                                if(softwareList.size() == 0){
                            %>
                            暂无该分类的软件！
                            <%
                                }
                                for(int i=0;i<softwareList.size();i++){
                                    Software software = softwareList.get(i);
                            %>
                            <li>
                                <a href="" title="<%=software.getName()%>">
                                    <img src="<%=software.getPhoto()%>" alt="<%=software.getName()%>" style="display: inline-block;">
                                </a>
                                <a class="word" href="" title="<%=software.getName()%>">
                                    <%=software.getName()%>
                                </a>
                                <a down="1" href="javascript:downloadSoftware(<%=software.getId()%>,'<%=software.getUrl()%>')" class="download" title="<%=software.getName()%>">
                                </a>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </dd>
                </dl>
            </div>

            <div class="sideBar">
                <div class="rank" id="rank1">
                    <p class="topic">下载总排行</p>

                    <p class="line3"></p>

                    <div class="tableWrap" style="border: 0px solid gray;">

                        <%
                            List<Software> softwareList2 = SoftwareDao.queryHotSoftware(10);
                            for(int i=0;i<softwareList2.size();i++){
                                Software software = softwareList2.get(i);
                        %>
                        <div class="rank_wrap" href="" title="<%=software.getName()%>" style="height: 26px;">
                            <div class="rank_wrap_inner" style="top: 0px;">
                                <div class="default">
                                    <div class="rankNum"><span class="flag<%=i+1%>"></span></div>
                                    <div class="rankName"><%=software.getName()%></div>
                                </div>
                                <div class="add_hover">
                                    <img src="<%=software.getPhoto()%>"
                                         style="display: inline-block;">
                                    <div>
                                        <p class="title"><%=software.getName()%></p>
                                        <p class="star" number="9.8">
                                            <span class="fullStar" style="width: 70px;"></span>
                                            <span class="emptyStar"></span></p>
                                    </div>
                                    <a class="rank_download" down="1"
                                       href="javascript:downloadSoftware(<%=software.getId()%>,'<%=software.getUrl()%>')"></a>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>

                    </div>
                </div>
            </div>
            <!--sideBar end-->
        </div>
        <!--mainContent-->
    </div>
</div>
<!--goto top-->
<a class="goto" href="#topBar" title="回到顶部"></a>
<script type="text/javascript">
    indexImgRewrite();
    //图片分域名
    function indexImgRewrite() {
        var imgStore = new Array();
        imgStore['banner'] = document.getElementById("banner").getElementsByTagName("img");
        imgStore['softSet1'] = document.getElementById("softSet1").getElementsByTagName("img");
        imgStore['softSet2'] = document.getElementById("softSet2").getElementsByTagName("img");
        imgStore['specialSets'] = document.getElementById("specialSets").getElementsByTagName("img");
        imgStore['rank1'] = document.getElementById("rank1").getElementsByTagName("img");
        imgStore['rank2'] = document.getElementById("rank2").getElementsByTagName("img");

        var elem = new Object();
        var imgSrc = "";

        //第一批img2
        catchBack(imgStore['banner'], 0, "img2");

        //第一批img3，4，5
        for (i = 0; i < 9; i++) {
            elem = imgStore['softSet1'][i];
            if (!setSrc(elem, "img" + (Math.floor(i / 3) + 3))) {
                continue;
            }
        }

        //第二批img3，4，5
        for (i = 0; i < 9; i++) {
            elem = imgStore['softSet1'][i + 9];
            if (!setSrc(elem, "img" + (Math.floor(i / 3) + 3))) {
                continue;
            }
        }

        //第三批img3，4，5
        for (i = 0; i < 9; i++) {
            elem = imgStore['softSet2'][i];
            if (!setSrc(elem, "img" + (Math.floor(i / 3) + 3))) {
                continue;
            }
        }

        //第四批img3，4，5
        for (i = 0; i < 9; i++) {
            elem = imgStore['softSet2'][i + 9];
            if (!setSrc(elem, "img" + (Math.floor(i / 3) + 3))) {
                continue;
            }
        }

        //第五批img3
        catchBack(imgStore['specialSets'], 0, "img3");

        //第五批img3
        catchBack(imgStore['rank1'], 0, "img4");

        //第五批img3
        catchBack(imgStore['rank2'], 0, "img5");

    }

    function setSrc(elem, cdn) {
        if (elem == null || elem == undefined) {
            return false;
        }
        var imgSrc = elem.getAttribute("imgSrc").replace("img1", cdn);
        elem.setAttribute("src", imgSrc);
        elem.style.display = "inline-block";
    }

    function catchBack(elems, start, cdn) {
        for (i = 0; i < elems.length; i++) {
            if (i < start) {
                continue;
            }
            elem = elems[i];
            imgSrc = elem.getAttribute("imgSrc").replace("img1", cdn);
            elem.setAttribute("src", imgSrc);
            elem.style.display = "inline-block";
        }
    }
</script>
<!--footer-->
<div id="footer">
    <div>
        ©2014 by 关向辉
    </div>
</div>
<script type="text/javascript" src="./index/jquery.min.js"></script>
<script type="text/javascript" src="./index/softSite.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#search .searchArea").focus(function () {
            $("#search .hint").text("");
        });

        $("#search .searchArea").blur(function () {
            if ($(this).val().length == 0) {
                $("#search .hint").text("百度卫士");
            }
        });

        $('.searchArea').blur(
                function () {
                    //$('.searchPanel').html('');
                }).keyup(function () {
                    var evt = arguments[0] || window.event;
                    if (evt.keyCode == 38 || evt.keyCode == 40 || evt.keyCode == 13) {
                        return;
                    }
                    if ($('.searchArea').val().length == 0) {
                        $('.searchPanel').html('');
                        $('.searchPanel').hide();
                        return;
                    }
                    /*
                     if( $('.searchArea').val().length==1 && $('.searchArea').val().charCodeAt(0)<128){
                     //console.log( $('.searchArea').val().charCodeAt(0) );
                     $('.searchPanel').html('');
                     $('.searchPanel').hide();
                     return;
                     }*/

                    var a = '<script type="text/javascript" src="http://nssug.baidu.com/su?ie=utf-8&prod=bds_soft&wd=';
                    a += $('.searchArea').val();
                    a += '"></scr';
                    a += 'ipt>';
                    $('#request_url').html(a);
                    //console.log($('.searchArea').val());
                });

        $('.searchIcon').click(function () {
            $('.searchArea').val($('.searchArea').val().length ? $('.searchArea').val() : $(".hint").text());
            $('#kw').val(encodeURIComponent($('.searchArea').val()));
            $(".hint").text("");
            $('#search').attr('action', "/search/index/");
            $('#search').submit();
        });
        $('body').click(function () {
            $('.searchPanel').html('');
            $('.searchPanel').hide();
        });

        //头部导航hover
        hoverNavList();

        //searchBar
        focusSearchBar();

        //$('.tableWrap').delegate('[down=1]','click',dclick);
        $('[down=1]').bind('click', dclick);
    });

    function dclick() {
        if ($(this).attr('sid') != 'undefined') {
            //console.log( 'begin sid='+$(this).attr('sid') );
            var tid = 0;
            if ($(this).attr('tid') != undefined) {
                tid = $(this).attr('tid');
            }

            $.ajax({
                url:'/api/index/json_update_down_num_v2/' + $(this).attr('sid') + '/' + tid,
                async:false,
                complete:function (msg) {
                    return true;
                }
            });
        }
        return true;
    }

    function selectSoft(softName) {
        $('.searchArea').val(softName);
        $('.searchPanel').html('');
        $('.searchPanel').hide();
        $('.searchIcon').click();
    }
    function mouseoverItem(obj) {
        $('.searchPanel li').css('background-color', '');
        $(obj).css('background-color', '#e8e8e8');
    }

    window.document.onkeydown = function () {
        var evt = arguments[0] || window.event;

        if (evt.keyCode == 13) {
            $('.searchIcon').click();
        } else if (evt.keyCode == 38) {
            //console.log('up');
            //console.log( $('.searchPanel li a[curr="1"]').length );
            if ($('.searchPanel').html() != "") {
                if ($('.searchPanel li a[curr="1"]').length > 0) {
                    //console.log( '_if' );
                    if ($('.searchPanel li a[curr="1"]').parent().prev('li').length > 0) {
                        $('.searchPanel li a[curr="1"]').parent().prev('li').children('a').attr('curr', 1);

                        if ($('.searchPanel li a[curr="1"]').parent().next('li').length > 0) {
                            $('.searchPanel li a[curr="1"]').parent().next('li').children('a').attr('curr', 0);
                        }
                    } else {
                        $('.searchPanel li a[curr="1"]').attr('curr', 0);
                        $('.searchPanel li:last a').attr('curr', "1");
                    }
                } else {
                    //console.log( '_else' );
                    $('.searchPanel li:last a').attr('curr', "1");
                }
                if ($('.searchPanel li a[curr="1"]').html() != "") {
                    mouseoverItem($('.searchPanel li a[curr="1"]').parent().get(0));
                    $('.searchArea').val($('.searchPanel li a[curr="1"]').html());
                }
            }
        } else if (evt.keyCode == 40) {
            //console.log('down');
            //console.log( $('.searchPanel li a[curr="1"]').length );
            if ($('.searchPanel').html() != "") {
                if ($('.searchPanel li a[curr="1"]').length > 0) {
                    //console.log( '_if' );
                    if ($('.searchPanel li a[curr="1"]').parent().next('li').length > 0) {
                        $('.searchPanel li a[curr="1"]').parent().next('li').children('a').attr('curr', 1);
                        if ($('.searchPanel li a[curr="1"]').parent().prev('li').length > 0) {
                            $('.searchPanel li a[curr="1"]').parent().prev('li').children('a').attr('curr', 0)
                        }
                    } else {
                        $('.searchPanel li a[curr="1"]').attr('curr', 0);
                        $('.searchPanel li:first a').attr('curr', "1");
                    }
                } else {
                    //console.log( '_else' );
                    $('.searchPanel li:first a').attr('curr', "1");
                }
                if ($('.searchPanel li a[curr="1"]').html() != "") {
                    mouseoverItem($('.searchPanel li a[curr="1"]').parent().get(0));
                    $('.searchArea').val($('.searchPanel li a[curr="1"]').html());
                }
            }
        }
    }


    window.baidu = new Object();
    window.baidu.sug = function (data) {
        var sp = '{#S+_}';
        var html = "";
        var items = new Array();
        data = eval(data['s']);

        if ('undefined' != data) {
            var num = 0;
            var k = data.length > 5 ? 5 : data.length;
            for (var i in data) {
                if (num >= 5)break;
                num++;
                items = data[i].split(sp);
                if (num == k) {
                    html += "<li class='noBorder' onmouseover='mouseoverItem(this)'><a href='javascript:void(0);' onclick=\"selectSoft(\'" + items[0] + "\')\">" + items[0] + "</a></li>";
                } else {
                    html += "<li onmouseover='mouseoverItem(this)'><a href='javascript:void(0);' onclick=\"selectSoft(\'" + items[0] + "\')\" >" + items[0] + "</a></li>";
                }
                //console.log(items, num, html);
            }
            //console.log(html);
        }
        $('.searchPanel').html('');
        $('.searchPanel').html(html);
        $('.searchPanel').show();
    }
</script>
<script type="text/javascript">

    var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F6257acae4e1f007e3ee01de4708f41aa' type='text/javascript'%3E%3C/script%3E"));
    _hmt.push(['_trackPageview', '/_site_uv']);
</script>
<script src="./index/h.js" type="text/javascript"></script>


<script type="text/javascript">
    $(document).ready(function () {
        //右侧排行下载文字效果
        hoverRanklist($(".rank"));

        //打分Star显示
        changeNumToStar();

        //返回顶部按钮的定位
        $(window).scroll(gotoTop);

        //显示下载
        showSoftSetDownload();
        /*
         $(".rank").each(function(i, e){
         var elem = $(e).find("tr").eq(0);
         $('<tr class="ori_html" style="display:none">'+$(elem).html()+'</tr>').insertBefore(elem);
         $(elem).html($(elem).next(".hover").html()).addClass("add_hover");
         });
         */
        var rj = new Object;

        rj.index = {
            animateBanner:new AnimateBanner($(".banner a"), $(".dot"))
        };

        //首页动画播放
        rj.index.animateBanner.init();

    });


</script>
</body>
</html>