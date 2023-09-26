2.4 Error Detection
===================

---

![QR Code (low error correction)](media/qr-l.png){height=540px}

---

![QR Code (high error correction)](media/qr-h.png){height=540px}

Errors
------

- Data errors at the physical level are unavoidable
- Data errors at the software level are unacceptable

Link Types
----------

- Fiber - very low error rate on good links
- Copper - very low error rate, but somewhat worse than fiber
- RF - bit errors and long strings of errors are probable

Handling errors
---------------

1. Detect that an error has occurred
2. Ask for retransmission

Simple error detection
----------------------

- Send message twice
- Confirm that both copies are identical

Simple error detection
----------------------

- 2x overhead
- A 2-bit error could be undetected

Overhead
--------

- We want to be able to add k bits to an n bit message in a way that can detect the most possible errors

Parity
------

- Adds a single bit to a message that makes the total number of 1s odd or even
- Will catch any odd number of bit error (1, 3, etc)
- Will miss any even number of bit errors
- Used in RS232

Checksum
--------

- Error detecting code involving addition

Checksum Process
----------------

- Treat each word in the message as a number
- Add the words and transmit their lowest k-bits as the checksum
- Confirm that the checksum matches when receiving frames
- Catches most errors, but will still miss errors that "cancel out"

Cyclic Redundancy Check (CRC)
-----------------------------

- Provides a division-like check function
- Efficient to implement in hardware
- Can be tuned by selecting different polynomials
- CRC32 is used in Ethernet

---

![CRC via polynomial long division](https://book.systemsapproach.org/_images/f02-15-9780123850591.png)

---

[CRC Details Video](https://www.youtube.com/watch?v=izG7qT0EpBw)

CRC as a hash function
----------------------

- CRC is effectively a hash function
- It's not designed as a *cryptographic* hash function
- It's not  designed to prevent intentional collisions, but simply to detect random errors
- Do not use it as a cryptographic hash function

Error Correction
================

Hamming Codes
-------------

- A mechanism to correct errors in transmission using overlapping parity bits
- Provides relatively simple ECC example
- Used in ECC RAM

---

![Hamming parity coverage](media/hamming.png)

Hamming Example
---------------

2.5 Reliable Transmission
=========================

Layer
-----

- Reliable transmission may be provided by the link layer
- It may also be provided by higher layers
- The basic techniques are the same

Errors
------

- Bitstreams may have errors
- Errors can be detected using CRCs or other mechanisms
- Some errors can be corrected by including redundant data, but this has fixed cost

NACK
----

- Receiver - Send message to sender letting them know data is corrupted
- Sender - Resend the message

NACK Weaknesses
---------------

- Doesn't positively confirm that all data was received
- In the case of certain errors, the receiver may not even know they were meant to get a message

Automatic Repeat Request (ARQ)
------------------------------

- Receiver - Acknowledge when data arrives
- Sender - Timeout if no acknowledgment
- Retransmission can be used to provide correct data

---

![ARQ Success](media/arq-success.png)

---

![ARQ Retransmission](media/arq-success.png)

Stop and wait
=============

---

- After sending a frame, we wait for acknowledgment before sending another
- Retry sending after a timeout and no acknowledgment

---

This seems simple. What can go wrong?

---

![Stop and Wait Lost ACK](media/arq-lost-ack.png)

---

![Stop and Wait Slow ACK](media/arq-slow-ack.png)

Duplicate frames
----------------

- If we acknowledge a frame, but the ACK doesn't arrive in time, the frame will be retransmitted
- This will appear to be a *new* frame, causing data duplication
- We can solve this using 1-bit sequence number

---

![Stop and wait with 1-bit sequence number](https://book.systemsapproach.org/_images/f02-18-9780123850591.png){height=540px}

Stop and wait limitation
------------------------

Our max data rate will be capped by our frame size and RTT

Key idea
--------

Our delay bandwidth product represents the amount of data we need to be able to send without acknowledgment to optimize throughput

Sliding Window
==============

---

- Send multiple frames at once
- Wait for acknowledgments before sending more
- Adjust window size as needed

Sender Algorithm
-----------------

- Assign unique and incrementing SeqNum value to frames
- Send window size (SWS) - limits outstanding frames
- Last acknowledgement received (LAR) - SeqNum of last ACK
- Last frame sent (LFS) - SeqNum of last sent frame
- `LFS - LAR <= SWS` must always be true

---

![Sliding Window](https://book.systemsapproach.org/_images/f02-20-9780123850591.png)

Sender Algorithm
----------------

- When ACK arrives LAR is incremented appropriately and a frame is sent
- Timeouts are used to retransmit frames that aren't acknowledged
- The senders must buffer SWS previous frames

Receiver Algorithm
------------------

- Receive window size (RWS) - upper bound of out-of-order frames to accept
- Largest acceptable frame (LAF) - SeqNum of the highest frame we would accept
- Last frame received (LFR) - SeqNum of the last frame received
- LAF - LFR <= RWS will always be true

---

![Receiver sliding window](https://book.systemsapproach.org/_images/f02-21-9780123850591.png)

Receiver algorithm
------------------

- If LFR < SeqNum <= LAF an incoming frame can be accepted. Otherwise, it is dropped
- Send an ACK for the highest SeqNum for which all lower frames have been correctly received

Out of order packets
--------------------

- No ACK for packets that come early, but buffer them
- Cumulative ACK when appropriate
- We could send a negative acknowledgement when we miss a packet, but we typically don't as it adds additional overhead

Out of order packets
--------------------

- These are impossible on most point-to-point links (aside from retransmission due to errors)
- They become possible as systems get more complex and packets can take multiple routes to a destination

Selective Acknowledgement
-------------------------

- Acknowledge every frame, as opposed to cumulative acknowledge where we batch acknowledgement for previous frames
- Adds complexity
- Increases traffic
- May improve overall throughput, as retransmission can happen faster

Window size
-----------

- Ideal sender window is related to bandwidth delay product
- Receiver window can be 1 to not require buffer and drop out of order packets
- SWS can be equal to RWS to appropriately buffer any packets that are usable

Sequence number overflow
------------------------

- On real networks, the sequence number is finite
- This means overflow is possible
- [Overflow example](https://replit.com/@jncraton/int-overflow)

Sequence number considerations
------------------------------

- Smaller sizes reduce overhead, but require reuse to happen sooner
- The max safe SWS is related to MaxSeqNum on a point-to-point link
- If frames can be reordered in transit, we need a more comprehensive solutions

Sliding Window Protocol Benefits
--------------------------------

1. Reliable delivery over unreliable channel
2. Reordering for out-of-order frames
3. Basic flow control

2.6 Multi-access networks
=========================

Multi-access
------------

- Hosts share the same link

CSMA/CD
-------

- We need to ensure the channel is quiet before sending (carrier sense)
- We need to stop transmitting if someone else start (collision detection)

History
-------

- Basic algorithm similar to ALOHA
- Used in older Ethernet, but not in modern switched Ethernet
- Used in modern 802.11

ALOHA
-----

- Send data if you have it to send
- Listen to transmission rebroadcast. If it is not your message, you need to resend

---

![Pure ALOHA collisions](https://upload.wikimedia.org/wikipedia/commons/3/35/Pure_ALOHA1.svg)

Slotted ALOHA
-------------

- Introduce time slots for transmission

---

![Slotted Aloha](https://upload.wikimedia.org/wikipedia/commons/7/7a/Slotted_ALOHA.svg)

---

![Pure vs Slotted Efficiency](https://upload.wikimedia.org/wikipedia/commons/a/a5/Aloha_PureVsSlotted.svg)

Ethernet
========

---

![Ethernet Bus](https://book.systemsapproach.org/_images/f02-22-9780123850591.png)

Bus
---

- All hosts are connected to the same medium
- If hosts use the medium at the same time, collisions will occur
- We need to minimize collisions while maximizing time that the bus is active to maximize throughput


Repeaters
---------

- Forward signals between networks
- Allow larger Ethernet networks
- Can create very large broadcast domain

---

![Repeaters connecting segments](https://book.systemsapproach.org/_images/f02-23-9780123850591.png)

Broadcast
---------

- All host receive all frames
- Hosts compete for bandwidth

Access Protocol
===============

---

We can hear all data as it is broadcast on the network, but we need to identify the data that matters to us.

Ethernet Frame
--------------

- 64 bit preamble to allow synchronization
- 6 byte source MAC address
- 6 byte destination MAC address
- 2 byte type field
- Payload
- 4 byte CRC

---

![Ethernet frame](https://book.systemsapproach.org/_images/f02-25-9780123850591.png)

Addresses
---------

- Assigned to an adapter at manufacture time
- Does not need to be allocated by a system on the network like IP addresses

Frames passed up by receiver 
----------------------------

- Frames addressed to its own address
- Frames addressed to the broadcast address
- Frames addressed to a multicast address, if it has been instructed to listen to that address
- All frames, if it has been placed in promiscuous mode

Transmitter Algorithm
---------------------

- If line is idle, and we have data to send, send it
- When we have a frame to send and the line is busy, we wait to transmit until the line is idle and send immediately

---

![Collisions](https://book.systemsapproach.org/_images/f02-26-9780123850591.png){height=500px}

Collisions
----------

- If we detect a collision, we send a jamming signal so others detect the collision and try again after some delay.
- If we experience multiple collisions, our delay increases by some factor (*exponential backoff*)

Why Ethernet?
=============

Ethernet has been dominant for around 40 years
----------------------------------------------

- Components (copper, fiber, NICs) are cheap
- Complex switching hardware is not required
- Backwards compatibility while adding improvements
- Administration is simple (no addresses to manage, etc)
