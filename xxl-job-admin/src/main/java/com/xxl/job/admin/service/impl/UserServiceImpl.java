/*
 * 文件名：UserServiceImpl.java
 * 版权：Copyright by hcn
 * 描述：
 * 修改人：HCN
 * 修改时间：2018年4月27日
 */

package com.xxl.job.admin.service.impl;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xxl.job.admin.core.model.User;
import com.xxl.job.admin.dao.UserDao;
import com.xxl.job.admin.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    
    @Override
    public User getByAccount(String account) {
        return userDao.getByAccount(account);
    }

    @Override
    public Set<String> getRoles(String account) {
        
        return userDao.getRoles(account);
    }

    @Override
    public Set<String> getPermissions(String account) {
        
        return userDao.getPermissions(account);
    }
    
    public int register(User user){
        
        return userDao.register(user);
    }

}
