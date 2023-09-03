1.2 Requirements
================

---

- We want to understand how to build a network from the ground up
- We must understand the design of modern networks, but it is also important to consider first principles and how we got here

Stakeholders
============

---

In considering how and why networks are the way they are, it is critical to consider the people involved with them

Users
-----

- Define the needs and use cases for the networks

Application Programmer
----------------------

- Defines specific application level network services
    - Guaranteed delivery
    - Continuous connectivity and roaming
    - Speed requirements

Network Operator
----------------

- Defines characteristics of overall system to make it manageable
    - Handling hardware failure
    - Configuration management
    - Usage restrictions, monitoring, and accounting

Network Designer
----------------

- Defines properties for a cost-effective design
    - Fairness of usage
    - Performance
    - Price
    - Physical media

Scalable Connectivity
======================

---

- A network must provide connectivity among computers
- Sometimes it is useful to have limited networks (corporate networks, campus networks, etc)
- Usually though, we want to *scale* to an arbitrary size

Hierarchy
---------

- We have to approach connectivity from multiple levels

Links
-----

- Physical connections (wires, rf) between devices create a *link* between *nodes*
- Links may be point-to-point or multiple-access
- Often seen as the *last mile* connections (Wifi, Cable, DSL, FTTH, etc)

---

![a: point-to-point, b: multiple-access](media/1-2.png)

Scaling Links
-------------

- A single physical connection is very limiting in terms of geographic area and number of hosts it can serve
- Fully connected networks require too many connections in most applications
- Connected hosts can cooperate to form larger networks of indirect connectivity

Switched Network
----------------

- Group of nodes that connect to forward data
- May be *packet switched* or *circuit switched*

---

![switched network](media/1-3.png)

Store-and-forward
-----------------

- Common packet switched network implementation
- Nodes receive a full packet of data, then forward it to the appropriate next hop on the network

Internetworking
---------------

- We frequently connect separate networks together (such as the AU campus network and your home network)
- This is known as internetworking
- Routers or gateways handle passing packets between the networks

Addressing
----------

- We have shown that we can build up a large network using interconnected nodes
- Hosts on the network still need to be able to refer to one another
- The system by which hosts refer to one another is known as *addressing*

Addresses
---------

- Typically represented as a unique byte string
- Messages typically include source and destination addresses
- *Routing* allows messages to be forwarded to the correct host

Multiple destinations
---------------------

- We may want (or need) to send data to multiple hosts
- Unicast - send to one host
- Multicast - send to a group of hosts
- Broadcast - send to all hosts

Big idea
--------

- Networks are defined recursively
- This hides complexity, overcomes physical limitations, and makes the overall system manageable
