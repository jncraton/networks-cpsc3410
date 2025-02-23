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
