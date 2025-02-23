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
