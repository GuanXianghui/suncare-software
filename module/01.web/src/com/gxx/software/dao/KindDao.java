package com.gxx.software.dao;

import com.gxx.software.entities.Kind;

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
public class KindDao {
    /**
     * 查询所有分类
     *
     * @return
     * @throws Exception
     */
    public static List<Kind> queryAllKinds() throws Exception {
        List<Kind> list = new ArrayList<Kind>();
        String sql = "SELECT id,name FROM kind order by id";
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
                Kind kind = new Kind(id, name);
                list.add(kind);
            }
            return list;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 根据id查分类
     *
     * @param id
     * @return
     * @throws Exception
     */
    public static Kind getKindById(int id) throws Exception {
        String sql = "SELECT name FROM kind WHERE id=" + id;
        Connection c = DB.getConn();
        Statement stmt = DB.createStatement(c);
        ResultSet rs = DB.executeQuery(c, stmt, sql);
        try {
            if (rs == null) {
                throw new RuntimeException("数据库操作出错，请重试！");
            }
            while (rs.next()) {
                String name = rs.getString("name");
                Kind kind = new Kind(id, name);
                return kind;
            }
            return null;
        } finally {
            DB.close(rs);
            DB.close(stmt);
            DB.close(c);
        }
    }

    /**
     * 新增分类
     *
     * @param kind
     * @throws Exception
     */
    public static void insertKind(Kind kind) throws Exception {
        String sql = "insert into kind(id,name) values(null,'" + kind.getName() + "')";
        DB.executeUpdate(sql);
    }

    /**
     * 更新分类
     *
     * @param kind
     * @throws Exception
     */
    public static void updateKind(Kind kind) throws Exception {
        String sql = "update kind set name='" + kind.getName() + "' where id=" + kind.getId();
        DB.executeUpdate(sql);
    }

    /**
     * 删除分类
     *
     * @param kind
     * @throws Exception
     */
    public static void deleteKind(Kind kind) throws Exception {
        String sql = "delete from kind where id=" + kind.getId();
        DB.executeUpdate(sql);
    }
}
