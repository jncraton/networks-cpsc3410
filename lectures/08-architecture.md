1.3 Architecture
================

Layering and Protocols
======================

---

What is abstraction?

---

Abstraction is the hiding of implementation details behind an interface

---

Networks have many complex details that we would like to abstract or hide.

---

Layering
--------

- We combine the network communication tasks into **Layers** with well-defined interfaces

---

![Simple layering approach](https://book.systemsapproach.org/_images/f01-08-9780123850591.png)

---

Any given layer may have multiple implementations that implement the same basic services.

---

![Alternate abstractions](https://book.systemsapproach.org/_images/f01-09-9780123850591.png)

Protocols
---------

- The abstract objects making up the layers of the network stack
- Agreement on how communication should take place

Protocol Interfaces
-------------------

- Service interface - Provides interface for use on the local machine
- Peer interface - Determines messaging and communication with the remote host

---

![Protocol interfaces](https://book.systemsapproach.org/_images/f01-10-9780123850591.png)

Protocol Specifications
-----------------------

- Abstract documents that define how communication should work
- Created and maintained by standards bodies (IETF, ISO, etc)

---

![Protocol Graph](https://book.systemsapproach.org/_images/f01-11-9780123850591.png){height=540px}

---

How do middle layer protocols communicate with one another?

---

Indirectly, via encapsulation.

Encapsulation
-------------

- High-level messages are embedded in lower-level messages
- **Headers** are attached to the **payload** (body) adding layer-specific information

---

![Encapsulation](https://book.systemsapproach.org/_images/f01-12-9780123850591.png){height=540px}

Layering
--------

- Headers are added as data passes down the stack of host
- Headers are removed as data is process and moves of the stack of the receiver

Key concept
-----------

Lower layers of the stack do not understand the headers from higher layers. They simply treat the information as a raw data payload.

---

Wireshark Example

Models
======

OSI Model
---------

- 7 layer model
- We do not generally use the OSI model directly in real networks, but it is useful as reference and is still widely discussed

OSI Layers
----------

- Application - High-level protocols (HTTP)
- Presentation - Data formatting (endianess, media formats, etc)
- Session - Connecting multiple channels
- Transport - Process-to-process channel
- Network - Routing among nodes in a network
- Data link - Frames
- Physical - Raw bits

Internet Architecture
---------------------

- 4 layer model
- Reflects design of modern Internet
- Descended from ARPANET architecture
- TCP/IP model

TCP/IP Layers
-------------

- Application
- Transport
- Internet ("Layer 3")
- Link or Network or Subnetwork ("Layer 2")

---

![Internet Architecture](https://book.systemsapproach.org/_images/f01-15-9780123850591.png)

---

![Internet Protocols](https://book.systemsapproach.org/_images/f01-14-9780123850591.png){height=540px}

Internet Architecture Concepts
------------------------------

1. Does not imply strict layering
2. Wide at the top, narrow in the middle, wide at the bottom
3. New protocols require specs and implementations
