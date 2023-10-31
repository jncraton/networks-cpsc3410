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

4.2 IP Version 6
================

IP Version 4
------------

- Still used by most hosts on the Internet
- Limited to 32-bit addresses (4 billion unique address)

---

![IPv4 Header](https://book.systemsapproach.org/_images/f03-16-9780123850591.png){height=540px}

IP Upgrade
----------

- Growing address size requires new version of IP protocol and associated network hardware upgrades
- It made sense to include other new features while updating the protocol

IPv6 Features
-------------

- Autoconfiguration
- Enhanced routing
- Compatibility with IPv4 during transition period

IPv6 Addresses
--------------

- 128 bits long
- Support embedding 48-bit link-local addresses

---

+-----------------+---------------------+
| Prefix          | Use                 |
+=================+=====================+
| 00…0 (128 bits) | Unspecified         |
+-----------------+---------------------+
| 00…1 (128 bits) | Loopback            |
+-----------------+---------------------+
| 1111 1111       | Multicast addresses |
+-----------------+---------------------+
| 1111 1110 10    | Link-local unicast  |
+-----------------+---------------------+
| Everything else | Global Unicast      |
+-----------------+---------------------+

Notation
--------

- Typically 8 groups of 4 hex characters
- For example: 47CD:1234:4422:ACO2:0022:1234:A456:0124
- Runs of zeroes may be omitted (47CD::A456:0124)
- IPv4 over IPv6 may be written as ::FFFF:128.96.33.81

Global Unicast Addresses
------------------------

- Support hierarchical routing by default
- Leverage extra bits to create cleaner format and networking boundaries

---

![IPv6 provider-based unicast address](https://book.systemsapproach.org/_images/f04-11-9780123850591.png)

IPv6 Packet Format
------------------

- Updates version field to 6
- Removes rarely used features
- Adds longer addresses
- Improves option parsing via static ordering

---

![IPv6 Header](https://book.systemsapproach.org/_images/f04-12-9780123850591.png){height=540px}

Fragmentation
-------------

- We try to avoid fragmentation whenever possible
- We move fragmentation information out of standard headers and into options to save space in the common case

Autoconfiguration
-----------------

- Advanced feature of IPv6
- Allows creating local addresses without DHCP
- We can create link-local addresses using a prefix and MAC address

---

+-----------------+---------------------+
| Prefix          | Use                 |
+=================+=====================+
| 00…0 (128 bits) | Unspecified         |
+-----------------+---------------------+
| 00…1 (128 bits) | Loopback            |
+-----------------+---------------------+
| 1111 1111       | Multicast addresses |
+-----------------+---------------------+
|**1111 1110 10** | Link-local unicast  |
+-----------------+---------------------+
| Everything else | Global Unicast      |
+-----------------+---------------------+

Source-Directed Routing
-----------------------

- Allow individual packets to specify which networks they should pass through
- Can be used to balance cost and quality of service requirements

4.3 Multicast
=============

Multicast
---------

- There are applications, such as live broadcasts, that can benefit from sending traffic to multiple hosts
- Sending a packet to multiple hosts is known as multicasting

Multicast Addresses
-------------------

- There are special address ranges in IPv4 and IPv6 reserved for multicasting
- Hosts can configure their NICs to listen to multicast addresses of interest

Multicast Uses
--------------

- Typically limited to niche applications
- LAN IP TV broadcasts
- Internal communication on multimedia CDNs

Multicast on the Internet
-------------------------

- Requires more complex routing
- Creates new attack surface for denial-of-service
- Rarely used in practice

4.5 Routing Among Mobile Devices
================================

Mobile Challenges
-----------------

- The Internet was designed for stationary devices
- Addresses are based on location and network
- Moving around will necessarily change your address and break existing connections

---

![Forwarding packets from a correspondent node to a mobile node](https://book.systemsapproach.org/_images/f04-26-22092018.png){height=540px}

Security
--------

- We can simply send a message to the correspondent node updating our address
- How would they be able to trust that it is really us?
- This mechanism could be used for MitM attacks

Two Functions of Addressing
---------------------------

- Identification - Who are we talking to?
- Location - How do we route packets to them?

TCP
---

- Connections assume IP addresses do not change
- TCP is difficult to replace or change

Connection Handling
-------------------

- Applications can check the state of connections and recreate them as needed
- Works well enough for client-driven request-reply protocols
- This is the approach used by HTTP 

Mobility and Wireless
---------------------

- Wireless devices don't necessarily exhibit mobility as described here
- A device moving around campus connecting to different APs is physically mobile, but it is not changing networks or IP addresses
- Network *mobility* would occur when the device transitions from campus Wifi to a cell tower

Mobility Agents
---------------

- In order to facilitate consistent connections, we can build a system of agents on top of our existing networks

---

![Mobility host and agent](https://book.systemsapproach.org/_images/f04-27-9780123850591.png)

Challenges
----------

1. How does the home agent intercept a packet that is destined for the mobile node?
2. How does the home agent then deliver the packet to the foreign agent?
3. How does the foreign agent deliver the packet to the mobile node?

Solutions
---------

- Proxy ARP
- Tunneling

Weaknesses
----------

- Can be slow
- Can use very poor routes

5.1 Simple Demultiplexor (UDP)
==============================

---

IP Addressing
-------------

- The IP layer provides a way to address packets to a given host
- We need a way to route data to the appropriate process on a given host

Ports
-----

- Used by UDP and TCP to identify processes

---

![UDP Header](https://book.systemsapproach.org/_images/f05-01-9780123850591.png)

Learning Ports
--------------

- Messages will include a `srcport` that can be used in replies
- IANA registers and publishes ports for common services (located in /etc/services on Unix-like systems)

---

![UDP Message Queue](https://book.systemsapproach.org/_images/f05-02-9780123850591.png){height=540px}

---

UDP Example
-----------

Server Listener

```
nc -u -l 9999
```

Client

```
nc -u 127.0.0.1 9999
```
