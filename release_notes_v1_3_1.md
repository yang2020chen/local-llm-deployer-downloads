# Local LLM Deployer Windows V1.3.1

### 🛠️ 变更说明
本版本为 Windows 客户端热修复发布（Hotfix），主要解决瞬态剪贴板独占导致的异常崩溃：
- **剪贴板稳健性与防崩溃**：修复 WPF 复制操作在遭遇其它进程瞬态锁定（`COMException 0x800401D0: CLIPBRD_E_CANT_OPEN`）时未处理异常导致客户端闪退的问题；增加 3 次有界指数退避重试及安全降级提示。

---

### 📌 范围与配置说明 (Scope & Default Settings)
- **目标平台**：Windows 10 / 11 64-bit (x64)
- **推荐模型**：`Ternary-Bonsai-2-27B-PQ2_0.gguf`（Bonsai 2），模型权重需单独下载或导入
- **网络与安全**：默认仅开放本机回环 API（`http://127.0.0.1:8080/v1`），局域网（LAN）访问默认关闭且须用户显式授权并配置 Token 认证
- **数字签名**：安装包未经 Authenticode 商业数字证书签名，SmartScreen 可能会提示未知发布者，可通过下方哈希校验完整性
- **高分屏支持**：125% / 150% DPI 缩放当前尚未经完整实机测试

---

### 📦 安装包校验信息 (Installer Integrity)
- **文件名称**：`LocalLlmDeployer-Setup-v1.3.1-x64.exe`
- **文件大小**：`422,717,074` 字节 (~403.13 MB)
- **SHA-256**：
  ```
  30B1A294A7187E9832EE36FD924E1F50A4CD3AB13C6570942AC02ED81884AFEB
  ```

> 💡 本发布页面为官方直接下载源，无需 GitHub 账号登录即可直接匿名下载。
