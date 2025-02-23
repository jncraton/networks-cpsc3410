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
