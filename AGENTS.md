# 个人网站项目维护说明

## 项目目标与位置

- 维护 Junfeng Li 的个人网站，按用户要求逐步完善个人介绍、简历、文章及其他展示内容。
- 本地项目根目录：`C:/Users/57210/Jupyter_dev/personal_website/`。
- 网站地址：<https://lijf36.github.io/>。
- GitHub 仓库：<https://github.com/lijf36/lijf36.github.io>。
- Git 远程名为 `origin`，下载时检出的分支为 `main`。后续操作以实际 `git status`、远程和分支信息为准。
- 技术结构：Jekyll + Academic Pages（基于 Minimal Mistakes），页面使用 Markdown、YAML 和 Liquid，样式使用 SCSS。
- 此项目不继承单词学习项目的学习进度、Unit、翻译笔记或提醒流程。

## 开始修改前

1. 读取本文件，检查目标子目录是否存在更具体的 `AGENTS.md` 或 `AGENTS.override.md`。
2. 查看 `git status --short --branch` 和 `git remote -v`，保留用户已有改动。
3. 读取 `_config.yml`、`_data/navigation.yml` 以及与本次任务直接相关的页面；涉及依赖或构建时再读 `Gemfile`、`package.json` 和 `.gitignore`。
4. 先检查本地已有实现，优先沿用现有主题和目录，不另建一套网站。

## 常用修改入口

| 需求 | 文件或目录 | 说明 |
| --- | --- | --- |
| 网站名称、个人简介、头像与社交链接 | `_config.yml` | `author` 控制侧栏；`url`、`baseurl`、`repository` 控制站点地址 |
| 首页正文 | `_pages/about.md` | `permalink: /`，不是根目录的 README |
| 顶部导航 | `_data/navigation.yml` | 导航链接需与目标页面的 `permalink` 一致 |
| 简历 | 有真实资料后在 `_pages/cv.md` 创建 | 原始模板位于 `_template_archive/_pages/cv.md`，不能直接当作真实简历恢复 |
| 普通页面、归档页 | `_pages/` | 保留 YAML front matter、必要的 Liquid 标签和已有链接 |
| 博客文章与草稿 | `_posts/`、`_drafts/` | 博客文件沿用 `YYYY-MM-DD-slug.md` 命名 |
| 论文、报告、教学、作品 | `_publications/`、`_talks/`、`_teaching/`、`_portfolio/` | 集合由 `_config.yml` 定义 |
| 头像、配图与图标 | `images/` | 当前头像由配置引用 `李俊锋.jpg` |
| PDF 等公开附件 | `files/` | 放入此目录的文件可能随网站公开发布 |
| 页面布局和公共组件 | `_layouts/`、`_includes/` | 改动可能影响多个页面 |
| 样式 | `assets/css/main.scss`、`_sass/` | 优先修改相应源文件，谨慎改动 `vendor` 内容 |
| 浏览器交互脚本 | `assets/js/_main.js`、`assets/js/plugins/` | 修改后按需重新生成 `assets/js/main.min.js` |
| 辅助内容生成 | `markdown_generator/`、`talkmap.py`、`talkmap.ipynb`、`talkmap/` | 只有任务需要时才使用，不是普通页面修改的必经步骤 |
| 原始示例存档 | `_template_archive/` | 保留原目录结构，已从站点生成内容中排除；原示例地图位于其中的 `talkmap/` |

## 内容与文件约定

- 使用 UTF-8；保留 YAML 缩进、Markdown front matter 和 Liquid 语法。
- 文件中的公式默认使用 `$...$` 和 `$$...$$`；涉及公式展示时检查现有数学渲染设置和页面实际效果。
- 首页已改为简短个人介绍，侧栏保留现有姓名、所在地、备考状态、邮箱及已核对的 GitHub 账号；未核实的学术与社交主页链接暂不显示。其余原始模板页面、各集合示例、示例 PDF 和报告地图共 43 个文件已移至 `_template_archive/`，不能把其中的学历、论文、任职、个人账号或日期当作用户真实资料，也不能凭空补写。
- 导航目前只保留 `About` 和 `Contact`。没有真实内容的栏目不显示，也不生成其原模板页面；当前有效页面为首页、站点地图及 404 页。`_pages/sitemap.md` 跟随导航列出有效入口，`sitemap.txt` 不再包含示例简历地址。
- 新栏目应先在原内容目录中新增经确认的真实资料，再更新 `_data/navigation.yml`。不要直接恢复整批模板；添加真实博客后再按需将 `atom_feed.hide` 改为 `false`。当前订阅链接已隐藏，空订阅文件不含示例文章。
- 仅处理当次请求范围；模板清理、改版和依赖升级按实际需要进行，不因下载项目而自动执行。
- `_config.yml` 当前 `future: true`；远期示例文章已归档，但新增未来日期文章仍可能立即显示。私人草稿不要放入会发布的目录。
- 发布日期与定时内容需核对站点时区；初始配置为 `America/Los_Angeles`，与用户使用的北京时间不同。不要默默改写历史日期。
- 本地临时资料可放 `tmp/`（已在站点生成排除列表中）；提交前另查 Git 状态，站点排除不等于 Git 忽略。
- 保留现有许可、搜索验证文件及用户图片；不覆盖源文件或批量删除已有内容。
- `AGENTS.md` 已加入 `_config.yml` 的 `exclude`，避免作为网站文件发布；这不代表它在公开 Git 仓库中保密，不要写入密码、令牌或私人信息。

## 本地预览与构建

普通页面修改使用 Ruby/Bundler/Jekyll。`package.json` 中的 npm 命令仅用于 JavaScript 合并压缩，不是站点启动命令。

2026-10-27 已配置 Ruby+Devkit 3.3.12、Bundler 2.5.22 和项目依赖（Jekyll 3.10.0、github-pages 232）。Ruby 位于 `%LOCALAPPDATA%\Programs\Ruby33-x64\`，依赖安装到本项目的 `vendor/bundle/`；`.bundle/config` 保存本地依赖路径。后续会话先检查实际环境，不重复安装已满足的依赖。

推荐使用项目启动脚本，它会查找 Ruby 并处理 UTF-8，无需为当前尚未刷新 PATH 的终端重启应用。详细操作见 `README.md`：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\preview.ps1
# 只构建：在上述命令末尾加 -Build；换端口：加 -Port 4001。
```

在项目根目录执行：

```powershell
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve --host 127.0.0.1
```

默认在浏览器使用 `http://localhost:4000/`，与 Jekyll 生成的资源链接保持同源；已确认直接使用 `127.0.0.1` 打开页面会使字体图标显示异常。服务仍只监听 `127.0.0.1`。修改 `_config.yml` 后需重启预览服务。

需要检查静态生成时执行：

```powershell
bundle exec jekyll build
```

- `Gemfile` 使用 `github-pages` 和 `webrick`，Windows 下还需 `wdm ~> 0.2.0`、`tzinfo` 和 `tzinfo-data`。旧版 `wdm 0.1.1` 已实际出现原生扩展编译错误，因此升级了该 Windows 依赖；时区数据用于解析现有的 `America/Los_Angeles` 配置。不要直接升级全部依赖或删除声明。
- `.gitignore` 已忽略 `_site/`、`local/`、`Gemfile.lock`、`node_modules`、`package-lock.json`、`.bundle/`、`vendor/bundle/`、Jekyll 缓存和 `tmp/`。不要把生成目录当作页面源码修改，也不要用缺失的锁文件执行 `npm ci`。
- `AGENTS.md`、`README.md`、`preview.ps1`、`local/`、`_template_archive/`、`CONTRIBUTING.md`、`markdown_generator/` 及根目录 `talkmap.py`、`talkmap.ipynb` 均已从站点生成内容中排除；临时日志和进程记录可放 `local/`，不纳入提交。
- 只有改动 JavaScript 源码且需要更新发布产物时，才运行 `npm install` 和 `npm run build:js`，并核对 `assets/js/main.min.js` 的差异。可用 `npm run watch:js` 监听脚本修改。
- 没有现成的自动化测试命令。内容或样式修改应按影响范围检查构建、相关页面、导航、图片与附件链接；布局变化还需查看窄屏效果。无法构建或预览时，明确说明实际完成的检查及限制。

## Git 与发布

- 日常本地修改保留为可审查的工作区差异。只有用户明确要求提交、推送或发布时，才执行对应操作；已有明确授权时不重复确认。
- 发布前核对仓库 GitHub Pages 的实际来源分支和路径或工作流，并查看构建结果；仅凭本地 `main` 分支不能确认线上发布设置。
- 本次下载的 `.github/` 只有 issue 模板，没有站点部署工作流；不要擅自新增部署流程。
- `package.json` 和 `CONTRIBUTING.md` 中的上游 Academic Pages 仓库链接及 `master` 描述属于模板信息，不是本项目的推送目标或当前分支依据。
- 提交前查看差异，检查临时文件、私人资料和无关改动。不要强制推送、重置用户改动或更换 `origin`。
- 完成修改后说明改了什么、检查了什么，以及是否已提交或发布；需要发布验证时检查真实网站，不把本地构建成功等同于线上已更新。
