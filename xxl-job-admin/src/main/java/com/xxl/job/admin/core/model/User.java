/*
 * 文件名：User.java 版权：Copyright by hcn 描述： 修改人：HCN 修改时间：2018年4月27日
 */

package com.xxl.job.admin.core.model;

public class User {

    private int id;

    private String name; // 真实姓名

    private String account; // 登录帐号

    private String password;

    private String passwordSalt;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordSalt() {
        return passwordSalt;
    }

    public void setPasswordSalt(String passwordSalt) {
        this.passwordSalt = passwordSalt;
    }

    
}
