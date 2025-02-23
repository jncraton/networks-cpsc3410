Cost-effective resource sharing
===============================

---

- Focusing on a packet switched networks, we can see that resources (such core links) are constantly being shared
- How do we ensure that shared resources are used fairly?

---

![Multiplexing multiple flows over one link](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Multiplexing_diagram.svg/640px-Multiplexing_diagram.svg.png)

---

![Synchronous Time-division multiplexing (STDM)](https://upload.wikimedia.org/wikipedia/commons/e/e0/Telephony_multiplexer_system.gif){height=262px}

Frequency division multiplexing
-------------------------------

- Breaks link into subchannels and uses one for each device
- You're familiar with this in TV and radio
- Wifi channels are also an example

Weaknesses
----------

- Both FDM and STDM waste available resources
- Bandwidth is reserved for all hosts, even when they don't need it
- Number of flows must be known in advance

Statistical multiplexing
------------------------

- Link is shared over time
- Data is transmitted from each flow on demand without waiting for hosts with nothing to say
- One flow may only consume the link for a given amount of time

Quality of Service (QoS)
------------------------

- Various algorithms can be chosen to determine who sends on the medium
    - First-in, first-out (FIFO)
    - Flow-based round-robin
    - Much more complex algorithms

Big idea
--------

Statistical multiplexing allows fair sharing of a link


Support for Common Services
===========================

---

We don't merely want to send packets around, we want to provide service that makes it easy to build applications

Channels
--------

- We think of the network as providing *channels* for individual applications to communicate
- Layering is used to create this channel abstraction on top of packet-switched networks

Channel needs
-------------

- Reliability - Do messages need to arrive?
- Privacy - Can others see our messages?
- Ordering - Do messages need to arrive in the order they were sent?

Big idea
--------

Different applications will have different needs, so we need to design different abstractions that work well for them.

Manageability
=============

---

Networks have to be managed and maintained

Common tasks
------------

- Replacing hardware
- Adding hosts
- Troubleshooting issues

Self-healing designs
--------------------

- Allow humans to be removed from the loop, or at least have a less urgent role

Change management
-----------------

- There is often a tension between *feature velocity* and *stability*
- Any time something is changed, there is a chance that it will cause breakages 
