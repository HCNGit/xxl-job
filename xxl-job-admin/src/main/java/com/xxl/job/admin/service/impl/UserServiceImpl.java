/*
 * 文件名：UserServiceImpl.java
 * 版权：Copyright by hcn
 * 描述：
 * 修改人：HCN
 * 修改时间：2018年4月27日
 */

package com.xxl.job.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
    
    public int update(User user){
        
        return userDao.update(user);
    }
    
    public int resetPassword(User user){
        return userDao.resetPassword(user);
    }

    @Override
    public Map<String, Object> pageList(int start, int length, int roleId, String nameOrAccount) {

        // page list
        List<User> list = userDao.pageList(start, length, roleId,nameOrAccount);
        int list_count = userDao.pageListCount(start, length, roleId,nameOrAccount);
        
        
        
        // package result
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("recordsTotal", list_count);       // 总记录数
        maps.put("recordsFiltered", list_count);    // 过滤后的总记录数
        maps.put("data", list);                     // 分页列表
        return maps;
    }
}
