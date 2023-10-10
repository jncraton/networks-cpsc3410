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
