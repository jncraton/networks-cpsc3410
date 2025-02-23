6.1 Issues in Resource Allocation
=================================

Resource Allocation
-------------------

- Process by which network elements try to meet the competing demands that applications have for network resources
    - Link bandwidth
    - Router/switch buffer space

Congestion Control
------------------

- Efforts made by network nodes to prevent or respond to overload conditions
- Congestion is bad for everyone
- The goal should be to eliminate or even prevent it

Flow Control
------------

- Congestion control deals with the network as a whole
- Flow control deals with a pair of hosts not overwhelming one another

Packet-Switched Network
-----------------------

- Multiple links connected to deliver packets
- Hosts and routers do not have complete information about available bandwidth of the network

---

![Possible bottleneck](https://book.systemsapproach.org/_images/f06-01-9780123850591.png)

Connectionless Flows
--------------------

- IP packets are routed independently
- It is useful to consider packets between a pair of hosts following a similar route as a single *flow*

---

![Flows](https://book.systemsapproach.org/_images/f06-02-9780123850591.png)

Soft State
----------

- State that does not need to be explicitly created and destroyed via signaling
- Most routers maintain soft state about flows to aid in resource allocation

Characteristics
---------------

- Router-Centric versus Host-Centric
- Reservation-Based versus Feedback-Based
- Window Based versus Rate Based

Evaluation
----------

- Throughput should be maximized
- Delay should be minimized

Power
-----

- Throughput / Delay
- Ratio is a function of load placed on network by allocation mechanism
- Ratio should be maximized

---

![Ratio of throughput to delay as a function of load](https://book.systemsapproach.org/_images/f06-03-9780123850591.png)

Fairness
--------

- It isn't sufficient to optimize overall throughput and delay
- Applications and hosts competing for network resources must be given appropriate usage


6.2 Queuing Disciplines
=======================

Routers
-------

- Maintain queues of packets to be forwarded
- The design and use of these queues is a queuing discipline

FIFO
----

- First-in, first-out
- Packets are forwarded in the order they arrive

---

![FIFO Example](https://book.systemsapproach.org/_images/f06-05-9780123850591.png){height=540px}

Fairness
--------

- FIFO allocates packets based on arrival
- A host sending a lot of data will dominate the link
- Hosts sending little data will experience high latency

Fair Queuing
-------------

- Use buffers for each flow
- Send packets in FIFO order per flow in round-robin fashion

---

![Round-robin service](https://book.systemsapproach.org/_images/f06-06-9780123850591.png)

Packet Sizes
------------

- Packets may be different sizes
- We must account for this in order to ensure fairness
- This makes the simple round-robin example a bit more complicated

---

![Queuing in action](https://book.systemsapproach.org/_images/f06-07-9780123850591.png)

Properties
----------

1. *Work conserving* - The link will be active as long as there is a packet in the queue
2. Flows may use only 1/n of the link bandwidth when the link is full

Weighted Fair Queuing
---------------------

- We can assign weights to flows to give them more or less bandwidth
- Weights can be determined in various ways (hosts, traffic type, etc)
- Weights can ultimately be used to shape traffic and provide differing quality of service
