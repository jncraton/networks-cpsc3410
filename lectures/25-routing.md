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
