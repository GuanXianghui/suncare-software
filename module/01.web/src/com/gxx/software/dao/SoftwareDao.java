package com.gxx.software.dao;

import com.gxx.software.entities.Software;
import com.gxx.software.interfaces.BaseInterface;
import com.gxx.software.utils.PropertyUtil;
import org.apache.commons.lang.StringUtils;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * 用户实体操作类
 *
 * @author Gxx
 * @module oa
 * @datetime 14-3-29 20:22
 */
public class SoftwareDao {
    /**
     * 根据分类查询软件数量
     *
     * @param kind
     * @return
     * @throws Exception
     */
    public static int countSoftwareByKind(String kind) throws Exception {
        //结果
        int count = 0;
        //sql语句
        String sql = "SELECT count(1) count_num FROM software";
        //如果kind非空带上为条件
        if(StringUtils.isNotBlank(kind)){
            sql += " WHERE kind_id=" + kind;
        }
        Connection c = DB.getConn();
        Statement stmt = DB.createStatement(c);
        ResultSet rs = DB.executeQuery(c, stmt, sql);
        try {
            if (rs == null) {
                throw new RuntimeException("数据库操作出错，请重试！");
            }
            while (rs.next()) {
                count = rs.getInt("count_num");
            }
            return count;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 根据分类查询软件
     *
     * @param kind
     * @param pageNum
     * @return
     * @throws Exception
     */
    public static List<Software> querySoftwareByKind(String kind, int pageNum) throws Exception {
        //软件列表每页大小
        int pageSize = Integer.parseInt(PropertyUtil.getInstance().getProperty(BaseInterface.SOFTWARE_PAGE_SIZE));
        //软件集合
        List<Software> list = new ArrayList<Software>();
        //sql语句
        String sql = "SELECT id,name,description,photo,download_times,url,kind_id FROM software";
        //如果kind非空带上为条件
        if(StringUtils.isNotBlank(kind)){
            sql += " WHERE kind_id=" + kind;
        }
        sql += " ORDER BY id LIMIT " + ((pageNum-1) * pageSize) + "," + pageSize;
        Connection c = DB.getConn();
        Statement stmt = DB.createStatement(c);
        ResultSet rs = DB.executeQuery(c, stmt, sql);
        try {
            if (rs == null) {
                throw new RuntimeException("数据库操作出错，请重试！");
            }
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String photo = rs.getString("photo");
                int downloadTimes = rs.getInt("download_times");
                String url = rs.getString("url");
                int kindId = rs.getInt("kind_id");
                Software software = new Software(id, name, description, photo, downloadTimes, url, kindId);
                list.add(software);
            }
            return list;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 查询最多下载的软件
     *
     * @param number
     * @return
     * @throws Exception
     */
    public static List<Software> queryHotSoftware(int number) throws Exception {
        //软件集合
        List<Software> list = new ArrayList<Software>();
        //sql语句
        String sql = "SELECT id,name,description,photo,download_times,url,kind_id FROM software " +
                "order by download_times desc LIMIT 0," + number;
        Connection c = DB.getConn();
        Statement stmt = DB.createStatement(c);
        ResultSet rs = DB.executeQuery(c, stmt, sql);
        try {
            if (rs == null) {
                throw new RuntimeException("数据库操作出错，请重试！");
            }
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String photo = rs.getString("photo");
                int downloadTimes = rs.getInt("download_times");
                String url = rs.getString("url");
                int kindId = rs.getInt("kind_id");
                Software software = new Software(id, name, description, photo, downloadTimes, url, kindId);
                list.add(software);
            }
            return list;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 根据id查软件
     *
     * @param id
     * @return
     * @throws Exception
     */
    public static Software getSoftwareById(int id) throws Exception {
        String sql = "SELECT name,description,photo,download_times,url,kind_id FROM software WHERE id=" + id;
        Connection c = DB.getConn();
        Statement stmt = DB.createStatement(c);
        ResultSet rs = DB.executeQuery(c, stmt, sql);
        try {
            if (rs == null) {
                throw new RuntimeException("数据库操作出错，请重试！");
            }
            while (rs.next()) {
                String name = rs.getString("name");
                String description = rs.getString("description");
                String photo = rs.getString("photo");
                int downloadTimes = rs.getInt("download_times");
                String url = rs.getString("url");
                int kindId = rs.getInt("kind_id");
                Software software = new Software(id, name, description, photo, downloadTimes, url, kindId);
                return software;
            }
            return null;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 新增软件
     *
     * @param software
     * @throws Exception
     */
    public static void insertSoftware(Software software) throws Exception {
        String sql = "insert into software(id,name,description,photo,download_times,url,kind_id) values" +
                "(null,'" + software.getName() + "','" + software.getDescription() + "','" + software.getPhoto() +
                "'," + software.getDownloadTimes() + ",'" + software.getUrl() + "'," + software.getKindId() + ")";
        DB.executeUpdate(sql);
    }

    /**
     * 更新软件
     *
     * @param software
     * @throws Exception
     */
    public static void updateSoftware(Software software) throws Exception {
        String sql = "update software set name='" + software.getName() + "',description='" +
                software.getDescription() + "',photo='" + software.getPhoto() + "',download_times=" +
                software.getDownloadTimes() + ",url='" + software.getUrl() + "',kind_id=" + software.getKindId() +
                " where id=" + software.getId();
        DB.executeUpdate(sql);
    }

    /**
     * 删除软件
     *
     * @param software
     * @throws Exception
     */
    public static void deleteSoftware(Software software) throws Exception {
        String sql = "delete from software where id=" + software.getId();
        DB.executeUpdate(sql);
    }
}
