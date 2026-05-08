#!/bin/bash
# PAINEL PERSONALIZADO - DANSSH NET

# Cores
VERMELHO='\033[1;31m'
VERDE='\033[1;32m'
AZUL='\033[1;34m'
BRANCO='\033[1;37m'
NC='\033[0m'

menu_principal() {
    clear        12) 
           clear
           echo -e "${VERDE}Iniciando Proxy WebSocket na Porta 80...${NC}"
           # Baixa o seu proxy.py que já está corrigido no GitHub
           wget -q https://raw.githubusercontent.com/Dandan007007/Danssh/main/proxy.py -O /etc/proxy.py
           
           # Mata qualquer coisa que esteja usando a porta 80 (como o Apache)
           fuser -k 80/tcp > /dev/null 2>&1
           
           # Inicia o proxy em segundo plano
           screen -dmS proxy python3 /etc/proxy.py
           
           echo -e "${VERDE}Conexão liberada! Tente conectar no aplicativo agora.${NC}"
           sleep 3; menu_principal ;;

    # Aqui é onde você muda o nome do topo
    echo -e "${VERMELHO} ┌──────────────────────────────────────────────────┐${NC}"
    echo -e "${VERMELHO} │${NC}${BRANCO}             🚀 DANSSH NET MANAGER 🚀             ${NC}${VERMELHO}│${NC}"
    echo -e "${VERMELHO} └──────────────────────────────────────────────────┘${NC}"
    
    # Informações do Sistema
    echo -e "${AZUL} SISTEMA: Ubuntu 20.04   MEMORIA RAM: 1.9 GB${NC}"
    echo -e "${AZUL} Hora: $(date +%H:%M:%S)         Processador: 2 Núcleos${NC}"
    echo -e "${VERMELHO} Onlines: 0             Expirados: 0          Total: 9${NC}"
    echo -e "${AZUL} ┌──────────────────────────────────────────────────┐${NC}"
    
    # Opções do Menu (conforme sua foto)
    echo -e " ${VERDE}[01]${NC} • CRIAR USUARIO        ${VERDE}[13]${NC} • SPEEDTEST"
    echo -e " ${VERDE}[02]${NC} • CRIAR TESTE          ${VERDE}[14]${NC} • OTIMIZAR"
    echo -e " ${VERDE}[03]${NC} • REMOVER USUARIO      ${VERDE}[15]${NC} • TRAFEGO"
    echo -e " ${VERDE}[12]${NC} • MODOS DE CONEXAO     ${VERDE}[00]${NC} • SAIR DO MENU"
    echo -e "${AZUL} └──────────────────────────────────────────────────┘${NC}"
    echo -ne "${VERDE} INFORME UMA OPCAO: ${NC}"
    read opcao

    case $opcao in
        12) 
           # Baixa o proxy.py que você já salvou
           wget -q https://raw.githubusercontent.com/Dandan007007/Danssh/main/proxy.py -O /etc/proxy.py
           screen -dmS proxy python3 /etc/proxy.py
           echo -e "${VERDE}Proxy Ativado!${NC}"; sleep 2; menu_principal ;;
        00) exit ;;
        *) menu_principal ;;
    esac
}

menu_principal
