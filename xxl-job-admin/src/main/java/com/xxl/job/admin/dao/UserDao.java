/*
 * 文件名：UserDao.java
 * 版权：Copyright by hcn
 * 描述：
 * 修改人：HCN
 * 修改时间：2018年4月27日
 */

package com.xxl.job.admin.dao;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.xxl.job.admin.core.model.User;

public interface UserDao {
    
    
    public List<User> pageList(@Param("offset") int offset,
                                     @Param("pagesize") int pagesize,
                                     @Param("roleId") int roleId,
                                     @Param("nameOrAccount") String nameOrAccount);
    public int pageListCount(@Param("offset") int offset,
                             @Param("pagesize") int pagesize,
                             @Param("roleId") int roleId,
                             @Param("nameOrAccount") String nameOrAccount);
    
    
    public User getByAccount(String account);

    //根据帐号获取其所有角色
    public Set<String> getRoles(String account);
    
    //根据帐号获取所有权限
    public Set<String> getPermissions(String account);
    
    public int register(User user);
    
    public int update(User user);
    
    public int resetPassword(User user);
}
