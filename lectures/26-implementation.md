3.5 Implementation
==================

Software Switch
---------------

- We can create a switch by adding multiple NICs to a general-purpose computer
- All packets must pass through main memory (max bandwidth ~100Gbps)
- Packets must all be processed by a single CPU

---

![Software Switch](https://book.systemsapproach.org/_images/Slide14.png)

Hardware Switch
---------------

- Software switches have limited bandwidth
- We can improve the situation by creating dedicated parallel hardware

Application-Specific Integrated Circuits (ASICs)
------------------------------------------------

- Custom silicon
- Can be very fast for a particular purpose
- Expensive to produce
- Time consuming to design

Domain Specific Processors
--------------------------

- Can be an option in network hardware
- Add instructions and hardware for particular domain tasks (e.g. machine learning, video encoding)
- Provide benefits of traditional CPU with better domain performance

---

![Switch architecture](https://book.systemsapproach.org/_images/Slide22.png)

Network Processing Units
------------------------

- Similar in concept to GPUs but designed for implementing switch backplanes
- Can process many terabits per second of data, far more than we could with a traditional CPU

NPU Benefits
------------

- Very fast SRAM
- Ternary Content Addressable Memory - Packets can be matched at a high rate of speed
- Forwarding is implemented in a parallel pipeline on an ASIC

4.1 Global Internet
===================

---

- Routing as discussed previously provides a somewhat scalable solution for the global Internet
- The modern Internet includes 100,000+ *networks*, so including them all in routing tables is problematic
- We need to create a tighter hierarchy to make the problem more tractable

---

![Internet Tree Structure in 1990](https://book.systemsapproach.org/_images/f04-01-9780123850591.png)

Scaling Challenges
------------------

- Routing problem size
- IP address space utilization

Routing Areas
-------------

- There are too many individual networks to practically calculate and store routes for all of them
- We group the networks together into areas

Backbone
--------

- Connects areas together
- May be referred to as area 0

---

![Domain divided into areas](https://book.systemsapproach.org/_images/f04-02-9780123850591.png)

Routing Inside Area
-------------------

- Covered in chapter 3
- Routers exchange link-state packets to learn connections and then calculate shortest paths
- Link-state packets are not passed outside of the area

Border Routers
--------------

- Summarize routes from their area and share information with backbone
- An area may have multiple border routers connected to the backbone
- (R1, R2, and R3 in figure)

Interdomain Routing (BGP)
-------------------------

Autonomous Systems (AS)
-----------------------

- The Internet is organized as a collection of networks controlled by a single administrative entity (large corporation, ISPs, etc)
- Provides additional hierarchy to improve scalability

---

![Two Autonomous Systems](https://book.systemsapproach.org/_images/f04-03-9780123850591.png){height=540px}

Interdomain Routing Challenges
------------------------------

- Each AS needs to be able to determine its own routing policies
- We want to use our connections for the purpose that we paid for, which may mean avoiding *transit* traffic
- Find non-looping, policy compliant paths

---

![Multi-provider Internet](https://book.systemsapproach.org/_images/f04-04-9780123850591.png)

AS Types
--------

- Stub - AS with one connection to one other AS
- Multi-homed - AS with connection to multiple AS, but that disallows transit traffic
- Transit - AS with multiple connections designed to carry local and transit traffic, such as a backbone

AS Costs
--------

- Internal route costs are meaningless externally, so we only share reachability as our routing metric

Trust
-----

- We must provide trust in the system
- An AS advertising a route they can't support will break the Internet
- [Example BGP-related outage](https://blog.cloudflare.com/how-verizon-and-a-bgp-optimizer-knocked-large-parts-of-the-internet-offline-today/)

Border Gateway Protocol
-----------------------

- Gateway is another name for router
- Protocol handles route communication between AS border routers

---

![Example BGP System](https://book.systemsapproach.org/_images/f04-06-9780123850591.png)

Route advertisement
-------------------

- BGP speakers advertise complete paths
- Upstream BGP speakers share this information with peers, adding themselves as a hop
- An AS can prevent transit by not advertising available routes that it doesn't want others to use

AS Numbers
----------

- Must be unique
- Currently 32 bit number assigned to an AS

BGP Packets
-----------

- Use TCP for reliability
- May indicate that a route is available or a previous route is withdrawn

---

![BGP Packet Format](https://book.systemsapproach.org/_images/f04-07-9780123850591.png){height=540px}

---

![Common AS relationships](https://book.systemsapproach.org/_images/f04-08-9780123850591.png)


Complete Routing
----------------

- We can combine interdomain and intradomain routing to deliver a packet from any host to any other host
- BGP is used to determine routes between AS
- Interior Gateway Protocol (IGF), such as RIP or OSPF is used inside AS

---

![Example Network](https://book.systemsapproach.org/_images/f04-09-9780123850591.png){height=540px}

---

![Example routing tables](https://book.systemsapproach.org/_images/f04-10-9780123850591.png){height=540px}

---

![iLight Network Map](https://ilight.net/images/i-light-topo-map-2021-september.png){height=540px}
