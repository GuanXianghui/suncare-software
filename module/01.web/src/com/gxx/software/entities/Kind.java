package com.gxx.software.entities;

/**
 * ����ʵ��
 *
 * @author Gxx
 * @module oa
 * @datetime 14-5-17 23:36
 */
public class Kind {
    int id;
    String name;

    /**
     * ����ʱʹ��
     * @param name
     */
    public Kind(String name) {
        this.name = name;
    }

    /**
     * ��ѯʱʹ��
     * @param id
     * @param name
     */
    public Kind(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
