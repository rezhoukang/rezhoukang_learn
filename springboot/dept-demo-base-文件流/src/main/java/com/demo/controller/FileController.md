# FileController.java

```java
package com.demo.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/files")
public class FileController {

    // POST  /files/upload-avatar    表单参数名: file
    @PostMapping("/upload-avatar")
    public Map<String, Object> uploadAvatar(@RequestParam("file") MultipartFile file) {

        // 1. 生成唯一文件名，防止重名覆盖
        String originalName = file.getOriginalFilename();               // xxx.jpg
        String ext = originalName.substring(originalName.lastIndexOf(".")); // .jpg
        String newName = UUID.randomUUID() + ext;                       // 550e8400.jpg

        // 2. 保存到本地磁盘
        File dest = new File("D:/uploads/avatars/" + newName);
        // 创建一个 File 对象，指向要保存的位置（文件夹路径 + 文件名）
        try {
            file.transferTo(dest);
            // 把上传的文件内容，真正写入到磁盘的那个文件里
        } catch (IOException e) {
            // 如果写入失败（比如磁盘满了、路径不存在），就捕获异常
            return Map.of("success", false, "message", "上传失败");
        }

        // 3. 返回可访问的 URL
        String url = "http://localhost:8080/avatar/" + newName;
        return Map.of("success", true, "data", url);
    }
}
```
