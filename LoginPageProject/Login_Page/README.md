# Login Page (SwiftUI)

SwiftUI 登录流程示例，包含自定义组件与辅助扩展。UI 目标 iOS 17+（部分扩展支持 iOS 16.4）。当前网络/认证动作为示例睡眠，请替换为真实逻辑。

## 项目目录 / Project Tree
```
Login_Page/
├── Login_PageApp.swift
├── ContentView.swift
├── Assets.xcassets/
│   ├── AppIcon.appiconset/Contents.json
│   ├── AccentColor.colorset/Contents.json
│   └── Contents.json
└── LoginKit/
    ├── LoginKit.swift
    ├── LoginView.swift
    ├── RegisterView.swift
    ├── ForgotPasswordView.swift
    ├── View+Extensions.swift
    └── Helpers/
        ├── TaskButton.swift
        └── IconTextField.swift
```

## 中文（简体）
- `Login_PageApp.swift`：App 入口，显示 `ContentView`。
- `ContentView.swift`：用 `LoginKit("user_log_status")` 包裹登录后内容。
- `LoginKit/LoginKit.swift`：读取 `@AppStorage` 登录状态，未登录显示 `LoginView`，登录后显示注入内容。
- `LoginKit/LoginView.swift`：登录页（邮箱/密码），提供注册与忘记密码的 sheet，并包含示例 Alert。
- `LoginKit/RegisterView.swift`：注册 sheet，校验邮箱、密码与确认密码。
- `LoginKit/ForgotPasswordView.swift`：忘记密码 sheet，输入邮箱后触发重置。
- `LoginKit/Helpers/TaskButton.swift`：支持 async 任务的按钮，执行中禁用并显示进度，回调加载状态。
- `LoginKit/Helpers/IconTextField.swift`：带 SF Symbol 图标的胶囊毛玻璃输入框，支持密码。
- `LoginKit/View+Extensions.swift`：通用扩展：
  - `isiOS26`：是否为 iOS 26+，用于自适应 sheet 圆角。
  - `sheetAlert`：以 sheet 形式呈现自定义提示，包含图标、文案与任务按钮。
  - `customAlert`：基于 `AlertModal` 的简化封装。
- 资源：默认 Xcode 资产目录。

### 交互流程
- 初次启动因 `@AppStorage("user_log_status")` 默认为 false，呈现 `LoginView`。
- “Sign In”：目前为 1s 模拟请求，完成后触发示例 Alert；按钮需邮箱与密码非空才可点击。
- “Sign Up Here”：开启 `RegisterAccount` sheet（高度 400，iOS 26 以下自定义圆角）。
- “Forgot Password?”：开启 `ForgotPassword` sheet（高度 230）。
- 任务进行时通过透明度/禁用控制交互。

### 状态与存储
- `@AppStorage("user_log_status") var isLoggedIn` 控制是否显示登录 UI；示例中尚未设置为 true。
- 视图内部 `@State` 管理表单文本、加载与 Alert 显示。

### 扩展点
- 将各处 `Task.sleep` 替换为真实 API，成功后设置 `isLoggedIn = true`。
- 接入忘记密码后端，并用 `AlertModal`/`sheetAlert` 呈现结果。
- 自定义 sheet detent、高度、圆角与背景样式。
- 在 `ContentView` 的 `NavigationStack` 中填充登录后功能。

### 要求
- Xcode iOS 17+ SDK
- 纯 SwiftUI，无第三方依赖。

## English
- `Login_PageApp.swift`: App entry; shows `ContentView`.
- `ContentView.swift`: Wraps post-login content inside `LoginKit("user_log_status")`.
- `LoginKit/LoginKit.swift`: Reads `@AppStorage` login state; shows `LoginView` until `isLoggedIn` is true, then renders injected content.
- `LoginKit/LoginView.swift`: Sign-in screen (email/password) with links to register and forgot-password sheets; includes a sample alert.
- `LoginKit/RegisterView.swift`: Registration sheet validating email, password, and confirmation.
- `LoginKit/ForgotPasswordView.swift`: Password reset sheet collecting an email.
- `LoginKit/Helpers/TaskButton.swift`: Async-aware button that disables itself and shows a progress indicator; reports loading status via callback.
- `LoginKit/Helpers/IconTextField.swift`: Text field with an SF Symbol leading icon and capsule glass background; supports secure entry.
- `LoginKit/View+Extensions.swift`: Shared extensions:
  - `isiOS26`: Helper flag for adaptive sheet corner radius.
  - `sheetAlert`: Sheet-style custom alert with icon, text, and a task-backed button.
  - `customAlert`: Thin wrapper using `AlertModal`.
- Assets: Default Xcode asset catalog.

### UI Flow
- On launch `@AppStorage("user_log_status")` defaults to false, so `LoginView` is shown.
- “Sign In”: Currently a 1s simulated request, then fires a sample alert; button enabled only when email/password are non-empty.
- “Sign Up Here”: Opens `RegisterAccount` sheet (height 400, custom corner radius on < iOS 26).
- “Forgot Password?”: Opens `ForgotPassword` sheet (height 230).
- While tasks run, the UI dims and disables interactions.

### State & Storage
- `@AppStorage("user_log_status") var isLoggedIn` decides whether to show login UI; stubs never set it to true yet.
- Local `@State` handles form text, loading, and alerts.

### Extending
- Replace `Task.sleep` stubs with real API calls; set `isLoggedIn = true` on success.
- Wire forgot-password to your backend and present results via `AlertModal`/`sheetAlert`.
- Adjust sheet detents, heights, corner radii, and backgrounds.
- Populate `ContentView`’s `NavigationStack` with your post-login experience.

### Requirements
- Xcode with iOS 17+ SDK 
- SwiftUI only; no third-party dependencies.
