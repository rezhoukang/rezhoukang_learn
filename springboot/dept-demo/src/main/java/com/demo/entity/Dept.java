package com.demo.entity;

import lombok.Data;

/** 装了 Lombok 才用 @Data，否则要手写下面全部 */
@Data  // ↓ 这一行 = 下面全部 18 行
public class Dept {
    private Integer id;
    private String name;
    private String location;

    /* 没 Lombok 时你得写这些：
    public Dept() {}
    public Dept(Integer id, String name, String location) {
        this.id = id; this.name = name; this.location = location;
    }
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    */
}

// Lombok 项目名来源于印尼龙目岛（Lombok Island），开发者是荷兰人，以家乡命名
