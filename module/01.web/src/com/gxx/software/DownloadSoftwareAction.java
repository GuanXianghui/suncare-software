package com.gxx.software;

import com.gxx.software.dao.SoftwareDao;
import com.gxx.software.entities.Software;
import com.gxx.software.interfaces.BaseInterface;
import com.gxx.software.utils.TokenUtil;
import org.apache.commons.lang.StringUtils;

/**
 * 下载软件
 *
 * @author Gxx
 * @module oa
 * @datetime 14-5-10 19:20
 */
public class DownloadSoftwareAction extends BaseAction implements BaseInterface{
    private String id;

    /**
     * 入口
     * @return
     */
    public String execute() throws Exception {
        logger.info("id:[" + id + "]");
        if(StringUtils.isBlank(id)){
            message = "您的操作有误";
            String resp = "{isSuccess:false,message:'" + message + "',hasNewToken:true,token:'" +
                    TokenUtil.createToken(request) + "'}";
            write(resp);
            return null;
        }
        Software software = SoftwareDao.getSoftwareById(Integer.parseInt(id));
        if(null == software){
            message = "您的操作有误";
            String resp = "{isSuccess:false,message:'" + message + "',hasNewToken:true,token:'" +
                    TokenUtil.createToken(request) + "'}";
            write(resp);
            return null;
        }
        software.setDownloadTimes(software.getDownloadTimes() + 1);
        SoftwareDao.updateSoftware(software);

        message = "修改下载次数成功！";
        String resp = "{isSuccess:true,message:'" + message + "',hasNewToken:true,token:'" +
                TokenUtil.createToken(request) + "'}";
        write(resp);
        return null;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
