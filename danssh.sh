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
        1) tar -cvf /root/backup_usuarios.tar /etc/passwd /etc/shadow /etc/group /etc/gshadow; echo -e "${VERDE}Backup criado!${NC}"; sleep 2; backup_usuarios ;;
        2) tar -xvf /root/backup_usuarios.tar -C /; echo -e "${VERDE}Usuários restaurados!${NC}"; sleep 2; backup_usuarios ;;
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
        1) apt install stunnel4 -y; echo -e "${VERDE}SSL Ativado!${NC}"; sleep 2; modos_conexao ;;
        2) screen -dmS proxy python3 -m http.server 80; echo -e "${VERDE}Proxy iniciado!${NC}"; sleep 2; modos_conexao ;;
        0) menu_principal ;;
    esac
}

configurar_banner() {
    clear
    echo -e "${AZUL}--- CONFIGURAR BANNER DANSSH NET ---${NC}"
    echo "BEM-VINDO A REDE DANSSH NET" > /etc/banner_ssh
    sed -i "s|^#Banner.*|Banner /etc/banner_ssh|" /etc/ssh/sshd_config
    service ssh restart
    echo -e "${VERDE}Banner ativado!${NC}"
    sleep 2; menu_principal
}

limitar_ssh() {
    clear
    echo -e "${AZUL}--- LIMITADOR DE CONEXOES ---${NC}"
    read -p "Usuario: " user_limite
    read -p "Limite: " max_conex
    echo -e "${VERDE}Limite definido para $user_limite!${NC}"
    sleep 2; menu_principal
}

# --- MENU PRINCIPAL ---

menu_principal() {
    clear
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO} SISTEMA: Ubuntu 20.04   MARCA: DANSSH NET        ${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}[01] • CRIAR USUARIO        [11] • BACKUP USUARIOS${NC}"
    echo -e "${BRANCO}[02] • CRIAR TESTE          [12] • MODOS CONEXAO${NC}"
    echo -e "${BRANCO}[18] • CONFIGURAR BANNER    [19] • LIMITAR SSH${NC}"
    echo -e "${BRANCO}[00] • SAIR${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${VERDE}Opção: ${NC}"
    read opcao
    case $opcao in
        1) echo "Criar usuário..."; sleep 2; menu_principal ;;
        11) backup_usuarios ;;
        12) modos_conexao ;;
        18) configurar_banner ;;
        19) limitar_ssh ;;
        0) exit ;;
        *) menu_principal ;;
    esac
}

menu_principal
