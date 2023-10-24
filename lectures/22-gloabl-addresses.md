Global Addresses
================

Flat Addresses
--------------

- We need a unique global identifier
- MAC addresses are unique, but they are also *flat* meaning they can't easily be mapped to a hierarchical network structure.

Hierarchical Addresses
----------------------

- IP addresses are hierarchical
- The parts of the address correspond to a network, then to a host on that network

---

![IPv4 Address classes](https://book.systemsapproach.org/_images/f03-19-9780123850591.png)

Datagram Forwarding
===================

Assumptions
-----------

- Every Datagram contains a destination address
- The network portion of the IP address identifies a single network
- All hosts within a network can communicate directly
- Every network has a router that can exchange packets with other networks

Forwarding
----------

- Determine if we are on the same network as the destination address by comparing to addresses on own interfaces
- If on same network, deliver directly
- If not on same network, forward packet to appropriate router

Forwarding Table
----------------

- Forwarding table will list possible routers
- (NetworkNum, NextHop) pairs
- Individual hosts will often have only a single default router

Forwarding Table Example
------------------------

```
ip route
```

or

```
route -n
```

Route Example
-------------

```
traceroute -n 1.1.1.1
```
