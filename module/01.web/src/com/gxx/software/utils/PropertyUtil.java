package com.gxx.software.utils;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;

/**
 * �����ļ���ȡ������
 *
 * @author Gxx
 * @module oa
 * @datetime 14-3-29 18:17
 */
public class PropertyUtil {
    private static PropertyUtil instance;

    public static PropertyUtil getInstance() {
        if (null == instance) {
            instance = new PropertyUtil();
        }
        return instance;
    }

    private static String propertyRoute = "config.properties";

    static Properties prop;

    private PropertyUtil() {
        refresh();
    }

    /**
     * ���û���ˢ��
     */
    public static void refresh() {
        // 1 ��ȡproperties�ļ�
        URL configUrl = Thread.currentThread().getContextClassLoader().getResource(propertyRoute);
        if (null == configUrl) {
            throw new RuntimeException("�Ҳ��������ļ�:" + propertyRoute);
        }
        // 2 ���ļ�URLװ��Ϊproperties��
        prop = new Properties();
        InputStream configIs = null;
        try {
            configIs = configUrl.openStream();
            prop.load(configIs);
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        } finally {
            if (configIs != null) {
                try {
                    configIs.close();
                } catch (IOException e) {
                    throw new RuntimeException("�����ļ����ر��쳣!");
                }
            }
        }
    }

    /**
     * ��ȡ����
     *
     * @param key
     * @return
     */
    public String getProperty(String key) {
        return prop.getProperty(key);
    }
}
