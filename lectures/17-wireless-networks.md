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

Cellular Networks
=================

Compared to 802.11
------------------

- Transmits data via radio frequency
- Uses licensed bands vs unlicensed ISM band for 802.11
- Only certain devices are allowed to use frequencies

Frequencies
-----------

- Vary based on region
- Allocated by government
- Typically 700MHz to 2400MHz
- Some higher frequencies are seeing more use

Frequency considerations
------------------------

- Lower frequencies can better pass through obstructions
- Wider frequency bands can transmit more data
- This creates competition for frequencies from ~700 to ~2400 MHz

---

![EM Spectrum](https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Electromagnetic-Spectrum.svg/316px-Electromagnetic-Spectrum.svg.png)

Cellular Network Hardware
-------------------------

- User Equipment (UE) - Phones and other devices connected to the network
- Broadband Base Units (BBU) - Similar to 802.11 APs
- Evolved Packet Core (EPC) - Provides backbone for BBUs
- Radio Access Network (RAN) - Collection of BBUs

---

![Cellular Network](https://book.systemsapproach.org/_images/Slide2.png)

---

Cells
-----

- Area served by a BBU antenna
- May be one cell per BBU
- Multiple cells could be served by a BBU using directional antennas

Overlap
-------

- Cells overlap somewhat
- When the network detects that a device is moving from one cell to another, a handoff occurs
- Cells are designed intentionally to not use the same frequency on adjacent cells

---

![Frequency Reuse](https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Frequency_reuse.svg/595px-Frequency_reuse.svg.png)

---

![Frequency Reuse with Directional Antennas](https://upload.wikimedia.org/wikipedia/commons/5/57/CellTowersAtCorners.gif)

---

This is a NP-complete graph coloring problem.

Medium Access
-------------

- 802.11 is contention based
- Most cellular networks are reservation based

Orthogonal Frequency-Division Multiple Access (OFDMA)
-----------------------------------------------------

- Uses a number of independent (orthogonal) frequency bands to transmit
- Individual time slices on a band, resource units (REs), are assigned by the scheduler
- Scheduler operates on units of bands and time called Physical Resource Blocks (PRBs)

---

![PRBs and REs](https://book.systemsapproach.org/_images/Slide4.png)

5G
---

- Add additional frequency bands and more complex scheduling
- Improves throughput

3.1 Switching Basics
====================

Direct Connections
------------------

- We have assumed up until now that our devices are directly connected
- Ethernet bus
- Wifi radios

Direct Connection Limits
------------------------

- Cable length
- Radio range
- Collision domain size

Internetworking
---------------

- We connect our networks together in order to form the global Internet

Routers
-------

- Operate at layer 3 and may connect networks of different types

Switches
--------

- Operate at layer 2 and connect networks of the same type
- May also be called bridges

Switches
--------

- Multiple-input, multiple-output device
- Transfers packets from an input to one or more output ports

Switch Benefits
---------------

- Can be interconnected to form networks of many hosts
- Can be connected via point-to-point links like fiber to create a geographically large network
- New hosts do not decrease the performance of other hosts

Star Topology
-------------

- Classic Ethernet uses physical bus topology
- This has many weaknesses, including a large collision domain
- Switches allow a star topology which avoids this problem

---

![Star Topology](https://book.systemsapproach.org/_images/f03-01-9780123850591.png){height=540px}

Classic vs Switched Ethernet
----------------------------

- Classic - Hosts limited to the speed of the medium (10mbps) collectively
- Switched - Hosts limited to the speed of the medium individually
- Switching is far more scalable

Switching Challenges
--------------------

- Identifying hosts - Use addresses
- Determining output for packet

Datagrams
=========

---

Every packet includes info needed to send it to the correct destination

---

![Example network](https://book.systemsapproach.org/_images/f03-02-9780123850591.png){height=540px}

---

Let's look at the forwarding table on switch 2

---

+-------------+------+
| Destination | Port |
+=============+======+
| A           | 3    |
+-------------+------+
| B           | 0    |
+-------------+------+
| C           | 3    |
+-------------+------+
| D           | 3    |
+-------------+------+
| E           | 2    |
+-------------+------+
| F           | 1    |
+-------------+------+
| G           | 0    |
+-------------+------+
| H           | 0    |
+-------------+------+

Datagram Networks
-----------------

- Connectionless (packets can be forward at any time with establishing a connection)
- Hosts don't know if packets can be delivered successfully
- Changes to forwarding table will cause packets to take new paths at any time
- Link failures may not cause downtime if forwarding table can be updated to route around breaks

---

Virtual Circuit Switching
=========================

Connection-oriented
-------------------

- Must setup a connection before data transmission
- Switches create and maintain connection state in a VC table

VC Table
--------

- Unique virtual connection identifier (VCI) included in packet headers
- Incoming interface
- Outgoing interface
- New VCI for outgoing packets

Virtual Circuit Types
---------------------

- Permanent (PVC) - Configured by network administrators
- Switched (SVC) - Configured by host messages on the network (*signaling*)

---

![Example network](https://book.systemsapproach.org/_images/f03-03-9780123850591.png)

Creating a VC from A to B
-------------------------

Switch 1
--------

+--------------------+--------------+--------------------+--------------+
| Incoming Interface | Incoming VCI | Outgoing Interface | Outgoing VCI |
+====================+==============+====================+==============+
| 2                  | 5            | 1                  | 11           |
+--------------------+--------------+--------------------+--------------+

Switch 2
--------

+--------------------+--------------+--------------------+--------------+
| Incoming Interface | Incoming VCI | Outgoing Interface | Outgoing VCI |
+====================+==============+====================+==============+
| 3                  | 11           | 2                  | 7            |
+--------------------+--------------+--------------------+--------------+

Switch 3
--------

+--------------------+--------------+--------------------+--------------+
| Incoming Interface | Incoming VCI | Outgoing Interface | Outgoing VCI |
+====================+==============+====================+==============+
| 0                  | 7            | 1                  | 4            |
+--------------------+--------------+--------------------+--------------+

---

![Packet traversing VC](https://book.systemsapproach.org/_images/f03-04-9780123850591.png)

Management
----------

- For real networks we need tools to manage PVC as the problem quickly becomes complicated
- Signaling can be used in PVC to help admins configure connections

VC Considerations
-----------------

- Requires 1 RTT at minimum before data can be sent using signaling
- VCI (link-local) will be smaller than addresses, saving overhead
- VCs need to recreated when a link fails and torn down to free RAM
- Signaling still requires knowledge of hosts on the network, so it doesn't solve our core routing issues

Resource Allocation
-------------------

- VC networks can limit usage by rejecting new circuits
- We can assign circuits different Quality of Service (QoS)
- Datagram networks have to process packets as they arrive or drop them

Source Routing
==============

---

- Include all data needed for routing in the packet
- Requires additional overhead and complete knowledge of the network

---

![Source routing](https://book.systemsapproach.org/_images/f03-07-9780123850591.png)

---

Updating Routing Info
---------------------

- Rotate exits
- Strip used exits
- Update pointer to next exit

---

![(a) rotation (b) stripping (c) pointer](https://book.systemsapproach.org/_images/f03-08-9780123850591.png)
