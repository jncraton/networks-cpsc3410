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
