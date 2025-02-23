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
