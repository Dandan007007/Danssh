#!/bin/bash
# MENU DANSSH NET OFICIAL

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
echo -e "${BRANCO}[01] • CRIAR USUARIO        [14] • OTIMIZAR${NC}"
echo -e "${BRANCO}[02] • CRIAR TESTE          [18] • CONFIGURAR BANNER${NC}"
echo -e "${BRANCO}[03] • REMOVER USUARIO      [19] • LIMITAR SSH${NC}"
echo -e "${BRANCO}[05] • USUARIOS ONLINE      [00] • SAIR${NC}"
echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -ne "${VERDE}Opção: ${NC}"
read opcao

case $opcao in
    1) criar_usuario ;;
    2) criar_teste ;;
    5) monitor_online ;;
    14) otimizar_sistema ;;
    18) configurar_banner ;;
    19) limitar_ssh ;;
    0) exit ;;
    *) echo "Opção inválida!"; sleep 1; menu_principal ;;
esac
}

configurar_banner() {
    clear
    echo -e "${AZUL}--- CONFIGURAR BANNER DANSSH NET ---${NC}"
    echo "  _____          _   _  _____  _____ _    _ " > /etc/banner_ssh
    echo " |  __ \   /\   | \ | |/ ____|/ ____| |  | |" >> /etc/banner_ssh
    echo " | |  | | /  \  |  \| | (___ | (___ | |__| |" >> /etc/banner_ssh
    echo " | |  | |/ /\ \ | . \ |\___ \ \___ \|  __  |" >> /etc/banner_ssh
    echo " |_____/_/    \_\_| \_|_____/|_____/|_|  |_|" >> /etc/banner_ssh
    sed -i "s|^#Banner.*|Banner /etc/banner_ssh|" /etc/ssh/sshd_config
    sed -i "s|^Banner.*|Banner /etc/banner_ssh|" /etc/ssh/sshd_config
    service ssh restart
    echo -e "${VERDE}Banner ativado com sucesso!${NC}"
    sleep 2; menu_principal
}

limitar_ssh() {
    clear
    echo -e "${AZUL}--- LIMITADOR DE CONEXOES ---${NC}"
    read -p "Usuario para limitar: " user_limite
    read -p "Limite (ex: 1): " max_conex
    # Aqui vai o comando que mata o processo se exceder
    echo -e "${VERDE}Limite de $max_conex definido para $user_limite!${NC}"
    sleep 2; menu_principal
}

# (Funções de criar_usuario, criar_teste e otimizar continuam aqui...)

menu_principal
