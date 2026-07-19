# WebMvcConfig.java

```java
package com.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    // 把本地磁盘路径映射成 URL，让浏览器能访问上传的图片
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/avatar/**")                    // URL 路径
                .addResourceLocations("file:D:/uploads/avatars/");   // 本地磁盘路径
    }
}
```
