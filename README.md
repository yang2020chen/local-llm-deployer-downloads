# Local LLM Deployer - Windows 安装包官方发布仓库

> ⚠️ **声明**：本仓库为 **Local LLM Deployer** 官方编译安装包的**公开下载分发仓库**，非源代码仓库，不包含软件源码。完整开发源代码由维护者在独立私有仓库中维护。

---

## 🚀 软件简介 (Overview)

**Local LLM Deployer** 是一款专为 Windows 平台打造的本地大语言模型快速部署工具。它内置精简图形向导与本地服务管理控制台，帮助用户在本地快速拉起大模型推理服务，并提供标准 OpenAI 兼容接口供本地客户端与 Agent 接入。

- **支持平台**：Windows 10 / 11 64 位 (x64)
- **默认模型**：`Ternary-Bonsai-2-27B-PQ2_0.gguf`（Bonsai 2）
  - *说明：安装包内不内置庞大的模型权重文件，需用户在首次启动时单独下载或导入。*
- **默认接口**：仅限本机回环访问 `http://127.0.0.1:8080/v1`
- **局域网访问 (LAN Access)**：默认关闭。若需开启，必须在控制台设置中显式授权并配置 Token 认证。

---

## 📥 最新版本下载 (Latest Release)

### **V1.3.1 (Windows x64)**

- **下载链接**：[LocalLlmDeployer-Setup-v1.3.1-x64.exe](https://github.com/yang2020chen/local-llm-deployer-downloads/releases/download/v1.3.1/LocalLlmDeployer-Setup-v1.3.1-x64.exe)
- **Release 页面**：[GitHub Releases - v1.3.1](https://github.com/yang2020chen/local-llm-deployer-downloads/releases/tag/v1.3.1)
- **文件大小**：`422,717,074` 字节 (~403.13 MB)
- **SHA-256 校验和**：
  ```
  30B1A294A7187E9832EE36FD924E1F50A4CD3AB13C6570942AC02ED81884AFEB
  ```

#### 本版本关键更新：
- 修复 WPF 界面在遭遇瞬态剪贴板独占锁（`COMException 0x800401D0: CLIPBRD_E_CANT_OPEN`）时可能引发的未处理异常与客户端闪退问题，增加 3 次有界指数退避重试与安全失败提示。

---

## ⚠️ 使用与兼容性须知 (Notice & Known Limitations)

1. **数字签名说明**：本软件安装包及可执行文件**未经 Authenticode 商业数字证书签名**。Windows SmartScreen 或杀毒软件可能会弹出“未知发布者”提示，属预期现象；用户可根据上方提供的官方 SHA-256 校验和核对安装包完整性后选择“仍要运行”。
2. **高分屏缩放 (DPI)**：本版本尚未完成针对 125% 及 150% Windows 系统缩放比例的完整实机适配测试，高缩放环境下部分界面可能存在局部排版微调需求。
3. **安全性原则**：本工具默认不开放外部网络监听；局域网访问请务必保管好生成的访问凭证，切勿将未授权的本地模型接口暴露于公网。

---

## 🔍 安装包校验方法 (Integrity Verification)

在 Windows PowerShell 中执行以下命令，核对下载文件的 SHA-256 哈希值：

```powershell
Get-FileHash -Path "LocalLlmDeployer-Setup-v1.3.1-x64.exe" -Algorithm SHA256
```

输出的 `Hash` 必须严格为：
`30B1A294A7187E9832EE36FD924E1F50A4CD3AB13C6570942AC02ED81884AFEB`
