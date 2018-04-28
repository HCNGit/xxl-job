/*
 * 文件名：UserService.java
 * 版权：Copyright by hcn
 * 描述：
 * 修改人：HCN
 * 修改时间：2018年4月27日
 */

package com.xxl.job.admin.service;

import java.util.Set;

import com.xxl.job.admin.core.model.User;

public interface UserService {

    
    //获取用户
    public User getByAccount(String account);
    
    //获取帐号所有角色
    public Set<String> getRoles(String account);
    
    //获取帐号所有权限
    public Set<String> getPermissions(String account);
    
    public int register(User user);
}
