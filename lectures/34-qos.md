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

8 Network Security
==================

---

- [Stealing a Tesla using Bluetooth](https://www.youtube.com/watch?v=clrNuBb3myE)
- [Details](https://www.wired.com/story/tesla-model-x-hack-bluetooth/)

Threats
-------

- Our systems are designed with trust and threats in mind
- There are usually trade-offs to be made to prevent certain threats on our systems

Examples
--------

- A passive attacker trying to view wireless network traffic
- An active attacker trying to disrupt a wireless network
- An attacker physically inside a building trying to gain unauthorized access
- An employee with network access elevating that access

Encryption
----------

- A function is applied to a *plaintext* message to create a *ciphertext*
- The ciphertext can be read by anyone, but it should only be able to be converted back to the plaintext by the intended parties
- Receivers apply a decryption function to convert the ciphertext back to the plaintext

Secret Key Ciphers
------------------

- Both parties must possess the same secret key
- Examples include DES, Blowfish, and AES
- Solves the encryption problem, but creates a key distribution problem

---

![Secret Key Encryption](https://book.systemsapproach.org/_images/f08-01-9780123850591.png)

Example
-------

Encryption

```sh
openssl enc -aes-256-cbc -out {file}
```

Decryption

```sh
openssl enc -d -aes-256-cbc -in {file}
```

Public-Key Ciphers
------------------

- Address key distribution issues
- Use a private key for decryption, but a public key can be shared with others that is used to create a ciphertext
- Examples include RSA and Elliptic-curve cryptography (ECC)

---

![Public Key Encryption](https://book.systemsapproach.org/_images/f08-03-9780123850591.png){height=540px}

Public key Authentication
-------------------------

- A private key can also be used to encrypt messages
- These messages can be decrypted using the public key
- This provides no privacy, but ensures that the sender holds the private key

---

![Public Key Authentication](https://book.systemsapproach.org/_images/f08-04-9780123850591.png)

Authenticator
-------------

- Value included with a message to verify that it has not been tampered with and contains no errors
- Commonly a hashed message authentication code (HMAC)
- HMAC hashes a known secret value appended to the plaintext

---

![MAC and HMAC](https://book.systemsapproach.org/_images/f08-05-9780123850591.png)

Example Systems
---------------

SSH
---

- Modern and secure remote access protocol replacing telnet
- Built over TCP adding encryption (often AES)
- Public keys of servers are sent on first connection and stored locally
- Passwords or private keys are used for user authentication

---

![SSH Port Forwarding](https://book.systemsapproach.org/_images/f08-14-9780123850591.png)

Transport Layer Security
------------------------

- TLS builds on TCP to create an encrypted transport stream
- Handshake negotiates protocols to use
- Secret key is exchanged

---

![TLS in Network Stack](https://book.systemsapproach.org/_images/f08-15-9780123850591.png)

---

![TLS Handshake](https://book.systemsapproach.org/_images/f08-16-9780123850591.png){height=540px}

Certificate Authority
---------------------

- Provide public key certificates
- Ensures that user is connecting to the system they are expecting to connect to
- Certificates can be purchased, but some services offer free certificates

TLS Benefits
------------

- Encryption - Messages can't be viewed by others
- Authentication - Messages can't be tampered with

Firewall
--------

- Sits between a local network and the outside world blocking unauthorized traffic

Intrusion Detection System
--------------------------

- Monitors the local network for anomalous behavior
- Alerts network administrators to possible threats and attacks

9.1 Applications
================

World Wide Web
--------------

- The World Wide Web is not the Internet
- The Internet is a global network of networks connecting most modern computing systems
- The World Wide Web is a set of interconnected hypertext documents

Hypertext
---------

Documents with links to other documents that are immediately accessible

Uniform Resource Identifier (URI)
---------------------------------

- A string used to concretely identify a document, image, service, or other resource
- Does not inherently provide location or access info
- Example: doi:10.48550/arXiv.1706.03762

URI Components
--------------

```
URI = scheme ":" ["//" authority] path ["?" query] ["#" fragment]
```

Uniform Resource Locator (URL)
------------------------------

- The web commonly uses a specific type of URI called a URL
- Includes identification and access mechanism
- Example: https://en.wikipedia.org/wiki/URL


Hypertext Transfer Protocol (HTTP)
----------------------------------

- Used initially to transmit hypertext documents on the web
- Combines URI with verbs to perform operations

---

+-----------+-----------------------------------------------------------+
| Operation | Description                                               |
+===========+===========================================================+
| GET       | Retrieve document identified in URL                       |
+-----------+-----------------------------------------------------------+
| POST      | Give information (e.g., annotation) to server             |
+-----------+-----------------------------------------------------------+
| PUT       | Store document under specified URL                        |
+-----------+-----------------------------------------------------------+
| DELETE    | Delete specified URL                                      |
+-----------+-----------------------------------------------------------+

Simple HTTP Request
-------------------

Requests the root document from a host.

```
GET / HTTP/1.1
```

Simple HTTP Response
--------------------

Indicates that the document is not available.

```
HTTP/1.1 404 Not Found
```

---

+------+---------------+--------------------------------------------------------+
| Code | Type          | Example Reasons                                        |
+======+===============+========================================================+
| 1xx  | Informational | request received, continuing process                   |
+------+---------------+--------------------------------------------------------+
| 2xx  | Success       | action successfully received, understood, and accepted |
+------+---------------+--------------------------------------------------------+
| 3xx  | Redirection   | further action must be taken to complete the request   |
+------+---------------+--------------------------------------------------------+
| 4xx  | Client Error  | request contains bad syntax or cannot be fulfilled     |
+------+---------------+--------------------------------------------------------+
| 5xx  | Server Error  | server failed to fulfill an apparently valid request   |
+------+---------------+--------------------------------------------------------+

TCP Connections
---------------

- HTTP is built on top of TCP
- It's usage has evolved between 1.0, 1.1 and 2.0
- HTTP/3 uses QUIC

---

![HTTP/1.0 Connections](https://book.systemsapproach.org/_images/f09-04-9780123850591.png){height=540px}

---

![HTTP/1.1 Connections](https://book.systemsapproach.org/_images/f09-05-9780123850591.png)

Caching
-------

- We can improve latency and reduce bandwidth by storing resources that we've already used
- Most browser will manage a cache of previously seen resources and not request them again until they expire
- Proxy and reverse proxy servers can also be used for caching purposes

---

![Reverse proxy](https://upload.wikimedia.org/wikipedia/commons/6/67/Reverse_proxy_h2g2bob.svg)

Web Services
------------

- We can use use HTTP to build web services to perform tasks and not merely deliver static documents
- Many standard (WSDL, SOAP) and non-standard mechanisms are used to build interfaces to web services
- Many services build a new protocol on top of HTTP

Representational State Transfer (REST)
--------------------------------------

- Uses standard HTTP verbs to interact with a service at a URL
- Uses custom media types to represent datagrams
- Stateless protocol that does not require the server to maintain per-session state

9.3 Infrastructure Applications
===============================

Name Service (DNS)
------------------

Addressing
----------

- IP addresses are used to identify hosts
- They aren't user friendly
- They can change as networks change

Name services
-------------

- Middleware to fill gap between application and network
- Convert human-readable names to addresses

Namespace
---------

- Set of possible names
- Flat namespaces
- Hierarchical namespaces

Resolution Mechanism
--------------------

- Returns the value bindings for a particular name
- Often, this will be addresses returned by a *name server*

Early Implementation
--------------------

- When the Internet was small, all hosts managed a mapping of names to addresses
- This can still be found in `/etc/hosts` on most systems
    - `C:\Windows\System32\Drivers\etc\hosts` on Windows
- Name lookups were performed against this local table

Name servers
------------

- Used to perform name lookups in modern systems
- Track and cache global name mappings

---

![Name lookup process](https://book.systemsapproach.org/_images/f09-14-9780123850591.png)

Protocol
--------

- Typically uses UDP port 53
- A query is sent to name server
- The name server responds with appropriate resource records (RRs) to answer the query

Wireshark
---------

- `udp port 53` capture filter

Domain Hierarchy
----------------

- Modern names are broken into domains
- Name servers then service the part of the hierarchy they are responsible for

---

![Domain hierarchy](https://book.systemsapproach.org/_images/f09-15-9780123850591.png)

---

![Name server hierarchy](https://book.systemsapproach.org/_images/f09-17-9780123850591.png)

---

Name resolution
---------------

- Local nameserver is queried
- If it has the appropriate value cached, it returns it
- Otherwise, it queries the appropriate name server

---

![Name resolution process](https://book.systemsapproach.org/_images/f09-18-9780123850591.png){height=540px}
