package com.gxx.software;

import com.gxx.software.dao.KindDao;
import com.gxx.software.entities.Kind;
import com.gxx.software.interfaces.BaseInterface;

/**
 * ��������
 *
 * @author Gxx
 * @module oa
 * @datetime 14-5-10 19:20
 */
public class CreateKindAction extends BaseAction implements BaseInterface{
    private String kind;

    /**
     * ���
     * @return
     */
    public String execute() throws Exception {
        logger.info("kind:[" + kind + "]");
        Kind newKind = new Kind(kind);
        KindDao.insertKind(newKind);
        //����session����
        request.getSession().setAttribute(SESSION_KIND_LIST, KindDao.queryAllKinds());
        message = "��������ɹ���";
        return SUCCESS;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }
}
