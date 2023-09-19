1.5 Performance
===============

Bandwidth and Latency
=====================

Two measures of performance
---------------------------

- Bandwidth (throughput) - Number of bits per time
- Latency (delay) - Time needed to send

Bandwidth
---------

- Refers to two separate concepts both related to computer networks
- Digital bandwidth (MB/s)
- Analog bandwidth (MHz)

---

![Width of bits in time](https://book.systemsapproach.org/_images/f01-16-9780123850591.png)

Latency
-------

Time it takes for data to arrive

Latency Components
------------------

- Propagation time (Distance / speed of light)
- Transmit time (Size / Bandwidth)
- Queuing delay (related to congestion)

Performance
-----------

- Bandwidth and latency combined tell us a lot about the performance of a channel
- Bandwidth and latency are distinct but often related

---

![RTT and perceived latency](media/rtt-vs-latency.png)

Bandwidth Delay Product
=======================

---

![Bandwidth Delay Product](https://book.systemsapproach.org/_images/f01-18-9780123850591.png)

Why calculate bandwidth delay product?
--------------------------------------

- Amount of data sent before any arrives
- Related to window size in transmission protocols

---

Link Type             Bandwidth  One-Way Distance  RTT     RTT x Bandwidth
---------             ---------  ----------------  ---     ---------------
Wireless LAN          54 Mbps    50 m              0.33 μs 18 bits
Satellite             1 Gbps     35,000 km         230 ms  230 Mb
Cross-country fiber   10 Gbps    4,000 km          40 ms   400 Mb

High-speed networks
===================

---

- Network bandwidth continues to increase
- Network latency is bounded by physics

---

![1MB file on 1Mbps vs 1Gbps link](https://book.systemsapproach.org/_images/f01-19-9780123850591.png)

---

As networks become faster, latency become the limiting factor for performance.

---

Any degradation that requires additional round trips will significantly hurt total real bandwidth

Application Performance
=======================

---

Applications may have specific performance requirements

Known application requirements
------------------------------

- Fixed bandwidth (VOIP, video chats, gaming, etc)
- Minimum latency requirements
- Jitter requirements

Jitter
------

- Change in latency from one time to another
- Can cause buffer underflow
- Can cause gaps in voice transmissions

![Network-induced jitter](https://book.systemsapproach.org/_images/f01-20-9780123850591.png)


2.1 Technology Landscape
========================

Connecting to a Network
=======================

---

- There exist basic problems in connecting to any network
- Medium (wire, optical, RF, etc)

Specific Issues
---------------

- Encoding - how bits represented
- Framing - how we begin and end
- Error detection - how we know it worked
- Reliability - how we fix errors
- Media Access control - how we decide who can talk

---

![End User Connections](https://book.systemsapproach.org/_images/f02-01-9780123850591.png)

Link Types
----------

- FTTH - PON
- Mobile - 4G, 5G
- Laptops - Wifi
- Desktops - Wired Ethernet
- Servers - Wired Ethernet, Fiber

Abstraction
-----------

We want to hide the differences between links and deliver a simple bitstream interface

Link Characteristics
--------------------

- Material - Copper, optical, RF, etc
- Frequency (analog bandwidth)

---

![EM Spectrum](https://book.systemsapproach.org/_images/f02-02-9780123850591.png)

---

Physical links are fundamentally analog

Digital to Analog
-----------------

- Modulation - Representing 1s and 0s "on the wire"
- Encoding - Converting binary data to 1s and 0s to put on the wire

Fourier Series
--------------

- Any repeating signal can be represented by the sum of sines and cosines

---

![Fourier Series](https://upload.wikimedia.org/wikipedia/commons/7/72/Fourier_transform_time_and_frequency_domains_%28small%29.gif){height=480px}

---

Why should we care?

---

Instantaneous change requires infinite frequency to perfectly represent. 

Physical channels have limited analog bandwidth, so they cannot perfectly represent digital signals.

---

![Oscilloscope Output](media/scope-output.jpeg)

Nyquist and Shannon
-------------------

- Proved several theorems regarding the maximum digital bandwidth of a channel

Nyquist
-------

$\textrm{maximum data rate} = 2B \times log_2{(V)} bits/sec$

- B is analog bandwidth
- V is the number of discrete signal levels

Shannon
-------

Real channels have noise

$\textrm{maximum data rate} = B \times log_2{(1 + {S \over N})} bits/sec$

- S is signal
- N is is noise
- This term can be referred to as signal to noise ratio (SNR)

Key concept
-----------

There are physical limits to how much data can be sent down a given physical medium

Modulation
----------

- Amplitude
- Frequency
- Phase
- QAM

---

![QAM Example](https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/QAM16_Demonstration.gif/220px-QAM16_Demonstration.gif)

2.2 Encoding
============

---

How do we correctly communicate a stream of bits down a medium that we can turn on and off?

---

Network adapter
---------------

- Performs bitstream encoding
- We'll assume that *modulation* has been handled, and we have a medium that we can make either high or low

Examples
--------

- Light in a fiber cable
- Voltage on a serial cable (high or low)
- ASK for a Wifi signal

---

![Bits flowing between adapters](https://book.systemsapproach.org/_images/f02-03-9780123850591.png)

---

Non-return to zero (NRZ) encoding
---------------------------------

- High maps to 1
- Low maps to 0

---

![NRZ Encoding](https://book.systemsapproach.org/_images/f02-04-9780123850591.png)

Problems with NRZ
-----------------

Long strings of 1s or 0s in data cause problems with

- Baseline wander
- Clock recovery

Baseline Wander
---------------

- Receiver stores a moving average of the signal level
- A steady state causes the average to move too high
- This can lead to value being misread

Clock
-----

- Determines when to read the medium to determine the current bit value

Clock Recovery
--------------

- Clocks at senders and receivers are not perfectly synced
- We resync clocks at state transitions
- Too few state transitions can lead to clocks drifting apart

---

Fireflies
---------

- Can flash at night
- Some species can synchronize their flashes

---

[Interactive Fireflies](https://ncase.me/fireflies/)

Non-return to zero inverted (NRZI)
----------------------------------

- State change represents a 1
- Steady state represents a 0
- Solves issue with repeated 1s
- Doesn't help with repeated 0s

Manchester Encoding
-------------------

- XOR an explicit clock signal with the data signal
- We always have state transitions
- Requires 2x data rate
- Used by Fast Ethernet

---

![Encoding schemes](https://book.systemsapproach.org/_images/f02-05-9780123850591.png)

4B/5B
-----

- Encode all 4 bit sequences as 5 bit sequences with state transitions
- e.g. 0000 becomes 11110
- Ensure state transition with less overhead than Manchester encoding
- USB uses variants of this (10b/12b, 128b/132b)

Baud rate vs bit rate
---------------------

- Baud rate - symbols per time
- Bit rate - bits per time
- These can be the same if we transmit 1 bit per symbol
