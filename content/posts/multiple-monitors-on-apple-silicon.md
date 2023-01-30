---
title: 'Multiple Monitors on Apple Silicon'
date: '2023-01-30'
description: 'How to run more than one external monitor on M1 and M2 Macs using DisplayLink.'
---

If you are reading this, you probably just discovered that your second monitor isn't working when you connect it to your M1/M2 Mac. Surprise, those chips have only one video output and thus can only support one external monitor! Bummer...

To get around this, and move on with your life, you can use [DisplayLink](https://www.synaptics.com/products/displaylink-graphics) to output extra monitors via USB! Normally, connecting to an external monitor looks something like this:
{{<mermaid>}}
flowchart LR
Machine -- video --> Monitor
{{</mermaid>}}

With DisplayLink, that video signal gets compressed and outputted via USB. This data is then decompressed by a **DisplayLink adaptor** and outputted to the monitor as a video signal. That looks something like this:

{{<mermaid>}}
flowchart LR
Machine -- video --> DLS[DL Software] -- compressed --> DLA[DL Adaptor] -- video --> Monitor
{{</mermaid>}}

From my experience using it so far, it works pretty well! I have noticed some minor latency and flickering issues, but that is a small price to pay, I think, for gaining a second monitor.

So TLDR, to get a second monitor on M1/M2 Mac, you have to:

1. [Install DisplayLink](https://www.synaptics.com/products/displaylink-graphics/downloads).
2. [Buy a DisplayLink adaptor](https://www.synaptics.com/products/displaylink-graphics/displaylink-products-list) that is compatible with your monitor specs.
3. Plug and Display! {{< twa rocket >}}
