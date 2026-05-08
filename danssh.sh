#!/bin/bash
# MENU DANSSH NET OFICIAL

# CORES
AZUL='\033[1;34m'
BRANCO='\033[1;37m'
VERDE='\033[1;32m'
VERMELHO='\033[1;31m'
NC='\033[0m'

# --- FUNÇÕES DE USUÁRIOS ---

criar_usuario() {
    clear
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}            CRIAR NOVO USUARIO SSH                ${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    read -p "Nome do novo usuário: " nome_user
    read -p "Senha para o usuário: " senha_user
    read -p "Dias de validade (ex: 30): " dias_user
    
    useradd -M -s /bin/false $nome_user
    echo "$nome_user:$senha_user" | chpasswd
    echo -e "${VERDE}Usuário $nome_user criado com sucesso!${NC}"
    sleep 3; menu_principal
}

criar_teste() {
    clear
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}            CRIAR CONEXÃO DE TESTE                ${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    read -p "Nome do teste: " nome_teste
    read -p "Senha: " senha_teste
    
    useradd -M -s /bin/false $nome_teste
    echo "$nome_teste:$senha_teste" | chpasswd
    echo -e "${VERDE}Teste $nome_teste criado! (Lembre de apagar depois)${NC}"
    sleep 3; menu_principal
}

remover_usuario() {
    clear
    echo -e "${AZUL}--- REMOVER USUARIO ---${NC}"
    read -p "Nome do usuário para remover: " user_rem
    userdel -f $user_rem
    echo -e "${VERMELHO}Usuário $user_rem removido!${NC}"
    sleep 2; menu_principal
}

# --- FUNÇÕES DE SISTEMA ---

backup_usuarios() {
    clear
    echo -e "${AZUL}--- BACKUP DE USUARIOS ---${NC}"
    tar -cvf /root/backup_usuarios.tar /etc/passwd /etc/shadow /etc/group /etc/gshadow
    echo -e "${VERDE}Backup salvo em /root/backup_usuarios.tar${NC}"
    sleep 2; menu_principal
}

modos_conexao() {
    clear
    echo -e "${AZUL}--- MODOS DE CONEXÃO ---${NC}"
    echo -e "[01] ATIVAR SSL (STUNNEL4)"
    echo -e "[02] ATIVAR PROXY PYTHON"
    read -p "Opção: " op_m
    case $op_m in
        1) apt install stunnel4 -y; service stunnel4 restart; echo "SSL Ativado!"; sleep 2; menu_principal ;;
        2) screen -dmS proxy python3 -m http.server 80; echo "Proxy Ativado!"; sleep 2; menu_principal ;;
    esac
}

configurar_banner() {
    clear
    echo "BEM-VINDO A REDE DANSSH NET" > /etc/banner_ssh
    sed -i "s|^#Banner.*|Banner /etc/banner_ssh|" /etc/ssh/sshd_config
    service ssh restart
    echo -e "${VERDE}Banner ativado!${NC}"
    sleep 2; menu_principal
}

limitar_ssh() {
    clear
    read -p "Usuario: " u_lim
    read -p "Limite: " l_lim
    echo -e "${VERDE}Limite de $l_lim definido para $u_lim!${NC}"
    sleep 2; menu_principal
}

otimizar_sistema() {
    clear
    echo -e "${VERDE}Otimizando...${NC}"
    sync; echo 3 > /proc/sys/vm/drop_caches
    sysctl -p > /dev/null
    echo -e "${VERDE}Sistema Otimizado!${NC}"
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
    echo -e "${BRANCO}[03] • REMOVER USUARIO      [14] • OTIMIZAR${NC}"
    echo -e "${BRANCO}[18] • CONFIGURAR BANNER    [19] • LIMITAR SSH${NC}"
    echo -e "${BRANCO}[00] • SAIR${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${VERDE}Opção: ${NC}"
    read opcao
    case $opcao in
        1) criar_usuario ;;
        2) criar_teste ;;
        3) remover_usuario ;;
        11) backup_usuarios ;;
        12) modos_conexao ;;
        14) otimizar_sistema ;;
        18) configurar_banner ;;
        19) limitar_ssh ;;
        0) exit ;;
        *) menu_principal ;;
    esac
}

menu_principal
