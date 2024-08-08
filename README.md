# Arch Linux Loongarch Patches

This repository contains patches for Loong Arch Linux packages. These patches are used to provide support for the Loongarch64 architecture in Arch Linux.

中文说明从[这里](#arch-linux-loongarch-补丁集)开始。

## Folder hierarchy

Packages are maintained as patches to x86_64 Arch Linux packages. The folder hierarchy is as follows:

```
<package-name>
├── spec # spec file to define the package
├── loong.patch # The patch file to existing package
├── patches # optional, Folder containing new patches for the package, they will be copied to patches folder of the package
│   ├── 0001-<patch-name>.patch # all patches should be named in this format
|   └── ... 
├── files # optional, Folder containing files to be copied to the package directory directly
```

The upstream packages can be found at `https://gitlab.archlinux.org/archlinux/packaging/packages/<package-name>`.

## Spec structure

`spec` is a bash script that defines the package. It should contain the following variables:

- `VER`: required, upstream git hash (at least 8 characters) or `SKIP` if the package is not upstreamed
- `REL`: required, release number for loongarch64. Origin package's release number will be merged into package version like `1.2.3-4` -> `1.2.3+v4`
- `ENVREQ`: optional, space separated list of builder machine requirements. See `https://github.com/lcpu-club/lcpu-buildit/blob/master/DESIGN.md` for available options


## Commit and PR requirements

- The commit message should be in the format `package-name: version description`. Each commit should only contain changes to a single package.
- Branch to be used for PR should be named as `theme-version-description`.
- The PR cloud contain a set of commits, each commit should be a patch to a single package. Packages will be built in the order of commits in the PR by default, unless specified otherwise in the PR description.

## Artifacts and logs download

- Artifacts of single commit and branches not for PR can be download as `https://loong-pkgs.lcpu.dev/branch/<branch-name>/<pkgname>-<pkgver>-<pkgrel>-<arch>-<commit-hash>.tar.xz`, and logs can be download as `https://loong-pkgs.lcpu.dev/branch/<branch-name>/build-<unix-time-stamp>.log`.
- Artifacts of PR can be download as `https://loong-pkgs.lcpu.dev/pr/<pr-number>/<pkgname>-<pkgver>-<pkgrel>-<arch>-<commit-hash>.tar.xz`, and logs can be download as `https://loong-pkgs.lcpu.dev/pr/<pr-number>/build-<unix-time-stamp>.log`.


# Arch Linux Loongarch 补丁集

本仓库包含了 Loong Arch Linux 包的补丁，以 patch 的方式，为 Arch Linux 提供 Loongarch64 架构支持。

## 文件夹层次

包以 x86_64 Arch Linux 包的补丁形式维护。文件夹层次如下：

```
<包名>
├── spec # 定义包的 spec 文件
├── loong.patch # 为现有包提供的补丁文件
├── patches # 可选，包含包的新补丁的文件夹，这些补丁将被复制到包的 patches 文件夹中
│   ├── 0001-<补丁名>.patch # 所有补丁应以此格式命名
|   └── ... 
├── files # 可选，包含要直接复制到包目录的文件的文件夹
```

对于上游包，都可以在`https://gitlab.archlinux.org/archlinux/packaging/packages/<package-name>`找到。

## spec 结构

`spec` 是一个 bash 脚本，用于定义包。它应包含以下变量：

- `VER`：必需，上游 git hash（至少 8 个字符）或 `SKIP`，如果包没有上游化
- `REL`：必需，loongarch64 的发布号。原始包的发布号将合并到包版本中，如 `1.2.3-4` -> `1.2.3+v4`
- `ENVREQ`：可选，构建机器要求的空格分隔列表。有关可用选项，请参见 `https://github.com/lcpu-club/lcpu-buildit/blob/master/DESIGN.md`

## 提交和 PR 要求

- 提交消息应为 `package-name: version description` 格式。每个提交应仅包含对单个包的更改。
- 用于 PR 的分支应命名为 `theme-version-description`。
- PR 应包含一组提交，每个提交应是对单个包的补丁。默认情况下，将按 PR 描述中的顺序构建提交中的包，也可以在 PR 描述中另行指定。

## 下载构建完成的包和日志

- 单个提交和非 PR 的分支的构建完成的包可以在 `https://loong-pkgs.lcpu.dev/branch/<branch-name>/<pkgname>-<pkgver>-<pkgrel>-<arch>-<commit-hash>.tar.xz`下载，日志可以在 `https://loong-pkgs.lcpu.dev/branch/<branch-name>/build-<unix-time-stamp>.log`下载。
- PR 的构建完成的包可以在 `https://loong-pkgs.lcpu.dev/pr/<pr-number>/<pkgname>-<pkgver>-<pkgrel>-<arch>-<commit-hash>.tar.xz`下载，日志可以在 `https://loong-pkgs.lcpu.dev/pr/<pr-number>/build-<unix-time-stamp>.log`下载。

