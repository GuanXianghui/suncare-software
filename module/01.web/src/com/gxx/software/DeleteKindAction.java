package com.gxx.software;

import com.gxx.software.dao.KindDao;
import com.gxx.software.entities.Kind;
import com.gxx.software.interfaces.BaseInterface;

/**
 * ɾ������
 *
 * @author Gxx
 * @module oa
 * @datetime 14-5-10 19:20
 */
public class DeleteKindAction extends BaseAction implements BaseInterface{
    private String id;

    /**
     * ���
     * @return
     */
    public String execute() throws Exception {
        logger.info("id:[" + id + "]");
        Kind kind = KindDao.getKindById(Integer.parseInt(id));
        if(kind != null){
            KindDao.deleteKind(kind);
        }
        //����session����
        request.getSession().setAttribute(SESSION_KIND_LIST, KindDao.queryAllKinds());
        message = "ɾ������ɹ���";
        return SUCCESS;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
