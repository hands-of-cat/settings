# 単なる自分の設定メモです。

1 キーレイアウトの変更
メニューから、Settings -> Keyboard を選択
 Layout タブを選択
  - Use system defaults のチェックを外す
  - Keyboard layout で、Japanese を追加し、English を削除する

2 タイムゾーンの変更
 時刻のところで右クリックして、Clock の設定画面を開く
  - Timezone: に Japan を設定

3 VPN の設定
 Dashboard の Access を選択
  - connection pack をダウンロード
  - sudo openvpn jirocat.ovpn をターミナルで実行
  
  「2021-01-23 07:09:41 Initialization Sequence Completed」となれば成功

4 ネットワークの確認
 ifconfig tun0 を実行
  - ネットワークを確認
  「inet 10.10.14.79  netmask 255.255.254.0  destination 10.10.14.79」

5 Kali Linux のパッケージ更新とツールのインストール
 パッケージ最新化
 - sudo apt update && sudo apt full-upgrade -y
 VMTool のインストール
 - sudo apt install -y --reinstall open-vm-tools-desktop fuse

6 共有フォルダの設定
 -Kali Linux 上 /mnt/hgfs/OffsecVM
 -ホスト上 /home/$USER/vmshare

7 共有フォルダマウントスクリプト作成

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

8 インストールソフトウェア
 sudo apt install -y --reinstall open-vm-tools-desktop fuse<BR>
 sudo apt-get install gobuster<BR>
 sudo apt-get install ffuf<BR>
 sudo apt-get install goWART<BR>
 sudo apt-get install gowart<BR>
 sudo apt-get install wfuzz<BR>
 sudo apt-get install seclists<BR>
 sudo apt-get install gowapt<BR>
 sudo apt-get install steghide<BR>
 sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -<BR>
 sudo apt-get install google-chrome<BR>
 sudo apt install seclists curl enum4linux gobuster nbtscan nikto nmap onesixtyone oscanner smbclient smbmap smtp-user-enum snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf<BR>
 pipx install git+https://github.com/Tib3rius/AutoRecon.git<BR>
 sudo apt install pythen3-pip<BR>
 sudo apt install python3-venv<BR>
 python3 -m pip install --user pipx<BR>
 sudo apt install -y ufw<BR>
 
9 ufw の設定<BR>
vi /etc/sysctl.conf<BR>
 net.ipv4.ip_forward=1<BR>

 sudo ufw enable<BR>
 sudo ufw default deny outgoing<BR>
 sudo ufw allow in 1194<BR>
 sudo ufw allow out 1194<BR>
 sudo ufw allow in on tun0<BR>
 sudo ufw allow out on tun0<BR>

 /etc/default/ufw<BR>
 vim /etc/default/ufw<BR>
 
 vim /etc/ufw/before.rules<BR>
 \# STARTOPEN VPN RULE<BR>
 \# NAT table rules<BR>
 *nat<BR>
 \:POSTROUTING ACCEPT [0:0]<BR>
 \# Allow traffic from OpenVPN client to eth0<BR>
 -A POSTROUTING -s 10.8.0.0/8 -o eth0 -j MASQUERADE<BR>
 COMMIT<BR>
 \# END OPNVPN RULES<BR>




