
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
