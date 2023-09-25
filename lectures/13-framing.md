2.3 Framing
===========

Frames
------

We now know how to exchange bitstreams between nodes on a network.

We need to develop algorithms and protocols to handle *frames* to build a packet-switched network over the bitstream.

---

![Bits between adapters become frames seen by hosts](https://book.systemsapproach.org/_images/f02-06-9780123850591.png)

---

We'll look specifically at point-to-point links, but the same basic techniques apply to broadcast links as well.

Byte-oriented protocols
=======================

---

View frames as collection of bytes rather than simple bits

Examples
--------

- BISYNC - IBM protocol from the 60s
- DDCMP - Used by DEC in DECNET
- PPP - Point-to-point protocol, a modern approach

Sentinel values
---------------

- Used to denote start and end of frames in some protocols
- Also known as flag bytes

BISYNC
------

- SYN - synchronization - indicates start of frame
- STX - start of text section
- ETX - end of text

---

Sentinel characters are just a byte. What if we need to send this byte in our data?

Byte stuffing
-------------

- Escape special characters when used in data
- Also escape the escapes

C Example
---------

```c
printf("Double quote: \"");
printf("Backslash: \\");
```

Length field
------------

Instead of using sentinel values, we can transmit a frame length and count bytes

---

What if a bit error causes the length or flag byte to be changed?

Framing Errors
--------------

- Bit error in length will cause adapter to read to much or too little data
- Bit error in flag will also cause frames to be misunderstood

Point-to-point protocol (PPP)
-----------------------------

- Common protocol used by many types of links
    - Fiber
    - Dial-up
    - Point-to-point radio
- Uses flag bytes and byte stuffing

---

What if errors occur in our data?

---

Include a checksum (we'll cover this more next time)

---

![PPP frame](https://book.systemsapproach.org/_images/f02-08-9780123850591.png)

Bit-oriented protocols
======================

---

Bit-oriented protocols are not concerned with byte boundaries

High-Level Data Link Control (HDLC)
-----------------------------------

- Developed by IBM
- Became ISO standard
- Bit-oriented protocol

---

![HDLC Frame](https://book.systemsapproach.org/_images/f02-10-9780123850591.png)

Bit flags
---------

- 0b01111110 denotes start and end of frame

Bit stuffing
------------

- Required when we want to send flag bit sequence in data
- Sender - 5 consecutive literal 1s (0b11111) will be encoded as 0b111110
- Receiver - When 0b111110 is seen, the 0 is dropped

Bit and byte stuffing
---------------------

- When these techniques are used, the length of the frame will be determined by contents of the data we are sending
- e.g. 8 data bytes could be 8, 9, or 10+ bytes on the wire

Clock-based Framing
===================

---

Synchronous Optical Network (SONET)
-----------------------------------

- Common fiber protocol
- Frames will always be the same size, regardless of payload contents
- Does not use stuffing

---

How do we know when a frame begins?

---

- We still use a flag pattern to indicate the frame boundary
- We know it may appear in data, so we implement a clock to determine when it is expected
- The clock can be synced initially by listening to multiple frames

---

![STS-1 SONET Frame](https://book.systemsapproach.org/_images/f02-11-9780123850591.png)

Overhead bytes
--------------

- Not covering in detail in this class
- Allow additional features, such as multiplexing

Encoding
--------

- SONET uses NRZ
- How do we ensure there are enough transitions for clock recovery and DC balance?

Scrambling
----------

- Data is XOR'd with a 127 bit known pattern
- This process makes it unlikely that the data stream will include long runs of the same value

---

What if someone wants to break our network?

Scrambling DOS
--------------

- If the scrambling bit pattern is known and fixed, it is trivial to craft a payload that results in a long repeated sequence
- This will cause framing, clocking, and DC balance issues and practically disable a link

Solution
--------

- [RFC2615](https://tools.ietf.org/html/rfc2615##section-4)
- Introduce a self-synchronizing, rotating scrambling pattern that is difficult to guess

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
