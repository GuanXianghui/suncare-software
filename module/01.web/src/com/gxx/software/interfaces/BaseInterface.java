package com.gxx.software.interfaces;

/**
 * 基础接口
 *
 * @author Gxx
 * @module oa
 * @datetime 14-3-29 13:16
 */
public interface BaseInterface {
    /**
     * mysql数据库链接
     */
    public static final String MYSQL_CONNECTION = "mysql_connection";
    /**
     * md5 key
     */
    public static final String MD5_KEY = "md5_key";
    /**
     * token key
     */
    public static final String TOKEN_KEY = "token";
    /**
     * session缓存中的token集合
     */
    public static final String SESSION_TOKEN_LIST = "session_token_list";
    /**
     * session缓存中的Kind集合
     */
    public static final String SESSION_KIND_LIST = "session_kind_list";
    /**
     * 软件页面大小
     */
    public static final String SOFTWARE_PAGE_SIZE = "software_page_size";
}
