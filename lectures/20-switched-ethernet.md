3.2 Switched Ethernet
=====================

Bridges
-------

- Connect network segments
- Hubs or bridges behave as a classic Ethernet bus
- Ethernet networks still operate as a *logical* bus

---

![Bridge example](https://book.systemsapproach.org/_images/f03-09-9780123850591.png)

Comparison to Repeaters
-----------------------

- Repeaters operate on bits
- Bridges operate on frames
- Bridges are able to overcome the length and collision issues of repeaters
- Bridges require much more digital logic

Bridge Optimizations
--------------------

- If we have sufficient compute, we can inspect frames and make optimizations
- We don't need to forward all packets to everyone

Learning Bridges
----------------

- How can a bridge decide where packets must go?
- Manually configured forwarding table
- Listen to frames and map src addresses to ports
- Store this information in a table

---

+------+------+
| Host | Port |
+======+======+
| A    | 1    |
+------+------+
| B    | 1    |
+------+------+
| C    | 1    |
+------+------+
| X    | 2    |
+------+------+
| Y    | 2    |
+------+------+
| Z    | 2    |
+------+------+

Example forwarding table

---

MAC table example
-----------------

Call up switch via RS232:

`cu --baud 9600 --line /dev/ttyUSB0`

Show MAC address table on Cisco devices:

`show mac address-table`

ARP Cache vs MAC address table
------------------------------

- An ARP cache maps MAC addresses to IP addresses
- The MAC address table maps MAC addresses to ports
- A modern L3 managed switch will have both

Algorithm
---------

- Add src addresses to table as they are seen
- Expire addresses after a timeout
- Send incoming messages to the correct port if we know it, otherwise broadcast to everyone

Spanning Tree Algorithm
=======================

---

Both broadcasting to everyone and learning bridges create packet storms if the network has a loop.

---

![Ethernet network with loops](https://book.systemsapproach.org/_images/Slide5.png)

---

- Loops break switched Ethernet networks
- We can design networks without loops
- Is there a problem?

Redundancy
----------

- What if a link fails?
- We'd like a system that allows the network to self-heal while we replace the link

---

![Cyclic graphs and spanning tree](https://book.systemsapproach.org/_images/f03-11-9780123850591.png)

Algorithm
---------

- Root node is elected. It will forward on all ports.
- Each switch computes its shortest path to the root and uses the port on that path for forwarding.

---

![Spanning tree with some ports unselected](https://book.systemsapproach.org/_images/Slide6.png)

Broadcast and Multicast
=======================

---

- Broadcast and multicast are trivial to support 
- We transmit to everyone
- Multicast could be better optimized, but it is rarely used in practice and is often simply implemented as broadcast, leaving hosts to discard frames not intended for them

Virtual LANs (VLANs)
====================

Problem
-------

- Switches reduce the collision domain for unicast traffic
- Broadcast traffic is still sent to every host on the network
- Networks are still not fully scalable

Virtual LAN
-----------

- Tag ports as being members of a separate networks
- Reduces size of broadcast domain

---

![VLAN Example](https://book.systemsapproach.org/_images/Slide7.png)

802.1q
------

- Adds support for VLAN tagging on Ethernet networks
- Creates additional header field for VLAN ID

![802.11q VLAN Tag](https://book.systemsapproach.org/_images/Slide42.png)

Security
--------

- VLANs can be a useful tool for implementing defense in depth on Ethernet networks
- Virtual networks can be created to only allow certain hosts to communicate at the network level

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
