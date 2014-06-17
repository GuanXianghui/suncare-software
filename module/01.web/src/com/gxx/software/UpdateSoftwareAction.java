package com.gxx.software;

import com.gxx.software.dao.SoftwareDao;
import com.gxx.software.entities.Software;
import com.gxx.software.interfaces.BaseInterface;
import com.gxx.software.utils.FileUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.util.Date;

/**
 * 上传软件
 *
 * @author Gxx
 * @module oa
 * @datetime 14-5-10 19:20
 */
public class UpdateSoftwareAction extends BaseAction implements BaseInterface{
    private String softwareId;
    private String kind;
    private String name;
    private File photo;
    private String description;
    private String url;

    /**
     * 入口
     * @return
     */
    public String execute() throws Exception {
        logger.info("softwareId:[" + softwareId + "],kind:[" + kind + "],name:[" + name + "],photo:[" +
                photo+ "],description:[" + description + "],url:[" + url + "]");
        if(StringUtils.isBlank(softwareId)){
            message = "您的操作有误";
            return ERROR;
        }
        if(StringUtils.isBlank(name) || StringUtils.isBlank(url)){
            message = "软件名字，软件地址不为空";
            return ERROR;
        }
        Software software = SoftwareDao.getSoftwareById(Integer.parseInt(softwareId));
        name = StringUtils.trimToEmpty(name);
        description = StringUtils.trimToEmpty(description);
        url = StringUtils.trimToEmpty(url);
        software.setName(name);
        software.setDescription(description);
        software.setUrl(url);
        String photoValue = createPhoto();
        if(StringUtils.isNotBlank(photoValue)){
            software.setPhoto(photoValue);
        }
        int kindId = StringUtils.isBlank(kind)?0:Integer.parseInt(kind);
        software.setKindId(kindId);
        SoftwareDao.updateSoftware(software);

        message = "修改软件成功！";
        return SUCCESS;
    }

    /**
     * 创建图片
     * @return
     */
    private String createPhoto(){
        if(photo == null){
            return StringUtils.EMPTY;
        }
        //新的图片名称
        String photoName = new Date().getTime() + ".jpg";
        //服务器上的路径
        String photoPath = ServletActionContext.getServletContext().getRealPath("images/upload") + "/" + photoName;
        //页面引用位置 相对路径
        String photoPagePath = "images/upload/" + photoName;
        //服务器上的路径对应的文件
        File imageFile = new File(photoPath);
        //拷贝文件
        FileUtil.copy(photo, imageFile);
        return photoPagePath;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public File getPhoto() {
        return photo;
    }

    public void setPhoto(File photo) {
        this.photo = photo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getSoftwareId() {
        return softwareId;
    }

    public void setSoftwareId(String softwareId) {
        this.softwareId = softwareId;
    }
}
