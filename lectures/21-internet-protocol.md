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
