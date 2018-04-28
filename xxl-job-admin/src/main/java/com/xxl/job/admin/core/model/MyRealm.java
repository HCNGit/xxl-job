/*
 * 文件名：MyRealm.java
 * 版权：Copyright by hcn
 * 描述：
 * 修改人：HCN
 * 修改时间：2018年4月26日
 */

package com.xxl.job.admin.core.model;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.xxl.job.admin.service.UserService;

public class MyRealm extends AuthorizingRealm{

    @Autowired
    private UserService userService;

    // 为当前登陆成功的用户授予权限和角色，已经登陆成功了
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(
            PrincipalCollection principals) {
        System.out.println("权限配置-->MyShiroRealm.doGetAuthorizationInfo()");
        
        User user = (User) principals.getPrimaryPrincipal(); //获取帐号
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        authorizationInfo.setRoles(userService.getRoles(user.getAccount()));
        authorizationInfo.setStringPermissions(userService.getPermissions(user.getAccount()));
        return authorizationInfo;
    }

    /*主要是用来进行身份认证的，也就是说验证用户输入的账号和密码是否正确。*/
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(
            AuthenticationToken token) throws AuthenticationException {
        System.out.println("认证身份---MyShiroRealm.doGetAuthenticationInfo()");
        String account = (String) token.getPrincipal(); // 获取帐号
        //通过account从数据库中查找 User对象，如果找到，没找到.
        //实际项目中，这里可以根据实际情况做缓存，如果不做，Shiro自己也是有时间间隔机制，2分钟内不会重复执行该方法
        User user = userService.getByAccount(account);
        if(user != null) {
            SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                user, //用户名
                user.getPassword(), //密码
                ByteSource.Util.bytes(user.getPasswordSalt()),
                getName()  //realm name
        );
        return authenticationInfo;
        } else {
            return null;
        }
    }
}
