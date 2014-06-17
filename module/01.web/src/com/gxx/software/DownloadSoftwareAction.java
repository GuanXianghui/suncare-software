package com.gxx.software;

import com.gxx.software.dao.SoftwareDao;
import com.gxx.software.entities.Software;
import com.gxx.software.interfaces.BaseInterface;
import com.gxx.software.utils.TokenUtil;
import org.apache.commons.lang.StringUtils;

/**
 * �������
 *
 * @author Gxx
 * @module oa
 * @datetime 14-5-10 19:20
 */
public class DownloadSoftwareAction extends BaseAction implements BaseInterface{
    private String id;

    /**
     * ���
     * @return
     */
    public String execute() throws Exception {
        logger.info("id:[" + id + "]");
        if(StringUtils.isBlank(id)){
            message = "���Ĳ�������";
            String resp = "{isSuccess:false,message:'" + message + "',hasNewToken:true,token:'" +
                    TokenUtil.createToken(request) + "'}";
            write(resp);
            return null;
        }
        Software software = SoftwareDao.getSoftwareById(Integer.parseInt(id));
        if(null == software){
            message = "���Ĳ�������";
            String resp = "{isSuccess:false,message:'" + message + "',hasNewToken:true,token:'" +
                    TokenUtil.createToken(request) + "'}";
            write(resp);
            return null;
        }
        software.setDownloadTimes(software.getDownloadTimes() + 1);
        SoftwareDao.updateSoftware(software);

        message = "�޸����ش����ɹ���";
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
