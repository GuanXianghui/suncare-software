package com.gxx.software.entities;

/**
 * 软件实体
 *
 * @author Gxx
 * @module oa
 * @datetime 14-5-17 23:36
 */
public class Software {
    int id;
    String name;
    String description;
    String photo;
    int downloadTimes;
    String url;
    int kindId;

    /**
     * 新增时使用
     * @param name
     * @param description
     * @param photo
     * @param downloadTimes
     * @param url
     * @param kindId
     */
    public Software(String name, String description, String photo, int downloadTimes, String url, int kindId) {
        this.name = name;
        this.description = description;
        this.photo = photo;
        this.downloadTimes = downloadTimes;
        this.url = url;
        this.kindId = kindId;
    }

    /**
     * 查询时使用
     * @param id
     * @param name
     * @param description
     * @param photo
     * @param downloadTimes
     * @param url
     * @param kindId
     */
    public Software(int id, String name, String description, String photo, int downloadTimes, String url, int kindId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.photo = photo;
        this.downloadTimes = downloadTimes;
        this.url = url;
        this.kindId = kindId;
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

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public int getDownloadTimes() {
        return downloadTimes;
    }

    public void setDownloadTimes(int downloadTimes) {
        this.downloadTimes = downloadTimes;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getKindId() {
        return kindId;
    }

    public void setKindId(int kindId) {
        this.kindId = kindId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
