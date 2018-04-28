/*
 * 文件名：UserDao.java
 * 版权：Copyright by hcn
 * 描述：
 * 修改人：HCN
 * 修改时间：2018年4月27日
 */

package com.xxl.job.admin.dao;

import java.util.Set;

import com.xxl.job.admin.core.model.User;

public interface UserDao {
    
    public User getByAccount(String account);

    //根据帐号获取其所有角色
    public Set<String> getRoles(String account);
    
    //根据帐号获取所有权限
    public Set<String> getPermissions(String account);
    
    public int register(User user);
}
