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
    echo -e "${BRANCO}[01] • CRIAR USUARIO        [11] • BACKUP USUARIOS${NC}"
    echo -e "${BRANCO}[02] • CRIAR TESTE          [12] • MODOS CONEXAO${NC}"
    echo -e "${BRANCO}[14] • OTIMIZAR SISTEMA     [00] • SAIR${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${VERDE}Opção: ${NC}"
    read opcao
    case $opcao in
        1) echo "Criando usuário..."; sleep 2; menu_principal ;;
        2) echo "Criando teste..."; sleep 2; menu_principal ;;
        12) 
           echo -e "${VERDE}Iniciando Proxy...${NC}"
           wget -q https://raw.githubusercontent.com/Dandan007007/Danssh/main/proxy.py -O /etc/proxy.py
           screen -dmS proxy python3 /etc/proxy.py
           echo -e "${VERDE}Proxy Online!${NC}"
           sleep 2; menu_principal ;;
        0) exit ;;
        *) menu_principal ;;
    esac
}
menu_principal
