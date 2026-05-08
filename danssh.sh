#!/bin/bash
# MENU PRINCIPAL DANSSH NET

# CORES
AZUL='\033[1;34m'
BRANCO='\033[1;37m'
VERDE='\033[1;32m'
VERMELHO='\033[1;31m'
NC='\033[0m'

menu_principal() {
clear
echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BRANCO} SISTEMA: Ubuntu 20.04   MARCA: DANSSH NET        ${NC}"
echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BRANCO}[01] • CRIAR USUARIO        [11] • BACKUP USUARIOS${NC}"
echo -e "${BRANCO}[02] • CRIAR TESTE          [12] • MODOS CONEXAO${NC}"
echo -e "${BRANCO}[03] • REMOVER USUARIO      [13] • SPEEDTEST${NC}"
echo -e "${BRANCO}[04] • RENOVAR USUARIO      [14] • OTIMIZAR${NC}"
echo -e "${BRANCO}[05] • USUARIOS ONLINE      [00] • SAIR${NC}"
echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -ne "${VERDE}Opção: ${NC}"
read opcao

case $opcao in
    1) criar_usuario ;;
    2) criar_teste ;;
    14) otimizar_sistema ;;
    0) exit ;;
    *) echo "Opção inválida!"; sleep 1; menu_principal ;;
esac
}

criar_usuario() {
    clear
    echo -e "${AZUL}--- CRIAR USUARIO DANSSH ---${NC}"
    read -p "Nome do usuario: " usuario
    read -p "Senha: " senha
    useradd -M -s /bin/false $usuario
    echo "$usuario:$senha" | chpasswd
    echo -e "${VERDE}Usuario $usuario criado com sucesso!${NC}"
    sleep 2
    menu_principal
}

criar_teste() {
    clear
    echo -e "${AZUL}--- CRIAR TESTE (30 MIN) ---${NC}"
    read -p "Nome do teste: " usertest
    read -p "Senha: " passtest
    useradd -M -s /bin/false $usertest
    echo "$usertest:$passtest" | chpasswd
    echo "userdel -f $usertest" | at now + 30 minutes
    echo -e "${VERDE}Teste $usertest criado! Expira em 30 min.${NC}"
    sleep 2
    menu_principal
}

otimizar_sistema() {
    echo -e "${VERDE}Otimizando...${NC}"
    sync; echo 3 > /proc/sys/vm/drop_caches
    apt-get autoclean -y
    sleep 2
    menu_principal
}

menu_principal

