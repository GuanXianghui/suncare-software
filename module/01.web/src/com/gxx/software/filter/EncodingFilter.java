package com.gxx.software.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * ���������
 *
 * @author Gxx
 * @module oa
 * @datetime 14-3-29 13:12
 */
public class EncodingFilter implements Filter {
    /**
     * �ļ�����
     */
    private FilterConfig filterConfig = null;

    /**
     * ���캯��
     *
     * @param filterConfig
     * @throws javax.servlet.ServletException
     */
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    /**
     * ����
     *
     * @param request
     * @param response
     * @param filterChain
     * @throws java.io.IOException
     * @throws javax.servlet.ServletException
     */
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        //���������ַ�����
        request.setCharacterEncoding("UTF-8");

        //ִ����һ��������
        filterChain.doFilter(req, res);
    }

    /**
     * ����
     */
    public void destroy() {
        this.filterConfig = null;
    }

    public FilterConfig getFilterConfig() {
        return filterConfig;
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }
}
