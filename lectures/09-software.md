1.4 Software
============

Sockets
=======

---

Sockets provide a standard interface from the network to our applications

Socket types
------------

- Stream - provides a virtual circuit
- Datagram - delivers individual packets

Socket Implementation
---------------------

- Independent of network type
- Most typically used with TCP/IP and UDP/IP

---

![Socket States](media/socket-states.png)

Echo server example
-------------------

```python
import socket

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind(('0.0.0.0', 2001))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print('Connected by', addr)
        while True:
            data = conn.recv(1024)
            if not data: break
            conn.sendall(data)
```

Echo client example
-------------------

```python
import socket

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect(('127.0.0.1', 2001))
    s.sendall(b'Hello, world')
    data = s.recv(1024)
print('Received', repr(data))
```

---

Explore traffic in Wireshark
