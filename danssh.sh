import socket, threading

def handler(clientsock, addr):
    try:
        data = clientsock.recv(1024)
        if not data: return
        # Isso aqui resolve o erro 501 do seu log
        clientsock.send(b'HTTP/1.1 101 Switching Protocols\r\nUpgrade: websocket\r\nConnection: Upgrade\r\n\r\n')
        
        target = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        target.connect(('127.0.0.1', 22))
        
        def forward(s, d):
            try:
                while True:
                    chunk = s.recv(8192)
                    if not chunk: break
                    d.sendall(chunk)
            except: pass
        
        threading.Thread(target=forward, args=(clientsock, target)).start()
        forward(target, clientsock)
    except: pass

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(('0.0.0.0', 80))
server.listen(500)
while True:
    c, addr = server.accept()
    threading.Thread(target=handler, args=(c, addr)).start()
