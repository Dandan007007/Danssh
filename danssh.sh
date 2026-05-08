#!/bin/bash
# MENU DANSSH NET OFICIAL

# CORES
AZUL='\033[1;34m'
BRANCO='\033[1;37m'
VERDE='\033[1;32m'
VERMELHO='\033[1;31m'
NC='\033[0m'

# --- FUNÇÕES DE SUPORTE ---

backup_usuarios() {
    clear
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}           SISTEMA DE BACKUP DANSSH               ${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}[01] • CRIAR NOVO BACKUP${NC}"
    echo -e "${BRANCO}[02] • RESTAURAR BACKUP${NC}"
    echo -e "${BRANCO}[00] • VOLTAR${NC}"
    echo -ne "${VERDE}Opção: ${NC}"
    read opc_backup
    case $opc_backup in
        1) tar -cvf /root/backup_usuarios.tar /etc/passwd /etc/shadow /etc/group /etc/gshadow; sleep 2; backup_usuarios ;;
        2) tar -xvf /root/backup_usuarios.tar -C /; sleep 2; backup_usuarios ;;
        0) menu_principal ;;
    esac
}

modos_conexao() {
    clear
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}            MODOS DE CONEXÃO DANSSH               ${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}[01] • ATIVAR SSL (STUNNEL4)${NC}"
    echo -e "${BRANCO}[02] • ATIVAR PROXY PYTHON (WS)${NC}"
    echo -e "${BRANCO}[00] • VOLTAR${NC}"
    echo -ne "${VERDE}Opção: ${NC}"
    read opc_modos
    case $opc_modos in
        1) apt install stunnel4 -y; sleep 2; modos_conexao ;;
        2) screen -dmS proxy python3 -m http.server 80; sleep 2; modos_conexao ;;
        0) menu_principal ;;
    esac
}

# --- MENU PRINCIPAL ---

menu_principal() {
    clear
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO} SISTEMA: Ubuntu 20.04   MARCA: DANSSH NET        ${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}[01] • CRIAR USUARIO        [11] • BACKUP USUARIOS${NC}"
    echo -e "${BRANCO}[02] • CRIAR TESTE          [12] • MODOS CONEXAO${NC}"
    echo -e "${BRANCO}[00] • SAIR${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${VERDE}Opção: ${NC}"
    read opcao
    case $opcao in
        1) echo "Criar usuário..."; sleep 2; menu_principal ;;
        11) backup_usuarios ;;
        12) modos_conexao ;;
        0) exit ;;
        *) menu_principal ;;
    esac
}

menu_principal
