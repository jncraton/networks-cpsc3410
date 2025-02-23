7.2 Multimedia Data
===================

Images
------

- Made up of a 2d array of pixels
- May be a single bit value for monochrome images
- May be several bytes to represent a wide array of colors

---

![Pixel](https://upload.wikimedia.org/wikipedia/commons/2/2b/Pixel-example.png)

Video
-----

- A series of images (frames)
- Commonly 24, 30, 48, or 60 per second

Data Requirements
-----------------

- A modern 4k60 video stream will require $3840 \times 2160 \times 24 \times 60 = 11.94 gbps$ of bandwidth
- A 2k30 stream will still be over 1 gbps
- This amount of data is not serviceable by mainstream network technologies in use today
- Modern techniques can bring the bandwidth requirements for the stream down to ~30 mbps

Compression
-----------

- Use fewer bytes to transmit information
- Lossless compression - information is transmitted exactly
- Lossy compression - some information is lost

Run-length Encoding
-------------------

- Lossless compression
- Encodes runs of the same type
- AAAAABBBBCDDDDDD -> 5A4B1C6D

Dictionary Methods
------------------

- Lossless compression
- Replace words or phrases with references to words or phrases in a known dictionary

Huffman Code
------------

- Lossless compression
- Use fewer bits for common words and more bits for less common words

---

![Huffman tree example](https://upload.wikimedia.org/wikipedia/commons/8/82/Huffman_tree_2.svg){height=540px}

Image Compression
-----------------

- Palettes
- Subsampling
- Transforms - DCT, Wavelet, etc
- Quantization
- Encoding

Palettes
--------

- Lossless
- Use only a fraction of all possible colors for an image
- Decreases bits needed per pixel
- Lossy if color information is discarded to reduce palette size

Subsampling
-----------

- Humans are more perceptive to changes in color than brightness
- We can use more pixels for brightness than for color

---

![YUV Subsampling](https://book.systemsapproach.org/_images/f07-11-9780123850591.png)

JPEG Compression
----------------

- Subsampling
- DCT
- Quantization
- Encoding

---

![JPEG compression](https://book.systemsapproach.org/_images/f07-12-9780123850591.png)

Discrete Cosine Transform
-------------------------

- [DCT](https://en.wikipedia.org/wiki/Discrete_cosine_transform)
- Transforms an image from the 2d dimension to the spatial frequency dimension
- Small changes from one pixel to the next are low frequencies, large changes are high frequencies

---

![DCT Table](https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/Dct-table.png/480px-Dct-table.png)

---

![Iterative DCT for capital letter A](https://upload.wikimedia.org/wikipedia/commons/5/5e/Idct-animation.gif)

Quantization
------------

- DCT is lossless and saves no space
- Quantization rounds the DCT values
- Many values become 0

Encoding
--------

- The order of the DCT values is chosen to maximize long runs of zeroes
- RLE is use on runs of zeroes
- Additional lossless compression is used on remaining values

---

![JPEG encoding pattern](https://book.systemsapproach.org/_images/f07-13-9780123850591.png)

Video Compression
-----------------

- Apply image compression techniques
- Take advantage of similarity between frames

MPEG Frame Types
----------------

- I-frame - Intrapicture, reference frame, depends on no other frames
- P-frame - Predicted, difference from previous I-frame
- B-frame - Bi-directional predicted, difference from surround I and P frames

---

![MPEG Frame Types](https://book.systemsapproach.org/_images/f07-14-9780123850591.png)

Macroblocks
-----------

- 8x8 YUV information is stored together in 16x16 macroblocks

---

![Macroblock](https://book.systemsapproach.org/_images/f07-15-9780123850591.png)

Representing Predicted Frames
-----------------------------

- 2d array of macroblocks
- Macroblocks include motion vectors to reference frame(s)
- Macroblocks are encoded as difference from reference blocks
