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
