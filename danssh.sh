#!/bin/bash
# PAINEL DANSSH NET - SSHPLUS MANAGER PRO

# Cores
VERMELHO='\033[1;31m'
VERDE='\033[1;32m'
AMARELO='\033[1;33m'
AZUL='\033[1;34m'
MAGENTA='\033[1;35m'
CIANO='\033[1;36m'
BRANCO='\033[1;37m'
NC='\033[0m'

menu_principal() {
    clear
    # Cabeçalho identico à foto
    echo -e "${VERMELHO} ┌──────────────────────────────────────────────────┐${NC}"
    echo -e "${VERMELHO} │${NC}${BRANCO}            🚀 SSHPLUS MANAGER PRO 🚀             ${NC}${VERMELHO}│${NC}"
    echo -e "${VERMELHO} └──────────────────────────────────────────────────┘${NC}"
    echo -e "${AZUL} SISTEMA: Ubuntu 20.04   MEMORIA RAM: 1.9 GB${NC}"
    echo -e "${AZUL} Hora: $(date +%H:%M:%S)         Processador: 2 Núcleos${NC}"
    echo -e "${VERMELHO} Onlines: 0             Expirados: 0          Total: 9${NC}"
    echo -e "${AZUL} ┌──────────────────────────────────────────────────┐${NC}"
    
    # Opções do Menu
    echo -e " ${AZUL}[01]${NC} • CRIAR USUARIO        ${AZUL}[13]${NC} • SPEEDTEST"
    echo -e " ${AZUL}[02]${NC} • CRIAR TESTE          ${AZUL}[14]${NC} • OTIMIZAR"
    echo -e " ${AZUL}[03]${NC} • REMOVER USUARIO      ${AZUL}[15]${NC} • TRAFEGO"
    echo -e " ${AZUL}[04]${NC} • RENOVAR USUARIO      ${AZUL}[16]${NC} • FIREWALL"
    echo -e " ${AZUL}[05]${NC} • USUARIOS ONLINE      ${AZUL}[17]${NC} • INFO SISTEMA"
    echo -e " ${AZUL}[06]${NC} • ALTERAR DATA         ${AZUL}[18]${NC} • BANNER        ${VERMELHO}o${NC}"
    echo -e " ${AZUL}[07]${NC} • ALTERAR LIMITE       ${AZUL}[19]${NC} • LIMITAR SSH   ${VERMELHO}o${NC}"
    echo -e " ${AZUL}[08]${NC} • ALTERAR SENHA        ${AZUL}[20]${NC} • BADVPN        ${VERDE}•${NC}"
    echo -e " ${AZUL}[09]${NC} • REMOVER EXPIRADOS    ${AZUL}[21]${NC} • AUTO MENU     ${VERDE}•${NC}"
    echo -e " ${AZUL}[10]${NC} • RELATORIO USUARIOS   ${AZUL}[22]${NC} • CHATBOTS      ${VERMELHO}o${NC}"
    echo -e " ${AZUL}[11]${NC} • BACKUP USUARIOS      ${AZUL}[23]${NC} • MAIS OPCOES   ${AZUL}→${NC}"
    echo -e " ${AZUL}[12]${NC} • MODOS DE CONEXAO     ${AZUL}[00]${NC} • SAIR DO MENU"
    echo -e "${AZUL} └──────────────────────────────────────────────────┘${NC}"
    echo -ne "${VERDE} INFORME UMA OPCAO: ${NC}"
    read opcao

    case $opcao in
        12) 
           echo -e "\n${VERDE}Iniciando Proxy WebSocket...${NC}"
           wget -q https://raw.githubusercontent.com/Dandan007007/Danssh/main/proxy.py -O /etc/proxy.py
           screen -dmS proxy python3 /etc/proxy.py
           echo -e "${VERDE}Proxy Online na Porta 80!${NC}"
           sleep 2; menu_principal ;;
        00) exit ;;
        *) echo -e "\n${VERMELHO}Opção em desenvolvimento...${NC}"; sleep 2; menu_principal ;;
    esac
}

menu_principal
