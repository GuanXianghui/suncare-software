package com.gxx.software.dao;

import com.gxx.software.entities.Kind;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * �û�ʵ�������
 *
 * @author Gxx
 * @module oa
 * @datetime 14-3-29 20:22
 */
public class KindDao {
    /**
     * ��ѯ���з���
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
                throw new RuntimeException("���ݿ�������������ԣ�");
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
     * ����id�����
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
                throw new RuntimeException("���ݿ�������������ԣ�");
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
     * ��������
     *
     * @param kind
     * @throws Exception
     */
    public static void insertKind(Kind kind) throws Exception {
        String sql = "insert into kind(id,name) values(null,'" + kind.getName() + "')";
        DB.executeUpdate(sql);
    }

    /**
     * ���·���
     *
     * @param kind
     * @throws Exception
     */
    public static void updateKind(Kind kind) throws Exception {
        String sql = "update kind set name='" + kind.getName() + "' where id=" + kind.getId();
        DB.executeUpdate(sql);
    }

    /**
     * ɾ������
     *
     * @param kind
     * @throws Exception
     */
    public static void deleteKind(Kind kind) throws Exception {
        String sql = "delete from kind where id=" + kind.getId();
        DB.executeUpdate(sql);
    }
}
