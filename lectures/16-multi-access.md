2.6 Multi-access networks
=========================

Multi-access
------------

- Hosts share the same link

CSMA/CD
-------

- We need to ensure the channel is quiet before sending (carrier sense)
- We need to stop transmitting if someone else start (collision detection)

History
-------

- Basic algorithm similar to ALOHA
- Used in older Ethernet, but not in modern switched Ethernet
- Used in modern 802.11

ALOHA
-----

- Send data if you have it to send
- Listen to transmission rebroadcast. If it is not your message, you need to resend

---

![Pure ALOHA collisions](https://upload.wikimedia.org/wikipedia/commons/3/35/Pure_ALOHA1.svg)

Slotted ALOHA
-------------

- Introduce time slots for transmission

---

![Slotted Aloha](https://upload.wikimedia.org/wikipedia/commons/7/7a/Slotted_ALOHA.svg)

---

![Pure vs Slotted Efficiency](https://upload.wikimedia.org/wikipedia/commons/a/a5/Aloha_PureVsSlotted.svg)

Ethernet
========

---

![Ethernet Bus](https://book.systemsapproach.org/_images/f02-22-9780123850591.png)

Bus
---

- All hosts are connected to the same medium
- If hosts use the medium at the same time, collisions will occur
- We need to minimize collisions while maximizing time that the bus is active to maximize throughput


Repeaters
---------

- Forward signals between networks
- Allow larger Ethernet networks
- Can create very large broadcast domain

---

![Repeaters connecting segments](https://book.systemsapproach.org/_images/f02-23-9780123850591.png)

Broadcast
---------

- All host receive all frames
- Hosts compete for bandwidth

Access Protocol
===============

---

We can hear all data as it is broadcast on the network, but we need to identify the data that matters to us.

Ethernet Frame
--------------

- 64 bit preamble to allow synchronization
- 6 byte source MAC address
- 6 byte destination MAC address
- 2 byte type field
- Payload
- 4 byte CRC

---

![Ethernet frame](https://book.systemsapproach.org/_images/f02-25-9780123850591.png)

Addresses
---------

- Assigned to an adapter at manufacture time
- Does not need to be allocated by a system on the network like IP addresses

Frames passed up by receiver 
----------------------------

- Frames addressed to its own address
- Frames addressed to the broadcast address
- Frames addressed to a multicast address, if it has been instructed to listen to that address
- All frames, if it has been placed in promiscuous mode

Transmitter Algorithm
---------------------

- If line is idle, and we have data to send, send it
- When we have a frame to send and the line is busy, we wait to transmit until the line is idle and send immediately

---

![Collisions](https://book.systemsapproach.org/_images/f02-26-9780123850591.png){height=500px}

Collisions
----------

- If we detect a collision, we send a jamming signal so others detect the collision and try again after some delay.
- If we experience multiple collisions, our delay increases by some factor (*exponential backoff*)

Why Ethernet?
=============

Ethernet has been dominant for around 40 years
----------------------------------------------

- Components (copper, fiber, NICs) are cheap
- Complex switching hardware is not required
- Backwards compatibility while adding improvements
- Administration is simple (no addresses to manage, etc)

