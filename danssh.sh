#!/bin/bash
# MENU DANSSH NET OFICIAL

# CORES
AZUL='\033[1;34m'
BRANCO='\033[1;37m'
VERDE='\033[1;32m'
VERMELHO='\033[1;31m'
NC='\033[0m'

# --- FUNÇÕES DE USUÁRIOS ---
import socket, threading, select

def handler(clientsock, addr):
    try:
        data = clientsock.recv(1024).decode('utf-8', errors='ignore')
        if not data: return
        # Resposta 101 necessária para Websocket
        clientsock.send(b'HTTP/1.1 101 Switching Protocols\r\nUpgrade: websocket\r\nConnection: Upgrade\r\n\r\n')
        target = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        target.connect(('127.0.0.1', 22))
        sockets = [clientsock, target]
        while True:
            readable, writable, err = select.select(sockets, [], sockets, 3)
            if err: break
            for sock in readable:
                data = sock.recv(8192)
                if not data: break
                if sock is clientsock: target.send(data)
                else: clientsock.send(data)
            if not data: break
    except: pass
    finally: clientsock.close()

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(('0.0.0.0', 80))
server.listen(100)
while True:
    c, addr = server.accept()
    threading.Thread(target=handler, args=(c, addr)).start()

criar_usuario() {
    clear
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}            CRIAR NOVO USUARIO SSH                ${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    read -p "Nome do novo usuário: " nome_user
    read -p "Senha para o usuário: " senha_user
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
    echo -e "${VERDE}Teste $nome_teste criado!${NC}"
    sleep 3; menu_principal
}

# --- FUNÇÕES DE CONEXÃO ---

modos_conexao() {
    clear
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}            MODOS DE CONEXÃO DANSSH               ${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}[01] • ATIVAR SSL (STUNNEL4)${NC}"
    echo -e "${BRANCO}[02] • ATIVAR PROXY REAL (WS)${NC}"
    echo -e "${BRANCO}[00] • VOLTAR${NC}"
    echo -ne "${VERDE}Opção: ${NC}"
    read opc_modos
    case $opc_modos in
        1) apt update && apt install stunnel4 -y; service stunnel4 restart; echo -e "${VERDE}SSL Ativado!${NC}"; sleep 2; modos_conexao ;;
        2) 
           echo -e "${VERDE}Iniciando Proxy WebSocket...${NC}"
           wget -q https://raw.githubusercontent.com/Dandan007007/Danssh/main/proxy.py -O /etc/proxy.py
           chmod +x /etc/proxy.py
           fuser -k 80/tcp > /dev/null 2>&1
           screen -dmS proxy python3 /etc/proxy.py
           echo -e "${VERDE}Proxy Online na Porta 80!${NC}"
           sleep 2; modos_conexao ;;
        0) menu_principal ;;
    esac
}

# --- SISTEMA ---

otimizar_sistema() {
    clear
    sync; echo 3 > /proc/sys/vm/drop_caches
    echo -e "${VERDE}Memória RAM limpa e sistema otimizado!${NC}"
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
    echo -e "${BRANCO}[14] • OTIMIZAR SISTEMA     [00] • SAIR${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${VERDE}Opção: ${NC}"
    read opcao
    case $opcao in
        1) criar_usuario ;;
        2) criar_teste ;;
        12) modos_conexao ;;
        14) otimizar_sistema ;;
        0) exit ;;
        *) menu_principal ;;
    esac
}

menu_principal
