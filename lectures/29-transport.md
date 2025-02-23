5.1 Simple Demultiplexor (UDP)
==============================

---

IP Addressing
-------------

- The IP layer provides a way to address packets to a given host
- We need a way to route data to the appropriate process on a given host

Ports
-----

- Used by UDP and TCP to identify processes

---

![UDP Header](https://book.systemsapproach.org/_images/f05-01-9780123850591.png)

Learning Ports
--------------

- Messages will include a `srcport` that can be used in replies
- IANA registers and publishes ports for common services (located in /etc/services on Unix-like systems)

---

![UDP Message Queue](https://book.systemsapproach.org/_images/f05-02-9780123850591.png){height=540px}

---

UDP Example
-----------

Server Listener

```
nc -u -l 9999
```

Client

```
nc -u 127.0.0.1 9999
```
