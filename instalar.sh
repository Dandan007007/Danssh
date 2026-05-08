#!/bin/bash
# INSTALADOR DANSSH NET
apt update && apt upgrade -y
apt install python3 stunnel4 screen bwrap at -y
wget https://raw.githubusercontent.com/Dandan007007/Danssh/main/danssh.sh -O /usr/bin/danssh
chmod +x /usr/bin/danssh
echo "clear" >> ~/.bashrc
echo "danssh" >> ~/.bashrc
echo "INSTALAÇÃO CONCLUÍDA! Digite danssh para abrir."
