package com.gxx.software.utils;

import javax.servlet.http.HttpServletRequest;

/**
 * ȡ�ͻ�IP��ַ������
 *
 * @author Gxx
 * @module oa
 * @datetime 14-3-29 13:02
 */
public class IPAddressUtil {
    /**
     * ��HTTP�����л�ȡ�ͻ�IP��ַ
     *
     * @param request http����
     * @return �ͻ�IP��ַ
     */
    public static String getIPAddress(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
