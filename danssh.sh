# Adicione isso dentro do seu case $opcao:
    12) modos_conexao ;;

# Adicione esta nova função no final do arquivo:
modos_conexao() {
    clear
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}            MODOS DE CONEXÃO DANSSH               ${NC}"
    echo -e "${AZUL}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BRANCO}[01] • ATIVAR SSL (STUNNEL4) em 443${NC}"
    echo -e "${BRANCO}[02] • ATIVAR PROXY PYTHON (WS) em 80${NC}"
    echo -e "${BRANCO}[00] • VOLTAR${NC}"
    echo -ne "${VERDE}Opção: ${NC}"
    read opc_modos

    case $opc_modos in
        1)
            echo -e "${VERDE}Configurando Stunnel4...${NC}"
            apt install stunnel4 -y
            echo -e "cert = /etc/stunnel/stunnel.pem\n[ssh]\naccept = 443\nconnect = 127.0.0.1:22" > /etc/stunnel/stunnel.conf
            openssl genrsa -out /etc/stunnel/stunnel.key 2048
            openssl req -new -key /etc/stunnel/stunnel.key -x509 -days 1000 -out /etc/stunnel/stunnel.crt -subj "/C=BR/ST=SP/L=SP/O=DANSSH/OU=NET/CN=DANSSH"
            cat /etc/stunnel/stunnel.crt /etc/stunnel/stunnel.key > /etc/stunnel/stunnel.pem
            sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
            service stunnel4 restart
            echo -e "${VERDE}SSL Ativado na porta 443!${NC}"
            sleep 2; modos_conexao ;;
        2)
            echo -e "${VERDE}Iniciando Proxy Python na porta 80...${NC}"
            # Comando simplificado para rodar proxy em segundo plano
            screen -dmS proxy python3 -m http.server 80
            echo -e "${VERDE}Proxy iniciado!${NC}"
            sleep 2; modos_conexao ;;
        0) menu_principal ;;
    esac
}
