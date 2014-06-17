package com.gxx.software.utils;

import com.gxx.software.dao.KindDao;
import com.gxx.software.entities.Kind;
import com.gxx.software.entities.Software;
import com.gxx.software.interfaces.BaseInterface;
import com.gxx.software.interfaces.SymbolInterface;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 基础工具类
 *
 * @author Gxx
 * @module oa
 * @datetime 14-3-29 12:58
 */
public class BaseUtil implements BaseInterface, SymbolInterface {
    /**
     * 获取session中的分类集合
     * @param request
     * @return
     * @throws Exception
     */
    public static List<Kind> getSessionKindList(HttpServletRequest request) throws Exception {
        List<Kind> kinds = (List<Kind>)request.getSession().getAttribute(SESSION_KIND_LIST);
        if(kinds == null){
            kinds = KindDao.queryAllKinds();
            request.getSession().setAttribute(SESSION_KIND_LIST, kinds);
        }
        return kinds;
    }

    /**
     * 分类集合json串
     * @param kinds
     * @return
     */
    public static String getJsonArrayFromKinds(List<Kind> kinds) {
        String result = StringUtils.EMPTY;
        for(Kind kind : kinds) {
            if(StringUtils.isNotBlank(result)) {
                result += SYMBOL_BIT_AND;
            }
            result += "{id:" + kind.getId() + ",name:'" + kind.getName() + "}";
        }
        return result;
    }

    /**
     * 软件集合json串
     * @param softwareList
     * @return
     */
    public static String getJsonArrayFromSoftwareList(List<Software> softwareList) {
        String result = StringUtils.EMPTY;
        for(Software software : softwareList) {
            if(StringUtils.isNotBlank(result)) {
                result += SYMBOL_BIT_AND;
            }
            result += "{id:" + software.getId() + ",name:'" + software.getName() + "',description:'" +
                    software.getDescription() + "',photo:'" + software.getPhoto() + "',downloadTimes:" +
                    software.getDownloadTimes() + ",url:'" + software.getUrl() + "',kindId:" +
                    software.getKindId() + "}";
        }
        return result;
    }
}
