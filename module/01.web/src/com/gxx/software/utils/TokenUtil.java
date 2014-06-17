package com.gxx.software.utils;

import com.gxx.software.interfaces.BaseInterface;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * token������
 *
 * @author Gxx
 * @module oa
 * @datetime 14-3-29 14:02
 */
public class TokenUtil implements BaseInterface {
    /**
     * �õ�sessionTokenList
     *
     * @param request
     * @return
     */
    public static List getSessionTokenList(HttpServletRequest request) {
        List sessionTokenList = (List) request.getSession().getAttribute(SESSION_TOKEN_LIST);
        if (sessionTokenList == null) {
            sessionTokenList = new ArrayList();
            request.getSession().setAttribute(SESSION_TOKEN_LIST, sessionTokenList);
        }
        return sessionTokenList;
    }

    /**
     * ����token��
     *
     * @param request
     * @return
     */
    public static String createToken(HttpServletRequest request) {
        String uuid = UUID.randomUUID().toString();
        List sessionTokenList = getSessionTokenList(request);
        sessionTokenList.add(uuid);
        return uuid;
    }

    /**
     * У��token��
     *
     * @param request
     * @param token
     * @return
     */
    public static boolean checkToken(HttpServletRequest request, String token) {
        if (StringUtils.isBlank(token)) {
            return false;
        }
        List sessionTokenList = getSessionTokenList(request);
        if (sessionTokenList.contains(token)) {
            sessionTokenList.remove(token);
            return true;
        }
        return false;
    }
}