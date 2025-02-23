5.2 Reliable Byte Stream (TCP)
==============================

UDP
---

- Provides very simple demultiplexing to processes on a system
- Implemented as a thin wrapper over IP packets

Missing Features in UDP
-----------------------

- Reliability
- In-order delivery
- Congestion control

Sliding Window Protocol
-----------------------

- Discussed at the link layer
- Similar to ARQ
- Allows multiple packets (window) to be in flight at once

Sliding Window in TCP
---------------------

- Requires connection establishment process, as we aren't dealing with a simple pair of devices
- RTT will vary greatly and be unknown initially
- Reordering must be accounted for
- Hosts may support different (and smaller than ideal) window sizes
- Congestion

---

![TCP Byte Stream Management](https://book.systemsapproach.org/_images/f05-03-9780123850591.png)

---

![TCP Header](https://book.systemsapproach.org/_images/f05-04-9780123850591.png){height=540px}

TCP Flags
---------

- SYN - Used for connection establishment
- FIN - Used for connection teardown
- RESET - Used for error handling to reset connection
- ACK - Set to indicate that the Acknowledgement field is valid

---

![Simple Acknowledgement Process](https://book.systemsapproach.org/_images/f05-05-9780123850591.png)

Establishing a Connection
-------------------------

- Passive open - One party begins listening for connections
- Active open - A second party sends message to initiate a connection
- Messages are exchanged to confirm connection and set parameters

---

![TCP Three-way handshake](https://book.systemsapproach.org/_images/f05-06-9780123850591.png)

---

Should sequence numbers start at zero?

Reuse
-----

- Connections between a pair of hosts may be torn down and remade frequently
- To avoid confusing packets from different incarnations of the same connection, we start each from a new number

---

![TCP Connection Diagram](https://book.systemsapproach.org/_images/f05-07-9780123850591.png){height=540px}

Buffering Data
--------------

- The sender needs to buffer data until it has been acknowledged
- The receiver needs to buffer out of order data

---

![Send (a) and Receive (b) buffers](https://book.systemsapproach.org/_images/f05-08-9780123850591.png)

Flow Control
------------

- Hosts advertise an appropriate max windows size using `AdvertisedWindow` in each segment
- Senders respect this size in order to prevent overflowing a receiver

Sequence number wrapping
------------------------

- We need enough space in our sequence number to prevent reuse
- The original 32-bit number is too small for many modern networks, so also consider the 32-bit timestamp field

Triggering Transmission
-----------------------

How do we decide when to transmit a segment from our buffer?

Silly Window Syndrome
---------------------

- Sending only segments using MSS requires waiting for a full MSS before sending
- If we send segments smaller than MSS, a segment of that size will continue to be used

---

![Silly Window Example](https://book.systemsapproach.org/_images/f05-09-9780123850591.png)

Nagle's Algorithm
-----------------

- If we have available data and a sufficient window to send a full segment, we do so
- If we have no data in flight, we send any data we have immediately
- Otherwise, we wait until no data is in flight or we have a complete segment to send

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

UDP Sockets in Python
---------------------

Create a socket
---------------

```python
sock = socket.socket(family=AF_INET, type=SOCK_DGRAM)
```

Send Data
---------

- Send raw bytes to a port on a particular IP

```python
sock.sendto(b"Hello!", ("127.0.0.1", 2001))
```

Get Data
--------

- Returns bytes from socket when available

```python
data, address = sock.recvfrom(1024)
```

---

Close a socket

```python
sock.close()
```

Bind
----

- Used when implementing a server
- Tells the OS to direct incoming UDP packets to your process

```python
sock.bind(("127.0.0.1", 2001))
```

Math Server Example
-------------------

```python
import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

sock.bind(("127.0.0.1", 8001))

while True:
    data, address = sock.recvfrom(1024)

    value = int.from_bytes(data, "little")
    square = value ** 2

    sock.sendto(square.to_bytes(4, "little"), address)
```

Math Client
-----------

```python
import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

operand = int(input("Value to send:"))

sock.sendto(operand.to_bytes(4,'little'), ("localhost", 8001))

data, address = sock.recvfrom(1024)
print(int.from_bytes(data,'little'))
```
