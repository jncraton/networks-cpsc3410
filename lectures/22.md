Error Reporting (ICMP)
======================

Internet Control Message Protocol
---------------------------------

- Acts as a sidechannel for communicate the status of messages

ICMP Uses
---------

- Communicates errors (host unreachable, checksum error, etc)
- ICMP echo requests (ping) can be used to check if a host is up
- ICMP redirect to learn better routes
- Provides building blocks for traceroute

Virtual Networks and Tunnels
============================

Private Networks
----------------

- Corporations with multiple locations might wish to connect their networks
- This can be done over the Internet
- It can be done more securely by leasing private connections between the networks

Virtual Private Networks
------------------------

- It can be more cost-effective to encrypt traffic between networks rather than lease a dedicated connection

---

![a - private network, b - VPN](https://book.systemsapproach.org/_images/f03-26-9780123850591.png){height=540px}

---

Can a VPN be used for other purposes?

Tunnels
-------

- We can send IP traffic or other network traffic over another IP connection
- This can be used to encrypt connections or provide access to other systems

SSH Tunnel Example
------------------

```
ssh -R remote_port:localhost:local_port user@host
```

This allows a local server application to become accessible from a different host.

SSH Proxy Example
-----------------

```
ssh -D [bind_address:]port remote_host
```

This creates a local SOCKS proxy to forward traffic via `remote_host`
