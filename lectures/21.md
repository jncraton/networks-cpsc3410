3.3 Internet (IP)
=================

---

![Internet Protocol Graph](https://book.systemsapproach.org/_images/f01-14-9780123850591.png){height=540px}

---

![Internet Architecture](https://book.systemsapproach.org/_images/f01-15-9780123850591.png)

Internetwork
------------

- Join networks across locations
- Join networks across media types

---

![Example Internetwork](https://book.systemsapproach.org/_images/f03-14-9780123850591.png){height=540px}

---

![Protocol Layers Connecting Networks](https://book.systemsapproach.org/_images/f03-15-9780123850591.png)

---

Key Idea: IP allows networks of different types to be interconnected

Service Model
=============

Host services
-------------

- Addressing scheme
- Datagrams with best-effort delivery
- Packet delivery is not guaranteed

Datagram
--------

- Connectionless packet sent over network
- Includes enough information to get it to its destination
- Best-effort delivery
- Will be sent over other protocols (e.g. Ethernet)

---

[RFC 1149 - IP over Avian Carriers](https://tools.ietf.org/html/rfc1149)

Packet Format
-------------

---

![IPv4 Header](https://book.systemsapproach.org/_images/f03-16-9780123850591.png){height=540px}

Fields
------

- Version - specifies protocol version, such as 4. This comes first so that the rest of the header can be changed in future versions
- HLen - Header length
- TOS (type of service) - Used by some QoS implementations

Fields
------

- Length - total length including header
- Ident, flags, offset - Used for reassembling fragmented packets
- TTL (time to live) - Number of hops before packet is discarded

Fields
------

- Protocol - Higher-level protocol used (TCP, UDP, etc)
- Checksum - Simple additive 16-bit checksum, not as strong as CRC

Fields
------

- Source address
- Destination
- Variable numbers of options
- Padding

Fragmentation and Reassembly
============================

Fragmentation
-------------

- IP packets may be 65,535 bytes
- Underlying networks may have smaller limits
- Packets may need to be broken (fragmented) in order to be delivered

---

![IP fragmentation over networks](https://book.systemsapproach.org/_images/f03-17-9780123850591.png)

Fragments
---------

- Valid IP packets themselves
- Contain information needed for reassembly

Reassembly
----------

- Hosts gather fragments and reassemble
- This is a relatively expensive process we'd prefer to avoid

Maximum transmission unit (MTU)
-------------------------------

- Maximum size IP packet that can be carried in a single frame
- It is reasonable to not send IP packets larger than the MTU to avoid fragmentation

Path MTU Discovery
------------------

- Used to determine max MTU for path to avoid fragmentation

Discovery Process
-----------------

1. Sender sends an IP packet with a Don't Fragment (DF) bit set
2. Any node that would need to break up the packet instead sends a ICMP Fragmentation Needed message back to the sender
3. The sender repeats the process to find a reasonable MTU

Global Addresses
================

Flat Addresses
--------------

- We need a unique global identifier
- MAC addresses are unique, but they are also *flat* meaning they can't easily be mapped to a hierarchical network structure.

Hierarchical Addresses
----------------------

- IP addresses are hierarchical
- The parts of the address correspond to a network, then to a host on that network

---

![IPv4 Address classes](https://book.systemsapproach.org/_images/f03-19-9780123850591.png)

Datagram Forwarding
===================

Assumptions
-----------

- Every Datagram contains a destination address
- The network portion of the IP address identifies a single network
- All hosts within a network can communicate directly
- Every network has a router that can exchange packets with other networks

Forwarding
----------

- Determine if we are on the same network as the destination address by comparing to addresses on own interfaces
- If on same network, deliver directly
- If not on same network, forward packet to appropriate router

Forwarding Table
----------------

- Forwarding table will list possible routers
- (NetworkNum, NextHop) pairs
- Individual hosts will often have only a single default router

Forwarding Table Example
------------------------

```
ip route
```

or

```
route -n
```

Route Example
-------------

```
traceroute -n 1.1.1.1
```

Subnetting and Classless Addressing
===================================

---

![IPv4 Address classes](https://book.systemsapproach.org/_images/f03-19-9780123850591.png)

Class Limitations
-----------------

- Address space is limited
- Classes inefficiently use address space
- How can we get more granularity?

---

![Subnet Addressing](https://book.systemsapproach.org/_images/f03-20-9780123850591.png)

---

![Subnetting Example](https://book.systemsapproach.org/_images/f03-21-9780123850591.png){height=540px}

Routing
-------

- We need to adjust forwarding tables slightly to use subnetting
- Use (SubnetNumber, SubnetMask, NextHop) tuples

---

+---------------+-----------------+-------------+
| SubnetNumber  | SubnetMask      | NextHop     |
+===============+=================+=============+
| 128.96.34.0   | 255.255.255.128 | Interface 0 |
+---------------+-----------------+-------------+
| 128.96.34.128 | 255.255.255.128 | Interface 1 |
+---------------+-----------------+-------------+
| 128.96.33.0   | 255.255.255.0   | R2          |
+---------------+-----------------+-------------+

Classless Interdomain Routing (CIDR)
------------------------------------

- Address space usage is still not ideal, particularly for forwarding
- We can combine subnets together into a supernet

---

![CIDR Route Aggregation](https://book.systemsapproach.org/_images/f03-22-9780123850591.png)

Notation
--------

- 1.1.1.0/24 (Class C address)
- Equivalent to 255.255.255.0 Subnet

Address Translation (ARP)
=========================

---

How do we know where an IP address is on our local network?

Use IP address as local addresses
---------------------------------

- Limits the size of network addresses
- Can't work with 48 bit Ethernet addresses
- IP addresses need to be assigned
- Rarely done in practice

Store Mappings
--------------

- Could be centrally maintained
- Could be maintained automatically

ARP
---

- Maintains address table (ARP Cache)
- Cache values are evicted by timeout
- If a needed value is not present in the cache, an ARP broadcast message is used to learn it

---

![ARP Packet Format](https://book.systemsapproach.org/_images/f03-23-9780123850591.png){height=540px}

Wireshark Example
-----------------

- Use `arp` filter

Host Configuration (DHCP)
=========================

Addresses
---------

- Ethernet networks use pre-configured globally unique addresses
- IP addresses need to be unique and reflect network structure
- IP addresses have a host and network portion, so addresses can't be preconfigured during device manufacturing
- We need a mechanism to assign addresses

Default Gateway
---------------

- Before a host can send a packet outside of the network, it needs to know the local address of the router to send through

Manual Configuration
--------------------

- It is possible to manually configure addresses, routes and other information
- In real networks manual configuration is typically reserved for servers that need to be connected on a given address even in the face of other network issues
- Manual configuration is too complex for large, dynamic networks

Dynamic Host Configuration Protocol (DHCP)
------------------------------------------

- Provide a way to automatically assign addresses and other information to hosts
- A DHCP server on a network provides this service

Discovery
---------

- We don't have any information when we connect to the network, so we first need to locate a suitable DHCP server
- We broadcast a `DHCP discover` message
- A DHCP Server responds with an offer, or a relay responds with the correct server IP

---

![DHCP Example](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/DHCP_session.svg/339px-DHCP_session.svg.png)

---

![DHCP Relay Example](https://book.systemsapproach.org/_images/f03-24-9780123850591.png)

---

DHCP Packet
-----------

- Host sends own network address as `chaddr` field
- Server responds with `yiaddr` filled with your IP address
- `option` may be used for other details, such as default gateway

---

![DHCP Packet Format](https://book.systemsapproach.org/_images/f03-25-9780123850591.png){height=540px}

Wireshark
---------

- Use `bootp` filter
