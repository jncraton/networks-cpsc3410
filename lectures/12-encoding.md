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
