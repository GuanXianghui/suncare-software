package com.gxx.software;

import com.gxx.software.dao.KindDao;
import com.gxx.software.entities.Kind;
import com.gxx.software.interfaces.BaseInterface;
import com.gxx.software.interfaces.SymbolInterface;

/**
 * 修改分类
 *
 * @author Gxx
 * @module oa
 * @datetime 14-5-10 19:20
 */
public class UpdateKindsAction extends BaseAction implements BaseInterface{
    private String kindIds;
    private String kinds;

    /**
     * 入口
     * @return
     */
    public String execute() throws Exception {
        logger.info("kindIds:[" + kindIds + "],kinds:[" + kinds + "]");
        String[] kindIdArray = kindIds.split(SymbolInterface.SYMBOL_COMMA);
        String[] kindArray = kinds.split(SymbolInterface.SYMBOL_COMMA);
        for(int i=0;i<kindIdArray.length;i++){
            String kindId = kindIdArray[i];
            Kind kind = KindDao.getKindById(Integer.parseInt(kindId));
            kind.setName(kindArray[i]);
            KindDao.updateKind(kind);
        }
        //更新session缓存
        request.getSession().setAttribute(SESSION_KIND_LIST, KindDao.queryAllKinds());
        message = "修改分类成功！";
        return SUCCESS;
    }

    public String getKindIds() {
        return kindIds;
    }

    public void setKindIds(String kindIds) {
        this.kindIds = kindIds;
    }

    public String getKinds() {
        return kinds;
    }

    public void setKinds(String kinds) {
        this.kinds = kinds;
    }
}
