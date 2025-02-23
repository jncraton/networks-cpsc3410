5.4 Transport for Real-Time
===========================

Real-time
---------

- Traditional uses of network (email, file transfers, etc) don't have real-time requirements
- Some more modern uses (VoIP, videoconferencing, etc) do have these requirements

Application Types
-----------------

- Interactive - two or more people communicating directly (Google Meet, VoIP)
- Streaming - data is being delivered and viewed immediately (Netflix, YouTube)

UDP
---

- Adds no additional latency
- Does not provide reliability
- Does not handle reordering

TCP
---


- Reliable
- Handles reordering
- Adds latency in case of errors or reordering

RTP
---

- Real-time protocol
- Designed to handle communication between a variety of interactive applications

---

![Common RTP Stack](https://book.systemsapproach.org/_images/f05-22-9780123850591.png)

Requirements
------------

- Coding scheme advertisement and selection
- Timestamping for continuous playback from buffer
- Stream sync
- Packet loss indication
- Usernames
- Limited overhead

Ports
-----

- Data is sent over an even-numbered UDP port
- Control information is sent over a port one higher

Handshaking
-----------

- Video protocol
- Voice protocol

---

![RTP Header](https://book.systemsapproach.org/_images/f05-23-9780123850591.png)

Header Fields
-------------

- V - version
- P - padding
- x - counts contributing sources
- m - marker bit (application specific use)
- pt - payload type to demultiplex streams

Timestamps
----------

- Indicate start time of first sample in packet
- Does not represent actual time, only relative time
- Time unit is left up to application

Synchronization Source
----------------------

- SSRC
- 32-bit self-assigned address
- Creates separation from IP protocol
- Allows multiple streams (e.g. cameras) from 1 IP address

Contributing Sources
--------------------

- A mixer may combine multiple streams into a single stream
- The SSRC values for the contributing sources will be listed by a mixer in the CSRC fields

Congestion Control
------------------

- TCP is not used for latency reasons
- We can't send data slower
- We can change parameters to send less data

Security
--------

- Unencrypted by default
- DTLS and SRTP can provide encryption

Control Protocol
----------------

- Feedback on the performance of the application and the network
- A way to correlate and synchronize different media streams that have come from the same sender
- A way to convey the identity of a sender for display on a user interface


Time Synchronization
-------------------

- RTCP packets include a mechanism to relate stream-specific timing information to clock time
