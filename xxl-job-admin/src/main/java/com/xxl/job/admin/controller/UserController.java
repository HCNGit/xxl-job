/*
 * 文件名：UserController.java
 * 版权：Copyright by hcn
 * 描述：
 * 修改人：HCN
 * 修改时间：2018年4月27日
 */

package com.xxl.job.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xxl.job.admin.core.model.User;
import com.xxl.job.admin.core.util.I18nUtil;
import com.xxl.job.admin.service.UserService;
import com.xxl.job.core.biz.model.ReturnT;


/**
 * 包括用户管理和登录模块----------------------------TODO二期做到根据不同的角色得到不同的视图
 * 
 * @author HCN
 * @version 2018年4月27日
 * @see UserController
 * @since
 */
@Controller
public class UserController {

    @Autowired
    private UserService userService;
    
    //随机数生成器
    private static RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();
    

    @RequestMapping("/usermanage")
    public String index(Model model, HttpServletRequest request) {
        String I18nContent = I18nUtil.getMultString();
        model.addAttribute("I18nContent", I18nContent);
        return "usermanage/usermanage.index";
    }
    
    @RequestMapping("/toLogin")
    public String toLogin(Model model, HttpServletRequest request) {
        String I18nContent = I18nUtil.getMultString();
        model.addAttribute("I18nContent", I18nContent);
        return "login";
    }
    
    
    @RequestMapping(value="login", method=RequestMethod.POST)
    @ResponseBody
    public ReturnT<String> loginDo(HttpServletRequest request, HttpServletResponse response, String account, String password, String ifRemember){

        // 参数后端校验
        if (StringUtils.isBlank(account) || StringUtils.isBlank(password)){
            return new ReturnT<String>(500, "用户名或密码为空");
        }
        User user = new User();
        user.setAccount(account);
        user.setPassword(password);
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(account, password);
        String msg = "";
        try{
            subject.login(token);//会跳到我们自定义的realm中
            request.getSession().setAttribute("user", user);
            return ReturnT.SUCCESS;
        }catch(UnknownAccountException uae){
            uae.printStackTrace();
            msg = "账号不存在!";
            return new ReturnT<>(500,msg);
        }catch (IncorrectCredentialsException ice) {
            ice.printStackTrace();
            msg = "密码错误!";
            return new ReturnT<>(500,msg);
        }catch (Exception e) {
            e.printStackTrace();
            msg = "未知错误!";
            return new ReturnT<>(500,msg);
        }

    }
    
    @RequestMapping(value="logout", method=RequestMethod.POST)
    @ResponseBody
    public ReturnT<String> logout(HttpServletRequest request, HttpServletResponse response){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return ReturnT.SUCCESS;
    }
    
    @RequestMapping(value="usermanage/register", method=RequestMethod.POST)
    @ResponseBody
    public ReturnT<String> register(HttpServletRequest request, HttpServletResponse response, String account, String password, String ifRemember){

        // 参数后端校验
        if (StringUtils.isBlank(account)){
            return new ReturnT<String>(500, "用户名为空");
        }else if (StringUtils.isBlank(password)){
            return new ReturnT<String>(500, "密码为空");
        }
        
        String salt = randomNumberGenerator.nextBytes().toHex();
        String passwordWithSalt = new SimpleHash("MD5","123456",salt,2).toHex();
        User user = new User();
        user.setAccount(account);
        user.setPassword(passwordWithSalt);
        user.setPasswordSalt(salt);
        int result = userService.register(user);
        if (result <= 0) {
            return new ReturnT<String>(500,"注册失败");
        }
        return ReturnT.SUCCESS;

    }
}
