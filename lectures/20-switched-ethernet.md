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
