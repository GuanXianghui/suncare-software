package com.gxx.software.utils;

import java.io.*;

/**
 * �ļ�������
 *
 * @author Gxx
 * @module oa
 * @datetime 14-4-1 11:33
 */
public class FileUtil {
    /**
     * �����С
     */
    private static final int BUFFER_SIZE = 1444;

    /**
     * �����ļ�
     * @param src
     * @param dst
     */
    public static void copy(String src, String dst) {
        try {
            int byteRead;
            if (new File(src).exists()) { //�ļ�����ʱ
                InputStream inStream = new FileInputStream(src); //����ԭ�ļ�
                FileOutputStream fs = new FileOutputStream(dst);
                byte[] buffer = new byte[BUFFER_SIZE];
                while ( (byteRead = inStream.read(buffer)) != -1) {
                    fs.write(buffer, 0, byteRead);
                }
                fs.flush();
                inStream.close();
            }
        }
        catch (Exception e) {
            System.out.println("���Ƶ����ļ���������");
            e.printStackTrace();
        }
    }

    /**
     * д�ļ�
     * @param filePath
     * @param content
     * @throws Exception
     */
    public static void writeFile(String filePath, String content) throws Exception {
        FileOutputStream outSTr = new FileOutputStream(new File(filePath));
        BufferedOutputStream Buff=new BufferedOutputStream(outSTr);
        Buff.write(content.getBytes());
        Buff.flush();
        Buff.close();
    }

    /**
     * �����ļ�
     * @param src
     * @param dst
     */
    public static void copy(File src, File dst) {
        try {
            int byteRead;
            if (src.exists()) { //�ļ�����ʱ
                InputStream inStream = new FileInputStream(src); //����ԭ�ļ�
                FileOutputStream fs = new FileOutputStream(dst);
                byte[] buffer = new byte[BUFFER_SIZE];
                while ( (byteRead = inStream.read(buffer)) != -1) {
                    fs.write(buffer, 0, byteRead);
                }
                fs.flush();
                inStream.close();
            }
        }
        catch (Exception e) {
            System.out.println("���Ƶ����ļ���������");
            e.printStackTrace();
        }
    }

    /**
     * ����Ŀ¼
     * @param path
     */
    public static void makeDir(String path)
    {
        File file = new File(path);

        if (!file.exists())
        {
            if (!file.mkdirs())
            {
                throw new RuntimeException("���Դ����ļ���:[" + path + "]ʧ�ܣ�");
            }
        }
    }

    /**
     * ɾ���ļ������ļ���
     * @param path
     */
    public static void deleteFile(String path){
        File file = new File(path);
        deleteFile(file);
    }

    /**
     * ɾ���ļ������ļ���
     * @param file
     */
    public static void deleteFile(File file){
        if (file.exists())
        {
            file.delete();
        }
    }
}
