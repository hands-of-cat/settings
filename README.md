# 単なる自分の設定メモです。

1 キーレイアウトの変更
メニューから、Settings -> Keyboard を選択
 Layout タブを選択
  - Use system defaults のチェックを外す
  - Keyboard layout で、Japanese を追加し、English を削除する

2 タイムゾーンの変更
 時刻のところで右クリックして、Clock の設定画面を開く
  - Timezone: に Japan を設定

3. VPN の設定
 Dashboard の Access を選択
  - connection pack をダウンロード
  - sudo openvpn jirocat.ovpn をターミナルで実行
  
  「2021-01-23 07:09:41 Initialization Sequence Completed」となれば成功

4. ネットワークの確認
 ifconfig tun0 を実行
  - ネットワークを確認
  「inet 10.10.14.79  netmask 255.255.254.0  destination 10.10.14.79」

5. Kali Linux のパッケージ更新とツールのインストール
 パッケージ最新化
 - sudo apt update && sudo apt full-upgrade -y
 VMTool のインストール
 - sudo apt install -y --reinstall open-vm-tools-desktop fuse

6. 共有フォルダの設定
 -Kali Linux 上 /mnt/hgfs/OffsecVM
 -ホスト上 /home/$USER/vmshare

7. 共有フォルダマウントスクリプト作成

#!/bin/bash

vmware-hgfsclient | while read folder; do

  echo "[i] Mounting ${folder}   (/mnt/hgfs/${folder})"
  
  mkdir -p "/mnt/hgfs/${folder}"
  
  umount -f "/mnt/hgfs/${folder}" 2>/dev/null
  
  vmhgfs-fuse -o allow_other -o auto_unmount ".host:/${folder}" "/mnt/hgfs/${folder}"

done

sleep 2s

ショートカットの作成

 ln -s /mnt/hgfs/OffsecVM $HOME/OffsecVM


