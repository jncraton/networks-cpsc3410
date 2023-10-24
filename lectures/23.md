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

Error Reporting (ICMP)
======================

Internet Control Message Protocol
---------------------------------

- Acts as a sidechannel for communicate the status of messages

ICMP Uses
---------

- Communicates errors (host unreachable, checksum error, etc)
- ICMP echo requests (ping) can be used to check if a host is up
- ICMP redirect to learn better routes
- Provides building blocks for traceroute

Virtual Networks and Tunnels
============================

Private Networks
----------------

- Corporations with multiple locations might wish to connect their networks
- This can be done over the Internet
- It can be done more securely by leasing private connections between the networks

Virtual Private Networks
------------------------

- It can be more cost-effective to encrypt traffic between networks rather than lease a dedicated connection

---

![a - private network, b - VPN](https://book.systemsapproach.org/_images/f03-26-9780123850591.png){height=540px}

---

Can a VPN be used for other purposes?

Tunnels
-------

- We can send IP traffic or other network traffic over another IP connection
- This can be used to encrypt connections or provide access to other systems

SSH Tunnel Example
------------------

```
ssh -R remote_port:localhost:local_port user@host
```

This allows a local server application to become accessible from a different host.

SSH Proxy Example
-----------------

```
ssh -D [bind_address:]port remote_host
```

This creates a local SOCKS proxy to forward traffic via `remote_host`

3.4 Routing
===========

Getting Routing Information
---------------------------

- Routers need to know where to send packets
- Ethernet switches use a simple forwarding table to map address to ports
- How do routers populate their routing tables?

Routing vs Forwarding
---------------------

- Forwarding is the process of taking a packet and sending it out on another port (*data plane*)
- Routing is the process of determining what values fall in forwarding tables (*control plane*)

Networks as Graphs
------------------

- Hosts on the network are nodes
- Edges represent connections
- Edge weights represent link quality (bandwidth, latency, etc)

---

![Example Network Graph](https://book.systemsapproach.org/_images/f03-28-9780123850591.png)

Shortest Path
-------------

- The problem of routing requires finding the shortest path between nodes
- Where weighted graphs are used, we are trying to minimize the sum of edge weights along the path

Route Calculation
-----------------

- Find shortest path using Dijkstra’s shortest-path algorithm
- [Video](https://www.youtube.com/watch?v=GazC3A4OQTE)

Dijkstra’s Algorithm
--------------------

1. Assign infinite best known distance values to all nodes but the start (which is 0)
2. Update distances to unvisited nodes directly connected to current node if shorter than best known distances
3. Mark current node as visited
4. Set the current node to the unvisited node with the smallest known distance
5. Go back to 3

Static Routing
--------------

- For simple networks, we can manually configure routes
- Being static, this mechanism fails to adapt to change

Static Routing Issues
---------------------

- Doesn't adapt to link failures
- Doesn't handle adding new nodes
- Doesn't handle edge weights changing

Routing Protocols
-----------------

- We need a way to dynamically update routing tables
- Handle new hosts
- Handle link changes

Distance-Vector Routing
-----------------------

- Also known as Bellman-Ford
- Each node tracks distance to all nodes
- Nodes distribute knowledge to peers
- Nodes must know distance to their neighbors

---

![Example Network](https://book.systemsapproach.org/_images/f03-29-9780123850591.png)

---

Initial Distances

+---+---+---+---+---+---+---+---+
|   | A | B | C | D | E | F | G |
+===+===+===+===+===+===+===+===+
| A | 0 | 1 | 1 | ∞ | 1 | 1 | ∞ |
+---+---+---+---+---+---+---+---+
| B | 1 | 0 | 1 | ∞ | ∞ | ∞ | ∞ |
+---+---+---+---+---+---+---+---+
| C | 1 | 1 | 0 | 1 | ∞ | ∞ | ∞ |
+---+---+---+---+---+---+---+---+
| D | ∞ | ∞ | 1 | 0 | ∞ | ∞ | 1 |
+---+---+---+---+---+---+---+---+
| E | 1 | ∞ | ∞ | ∞ | 0 | ∞ | ∞ |
+---+---+---+---+---+---+---+---+
| F | 1 | ∞ | ∞ | ∞ | ∞ | 0 | 1 |
+---+---+---+---+---+---+---+---+
| G | ∞ | ∞ | ∞ | 1 | ∞ | 1 | 0 |
+---+---+---+---+---+---+---+---+

---

Initial Routing Table at Node A


+-------------+------+---------+
| Destination | Cost | NextHop |
+=============+======+=========+
| B           | 1    | B       |
+-------------+------+---------+
| C           | 1    | C       |
+-------------+------+---------+
| D           | ∞    | —       |
+-------------+------+---------+
| E           | 1    | E       |
+-------------+------+---------+
| F           | 1    | F       |
+-------------+------+---------+
| G           | ∞    | —       |
+-------------+------+---------+

Convergence
-----------

- Routers share their routes with their peers
- Routers use this information to update their routing tables
- All routers end up with complete information

---

Final Routing Table at Node A

+-------------+------+---------+
| Destination | Cost | NextHop |
+=============+======+=========+
| B           | 1    | B       |
+-------------+------+---------+
| C           | 1    | C       |
+-------------+------+---------+
| D           | 2    | C       |
+-------------+------+---------+
| E           | 1    | E       |
+-------------+------+---------+
| F           | 1    | F       |
+-------------+------+---------+
| G           | 2    | F       |
+-------------+------+---------+

Updates
-------

- Periodic - Sent regularly to connected routers. Indicate that a host is functioning normally
- Triggered - Sent when a router notices a change (link down, etc)

Routing Information Protocol (RIP)
----------------------------------

- Implementation of distance-vector routing in early networks

Link State (OSPF)
-----------------

- Shares entire connection graph with each node
- Nodes calculate shortest path
- Requires reliable information flooding

Reliable Flooding
-----------------

- Mechanism to get all link information to all hosts
- Nodes create Link-state Packet and send them to peers

Link State Packet (LSP)
-----------------------

- The ID of the node that created the LSP
- A list of directly connected neighbors of that node, with the cost of the link to each one
- A sequence number
- A time to live for this packet

Transmission
------------

- LSP packets are sent to peers
- Acknowledgments and retransmissions are used to ensure reliable delivery

Flooding
--------

- Check sequence and node of incoming LSP. Store and transmit to peers if newer than our stored LSP.
- Skip sending updates to the node that sent them to us
- Drop packets after TTL expires

---

![Flooding Example](https://book.systemsapproach.org/_images/f03-32-9780123850591.png)

Open Shortest Path First (OSPF)
-------------------------------

- Link state protocol used by modern networks

Features
--------

- Authentication - to ensure that bad routing information is not injected maliciously
- Additional hierarchy - break domains into areas to reduce total information transferred
- Load balancing - routes with equal weights will all be used evenly

---

![OSPF Header Format](https://book.systemsapproach.org/_images/f03-34-9780123850591.png)

Routing Metrics
---------------

How do we decide route weights?

ARPANET
-------

- Used queue length as weights
- Provides some useful information, but doesn't work well in practice
- Traffic may get routed around a useful link because that link is useful

ARPANET v2
----------

- Used latency (queue length) and bandwidth
- This allows for a delay calculation for each link
- `Delay = (DepartTime - ArrivalTime) + TransmissionTime + Latency`
- Worked better, but caused high-traffic links to flap between low and high cost

Adjustments
-----------

- Reduce max cost
- Use link utilization in metric
- Smooth link cost changes

---

![ARPANET Routing Metrics](https://book.systemsapproach.org/_images/f03-36-9780123850591.png)

---


- A highly loaded link never shows a cost of more than three times its cost when idle
- The most expensive link is only seven times the cost of the least expensive
- A high-speed satellite link is more attractive than a low-speed terrestrial link
- Cost is a function of link utilization only at moderate to high loads

Static Costs
------------

- Modern networks have more consistent bandwidth and latency than ARPANET
- Metrics are often set statically by administrators to something such as `C/link_bandwidth`
