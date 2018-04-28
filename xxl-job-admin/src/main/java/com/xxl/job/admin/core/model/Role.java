/*
 * 文件名：Role.java
 * 版权：Copyright by hcn
 * 描述：
 * 修改人：HCN
 * 修改时间：2018年4月27日
 */

package com.xxl.job.admin.core.model;

public class Role {

    private int id;
    private String role;  //角色字段
    private String description; //角色说明
    
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    
    
}
