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

- Connectionless (packets can be forward at any time without establishing a connection)
- Hosts don't know if packets can be delivered successfully
- Changes to forwarding table will cause packets to take new paths at any time
- Link failures may not cause downtime if forwarding table can be updated to route around breaks

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
