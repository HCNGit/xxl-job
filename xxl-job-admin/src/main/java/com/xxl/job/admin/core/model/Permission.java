/*
 * 文件名：Permission.java
 * 版权：Copyright by hcn
 * 描述：
 * 修改人：HCN
 * 修改时间：2018年4月27日
 */

package com.xxl.job.admin.core.model;

public class Permission {
    
    private int id;
    private String permission;
    private String description;
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getPermission() {
        return permission;
    }
    public void setPermission(String permission) {
        this.permission = permission;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
}
