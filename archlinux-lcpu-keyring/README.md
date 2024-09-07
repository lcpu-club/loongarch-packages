# archlinux-lcpu Community Repository Packager PGP Keyring

* [中文版本](#archlinux-lcpu-社区源打包者-pgp-keyring)

This repository contains the PGP keyring for Arch Linux LCPU community repository packagers.

## archlinux-lcpu Packagers

To add a new key, please submit a PR following these steps:

1. Submit your public key to a public keyserver, ensuring that `gpg --keyserver --recv-keys <fingerprint>` can retrieve your public key.
2. Add your public key fingerprint to `master-keyids` in the following format:
```
<fingerprint>    <username>    <keyserver>
```
3. Run the following commands:
```bash
updpkgsums
makepkg
makepkg --printsrcinfo > .SRCINFO
```
   * Ensure that your public key can be retrieved and that a `<username>.asc` file containing your public key is created in the `src/master` directory.
1. In your commit, make sure that `master-keyids` includes your fingerprint and **also** includes modifications to both `PKGBUILD` and `.SRCINFO`

# archlinux-lcpu 社区源打包者 PGP keyring

* [English Version](#archlinux-lcpu-community-repository-packager-pgp-keyring)

这里存放 Arch Linux LCPU 社区源打包者 PGP keyring

## archlinux-lcpu 打包者

如需添加新 key ，请按照以下方式提出 PR ：

1. 将您的 pubkey 提交到某个公开的 keyserver ，确保 `gpg --keyserver --recv-keys <fingerprint>` 可接收到您的 pubkey 。
2. 将您的 pubkey fingerprint 填入 master-keyids ，格式为
```
<fingerprint>    <username>    <keyserver>
```
3. 执行：
```bash
updpkgsums
makepkg
makepkg --printsrcinfo > .SRCINFO
```
   * 确保能接收到您的 pubkey ，在 `src/master` 文件夹创建了含有您用户名的 `<username>.asc` 的 pubkey 。
4. 在 commit 中确保 master-keyids 包含了您的 fingerprint，且**务必**同时包含对于 `PKGBUILD` 和 `.SRCINFO` 的修改。
