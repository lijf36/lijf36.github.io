# JuneSky

Junfeng Li 的个人网站，使用 Jekyll / Academic Pages。

- 线上网站：<https://lijf36.github.io/>
- 源码仓库：<https://github.com/lijf36/lijf36.github.io>
- 修改入口与维护约定：[AGENTS.md](AGENTS.md)。

## 页面与栏目

当前导航只保留 `About`（个人介绍）和 `Contact`（联系方式）。论文、报告、教学、作品、博客、简历及指南栏目暂时隐藏，原始示例已移至 [_template_archive/](_template_archive/README.md)，不参与站点生成；首页、站点地图和 404 页继续保留。

后续先在 `_pages/` 或对应内容目录中添加经确认的真实资料，再将栏目加入 `_data/navigation.yml`。原始模板可以参考格式，但不要整批恢复示例。添加真实博客后，可将 `_config.yml` 中的 `atom_feed.hide` 改为 `false`，恢复订阅入口。

## 首次准备

Windows 使用 Ruby+Devkit 3.3 x64，并安装随附的 MSYS2/MINGW 开发工具。首次安装或 `Gemfile` 改动后，在 PowerShell 中进入项目并安装依赖：

```powershell
Set-Location 'C:\Users\57210\Jupyter_dev\personal_website'

# 新安装的 Ruby 尚未进入当前终端 PATH 时，无需重启 Codex。
if (-not (Get-Command ruby -CommandType Application -ErrorAction SilentlyContinue)) {
    $rubyBin = Join-Path $env:LOCALAPPDATA 'Programs\Ruby33-x64\bin'
    $env:PATH = "$rubyBin;$env:PATH"
}

ruby --version
bundle --version
bundle config set --local path vendor/bundle
bundle install
```

若 Ruby 安装在其他位置，将其 `bin` 目录加入当前终端的 `PATH`；只有 Bundler 不可用时才先执行 `gem install bundler`。依赖保存在本项目的 `vendor/bundle/`，无需提交该目录。`preview.ps1` 会优先使用 `PATH` 中的 Ruby，再查找 `%LOCALAPPDATA%\Programs\Ruby33-x64\bin`；脚本只检查依赖，不会自动安装软件。

## 本地预览

在项目目录运行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\preview.ps1
```

等待终端显示服务器已启动后，在浏览器打开 <http://localhost:4000/>。预览在前台运行，保留该终端；按 `Ctrl+C` 停止。脚本不会自动打开浏览器或创建后台服务。上述执行策略参数仅作用于这次 PowerShell 进程。

服务只监听本机的 `127.0.0.1`，但 Jekyll 会生成指向 `localhost` 的资源链接。浏览器统一用 `localhost` 访问，可以避免字体跨域导致侧栏图标显示为方框。

端口已占用时可换一个端口：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\preview.ps1 -Port 4001
```

然后访问 <http://localhost:4001/>。普通内容修改会触发重新生成，刷新浏览器即可查看；修改 `_config.yml` 后需要停止并重新启动预览。

## 只检查构建

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\preview.ps1 -Build
```

生成结果位于 `_site/`，该目录不是编辑源文件的位置。此命令不会启动服务器。

这些操作只用于本地预览和检查，不会提交、推送或发布到 GitHub；线上网站不会因此改变。发布前需另外核对 GitHub Pages 设置及本次变更。
