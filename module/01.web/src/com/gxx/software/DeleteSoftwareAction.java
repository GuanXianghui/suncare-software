package com.gxx.software;

import com.gxx.software.dao.SoftwareDao;
import com.gxx.software.entities.Software;
import com.gxx.software.interfaces.BaseInterface;
import org.apache.commons.lang.StringUtils;

/**
 * ɾ�����
 *
 * @author Gxx
 * @module oa
 * @datetime 14-5-10 19:20
 */
public class DeleteSoftwareAction extends BaseAction implements BaseInterface{
    private String softwareId;

    /**
     * ���
     * @return
     */
    public String execute() throws Exception {
        logger.info("softwareId:[" + softwareId + "]");
        if(StringUtils.isBlank(softwareId)){
            message = "���Ĳ�������";
            return ERROR;
        }

        Software software = SoftwareDao.getSoftwareById(Integer.parseInt(softwareId));
        SoftwareDao.deleteSoftware(software);

        message = "ɾ������ɹ���";
        return SUCCESS;
    }

    public String getSoftwareId() {
        return softwareId;
    }

    public void setSoftwareId(String softwareId) {
        this.softwareId = softwareId;
    }
}
