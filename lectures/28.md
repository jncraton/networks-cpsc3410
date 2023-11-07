4.3 Multicast
=============

Multicast
---------

- There are applications, such as live broadcasts, that can benefit from sending traffic to multiple hosts
- Sending a packet to multiple hosts is known as multicasting

Multicast Addresses
-------------------

- There are special address ranges in IPv4 and IPv6 reserved for multicasting
- Hosts can configure their NICs to listen to multicast addresses of interest

Multicast Uses
--------------

- Typically limited to niche applications
- LAN IP TV broadcasts
- Internal communication on multimedia CDNs

Multicast on the Internet
-------------------------

- Requires more complex routing
- Creates new attack surface for denial-of-service
- Rarely used in practice

4.5 Routing Among Mobile Devices
================================

Mobile Challenges
-----------------

- The Internet was designed for stationary devices
- Addresses are based on location and network
- Moving around will necessarily change your address and break existing connections

---

![Forwarding packets from a correspondent node to a mobile node](https://book.systemsapproach.org/_images/f04-26-22092018.png){height=540px}

Security
--------

- We can simply send a message to the correspondent node updating our address
- How would they be able to trust that it is really us?
- This mechanism could be used for MitM attacks

Two Functions of Addressing
---------------------------

- Identification - Who are we talking to?
- Location - How do we route packets to them?

TCP
---

- Connections assume IP addresses do not change
- TCP is difficult to replace or change

Connection Handling
-------------------

- Applications can check the state of connections and recreate them as needed
- Works well enough for client-driven request-reply protocols
- This is the approach used by HTTP 

Mobility and Wireless
---------------------

- Wireless devices don't necessarily exhibit mobility as described here
- A device moving around campus connecting to different APs is physically mobile, but it is not changing networks or IP addresses
- Network *mobility* would occur when the device transitions from campus Wifi to a cell tower

Mobility Agents
---------------

- In order to facilitate consistent connections, we can build a system of agents on top of our existing networks

---

![Mobility host and agent](https://book.systemsapproach.org/_images/f04-27-9780123850591.png)

Challenges
----------

1. How does the home agent intercept a packet that is destined for the mobile node?
2. How does the home agent then deliver the packet to the foreign agent?
3. How does the foreign agent deliver the packet to the mobile node?

Solutions
---------

- Proxy ARP
- Tunneling

Weaknesses
----------

- Can be slow
- Can use very poor routes

5.1 Simple Demultiplexor (UDP)
==============================

---

IP Addressing
-------------

- The IP layer provides a way to address packets to a given host
- We need a way to route data to the appropriate process on a given host

Ports
-----

- Used by UDP and TCP to identify processes

---

![UDP Header](https://book.systemsapproach.org/_images/f05-01-9780123850591.png)

Learning Ports
--------------

- Messages will include a `srcport` that can be used in replies
- IANA registers and publishes ports for common services (located in /etc/services on Unix-like systems)

---

![UDP Message Queue](https://book.systemsapproach.org/_images/f05-02-9780123850591.png){height=540px}

---

UDP Example
-----------

Server Listener

```
nc -u -l 9999
```

Client

```
nc -u 127.0.0.1 9999
```

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

QUIC
====

Saving Round Trips
------------------

- The layered nature of our stack can cause inefficiency
- TCP requires a handshake to establish a connection
- If we desire encryption, we need a second handshake to establish that

QUIC
----

- Combines establishing a connection and establishing encryption into one handshake
- Can save one RTT of latency when creating connections
- HTTP/3 uses QUIC for transport

---

![TLS vs QUIC handshake](media/quic-handshake.png)

---

Connection Identifiers in QUIC
------------------------------

- TCP connections are defined by their address and port tuple
- QUIC connections are defined by a 64-bit ID generated by the client
- Using a separate ID greatly simplifies the process of migrating connections from one network to another

5.3 Remote Procedure Call
=========================

Request/Reply
-------------

- A Simple paradigm for interacting with a server is to make a request and *block* while waiting for a reply.

---

![Simple RPC Example](https://book.systemsapproach.org/_images/f05-13-9780123850591.png)

RPC Challenges
--------------

- IP is unreliable
- Packets may be reordered
- Message may not fit in single packets

RPC Requirements
----------------

1. Reliable communication protocol
2. A mechanism to convert data and instructions to a shared format (stub compiler)

---

![Complete RPC Mechanism](https://book.systemsapproach.org/_images/f05-14-9780123850591.png){height=540px}

RPC Identifiers
---------------

- Provide a name space for uniquely identifying the procedure to be called
- Match each reply message to the corresponding request message

Overcoming Network Limitations
------------------------------

- Reliability (we can use TCP, but it may be more expensive)
- Support for large messages

---

![Simple RPC ACK Model](https://book.systemsapproach.org/_images/f05-15-9780123850591.png)

---

Implicit ACK
------------

- In some cases we may be able to skip sending explicit ACKs
- We can use replys and requests as implicit ACKs

---

![RCP with implicit ACK](https://book.systemsapproach.org/_images/f05-16-9780123850591.png)

---

![gRPC Example](https://book.systemsapproach.org/_images/Slide13.png)

---

![gRPC Stack](https://book.systemsapproach.org/_images/Slide21.png)
