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
