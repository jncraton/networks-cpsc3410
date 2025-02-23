6.3 TCP Congestion Control
==========================

Overview
--------

- CongestionWindow is managed by sender to limit packets in flight and transmission speed

Congestion Window
-----------------

- Set based on perceived network congestion
- Packet timeouts are used to adjust window size
- Additive Increase/Multiplicative Decrease

---

![Additive Increase](https://book.systemsapproach.org/_images/f06-08-9780123850591.png){height=540px}

---

Why use additive increase and multiplicative decrease?

Window Adjustment
-----------------

- Halve window size on each timeout
- Add 1 to window size on each successful round trip
- In practice, we increase window size for each ACK

---

![Sawtooth Congestion Window over time](https://book.systemsapproach.org/_images/f06-09-9780123850591.png)

Slow Start
----------

- TCP originally sent as many packets as the advertised window would allow when starting connections
- This caused congestion issues, and the behavior was changed to double the congestion window on each ACK at the start of a connection
- Slow start is also used when the connection is dead after waiting for a timeout

---

![TCP Slow Start](https://book.systemsapproach.org/_images/f06-10-9780123850591.png){height=540px}

Fast Retransmit
---------------

- Ordinarily, we wait for a coarse-grained timeout before sending a packet
- A receiver can safely send ACKs for all packets, using the sequence number of the last packet received in order
- By listening for duplicate ACKs, a sender can deduce lost packets and retransmit them

---

![Fast retransmit based on duplicate ACKs](https://book.systemsapproach.org/_images/f06-12-9780123850591.png){height=540px}

TCP CUBIC
---------

- Alternative congestion window management algorithm
- Default algorithm used by Linux

Max Window Size
---------------

- TCP CUBIC tracks the largest congestion window it was able to use successfully before experiencing congestion
- After a congestion event, CUBIC attempts to return to this window size at a cubic rate
- It approaches slowly, plateaus for, and then attempts to probe for a larger max window

---

![TCP CUBIC congestion window adjustment](https://book.systemsapproach.org/_images/Slide11.png)

6.5 Quality of Service
======================

QoS
---

- Applications have different needs
- A network that supports these different needs is said to support Quality of Service (QoS)

Requirements
------------

- Bandwidth
- Latency
- Jitter
- Packet loss

---

![Audio Example](https://book.systemsapproach.org/_images/f06-20-9780123850591.png)

Buffering
---------

- Audio is broken into time slices and sent as packets
- Packets are buffered and played back

---

![Playback Buffer](https://book.systemsapproach.org/_images/f06-21-9780123850591.png)

Buffer size
-----------

- A larger buffer will be more resistant to jitter and packet loss
- A larger buffer also induces delay

Application Needs
-----------------

- Real-time vs elastic
- Intolerant to packet loss
- Able to adapt to different level of bandwidth by adjusting rate
- Able to adapt to jitter and latency using larger buffers

---

![Application Characteristics](https://book.systemsapproach.org/_images/f06-23-9780123850591.png)

QoS Approaches
--------------

- Fine-grained - make adjustments by flow or application
- Course-grained - provides different levels of services to large classes of data

Service Classes
---------------

- Best-effort - default service
- Guaranteed service - ensures delivery under a maximum delay threshold
- Controlled load - operates like the network is lightly loaded up to a certain bandwidth constraint

Mechanism
---------

- Request service by sending a flowspec
- Admission control determines if service is available
- Packet scheduling works to meet flowspec requirements

Traffic Characteristics
-----------------------

- Maximum delay
- Bandwidth

Bandwidth
---------

- May vary over time (example: compressed video)
- An average and/or upper and lower bound can be useful
- A token bucket can be used to implement an average bandwidth
- Bucket rate communicates average and bucket depth handles bursts

---

![Flows with identical average bitrate but different bucket specs](https://book.systemsapproach.org/_images/f06-24-9780123850591.png)

Admission Control
-----------------

- Only allow new flows we are confident we can service
- Requires knowledge of routing algorithms and network state

Scheduling
----------

- When packets arrive related to a given service, ensure they are delivered meeting the needs of the service
- Can be implemented with something like weighted fair queuing or a similar algorithm

Scalability
-----------

- An integrated services model suffers from scalability issues
- This model has not been widely deployed on the Internet

Differentiated Services
-----------------------

- Skips complexity of requesting service
- Tags certain packets as "premium" to be delivered first
- Routers should forward these packets at a higher priority

---

Who gets to set the packet priority?

Setting priority
----------------

- If hosts can set high priority, they might all do that selfishly
- Bit may be set by border routers
- Can be used on local networks where hosts are trusted
- Can be used to prioritize particular packets from a given host
