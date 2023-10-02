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

2.7 Wireless Networks
=====================

Wireless Differences
--------------------

- In most cases, links are broadcast
- Collisions are very likely
- Sources of errors are abundant

---

+-------------+-----------------------+-----------------+--------------+
|             | Bluetooth (802.15.1)  | Wi-Fi (802.11)  | 4G Cellular  |
+=============+=======================+=================+==============+
|             | 10 m                  | 100 m           | Tens of      |
| Link length |                       |                 | kilometers   |
+-------------+-----------------------+-----------------+--------------+
|             | 2 Mbps (shared)       | 150-450 Mbps    | 1-5 Mbps     |
| Data rate   |                       |                 |              |
+-------------+-----------------------+-----------------+--------------+
| Typical use | Link a peripheral to  | Link a computer | Link mobile  |
|             | a computer            | to a wired base | phone to a   |
|             |                       |                 | wired tower  |
+-------------+-----------------------+-----------------+--------------+

Frequency Use
-------------

- RF collisions between all sorts of devices are possible
- Governments typically slice up the spectrum and allocate it for various purposes
- In the US, the FCC handles these allocations

Frequency Licenses
------------------

- Many frequency bands require an explicit license
- Even unlicensed bands require rules to be followed to limit interference, such as a maximum legal transmission frequency

Base Stations
-------------

In most network designs, we have a device generically referred to as a base station that has a high-bandwidth link to the network and wirelessly serves other clients.

---

![Network using base station](https://book.systemsapproach.org/_images/f02-28-9780123850591.png){height=540px}

Mesh networks
-------------

- Lack a central base station
- Wireless communication between all nodes

---

![Mesh network](https://book.systemsapproach.org/_images/f02-29-9780123850591.png){height=540px}

802.11
======

WiFi
----

- Commonly used to cover small geographic area (homes, offices, etc)
- Can be operated without a license

Main standards
--------------

- 802.11b - 11mbps max data rate, 2.4GHz
- 802.11a - 54mbps max data rate, 5GHz
- 802.11g - 54mbps max data rate, 2.4GHz
- 802.11n - 150mbps max data rate, 2.4GHz (40MHz channel, no MIMO)
- 802.11ac - 867mbps 2.4Ghz and 5GHz (8 antenna AP, 160MHz channel)

Bitrate negotiation
-------------------

- Bitrates can be adjusted in response to surrounding noise and interference

Improvements over time
----------------------

- Improved hardware and encoding/decoding techniques
- Channel bonding
- MIMO

MIMO
----

- Multiple input, multiple output
- Uses arrays of antennas and interference patterns to create multiple spatial streams

---

[Beamlab](https://apenwarr.ca/beamlab/)

Real speed increases
--------------------

- Many increases in performance are hard to realize
- Some require uncongested areas
- Some require signal quality that is difficult to realize in reality in order to negotiate the highest rates

Collisions
---------

How do we make ourself heard while avoiding talking over others?

Collision detection
-------------------

- In Ethernet we can listen to our bus to know if it is in use
- We can't do this perfectly when communicating with a wireless base station

---

![Hidden node problem](https://book.systemsapproach.org/_images/f02-30-9780123850591.png){height=540px}

---

![Exposed node problem](https://book.systemsapproach.org/_images/f02-31-9780123850591.png){height=540px}

Collision Avoidance
-------------------

We need a mechanism to prevent collisions the we can't observe ourselves

Request to send
---------------

- When we have data to send, we send and RTS packet to the base station including the amount of time that we need
- The base station responds with a CTS packet letting us know we can proceed
- Network Allocation Vector (NAV) - Hosts on the network track time until it is available by observing RTS and CTS frames

RTS Collisions
--------------

- RTS frames may collide
- This is identified by lack of CTS
- Backoff then occurs before retry

Distribution System
===================

Base stations
-------------

- 802.11 can be used for ad-hoc networks, but it usually involves one or more base stations or APs
- In networks with multiple APs, APs are networked together via a distribution system

---

![Distribution System](https://book.systemsapproach.org/_images/f02-32-9780123850591.png)

Joining a network
-----------------

1. Node sends `Probe` frame
2. APs respond with `Probe Response` frame
3. Node selects AP and sends `Association Request` frame
4. The AP replies with an `Association Response` frame

Mobility
--------

- Nodes may choose to drop their associated AP and associate with a new one
- This process is the same as the initial process to join the network

---

![Node Mobility](https://book.systemsapproach.org/_images/f02-33-9780123850591.png)

Passive scanning
----------------

- `Probe` frames are used for active scanning
- We can also passively listen for `Beacon` frames sent at regular intervals by the AP

Frame Format
============

---

![802.11 frame](https://book.systemsapproach.org/_images/f02-34-9780123850591.png)

Multiple Addresses
------------------

- We need additional addresses in the frame
- Transmitter Address (TA)
- Receiver Address (RA)
- Source Address (SA)
- Destination Address (DA)

---

![Wifi Addresses](https://book.systemsapproach.org/_images/f02-34-9780123850591.png)

Wifi Security
-------------

- All traffic is broadcast over the air and is vulnerable to eavesdropping
- We will discuss adding encryption to secure wireless channels in chapter 8

Bluetooth
=========

---

- Operates at 2.45 GHz
- Connect devices at short range
- Headsets, mice, etc

2.8 Access Networks
===================

Passive Optical Network
=======================

--- 

- Used to provide broadband access to homes and businesses.
- Uses passive splitters to separate fibers

---

![PON network fanout](https://book.systemsapproach.org/_images/Slide12.png)

Components
----------

- Optical Line Terminal (OLT) - terminates fiber at ISP
- Optical Network Unit (ONU) - terminates fiber at endpoints

Downstream Access
-----------------

- ONUs receive every frame from the OLT
- ONUs use addressing to identify their frames
- Encryption is used to protect traffic

Upstream Access
---------------

- ONUs are sent grants from the OLT indicating when they can transmit
- OLT manages grants as a way of maintaining fairness and usage of the link
