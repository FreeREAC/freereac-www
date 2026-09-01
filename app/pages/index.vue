<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
useSeoMeta({
  title: 'FreeREAC — open documentation and tools for Roland REAC',
  description:
    'An independent interoperability project documenting REAC, the audio-over-Ethernet protocol used by Roland digital mixers and stageboxes, and shipping tools to carry, convert and analyse it on commodity hardware.',
});
</script>

<template>
  <div>
    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 pt-20 pb-16 sm:pt-24">
        <p class="font-mono text-xs uppercase tracking-[0.2em] text-signal">
          REAC Exposed Audio Communications · EtherType 0x8819
        </p>
        <h1 class="mt-6 max-w-4xl font-display text-3xl font-semibold leading-[1.15] tracking-tight text-ink sm:text-5xl">
          A protocol nobody documented, documented.
        </h1>
        <p class="mt-8 max-w-3xl text-lg leading-relaxed text-ink-dim">
          REAC carries many channels of low-latency digital audio as flat Layer-2
          frames on a dedicated link. Roland's mixers and stageboxes speak it, and
          Roland publishes no specification for it. FreeREAC documents the wire format
          and the behaviour from its own packet captures, and ships tools to carry,
          re-clock, convert and analyse REAC on ordinary Linux machines and OpenWrt
          routers.
        </p>
        <p class="mt-5 max-w-3xl text-lg leading-relaxed text-ink-dim">
          The equipment is ours. The captures are ours. Everything published here is
          re-expressed in our own words and tables.
        </p>

        <div class="mt-10 flex flex-wrap gap-3">
          <UButton to="/protocol" size="lg" color="primary" trailing-icon="i-lucide-arrow-right">
            What is known
          </UButton>
          <UButton to="/tools" size="lg" color="neutral" variant="outline">
            The tools
          </UButton>
        </div>
      </div>
    </section>

    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="The shape of the project" title="Three things, and they compose." />
        <div class="grid gap-5 md:grid-cols-3">
          <article class="rounded border border-edge bg-surface/60 p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-signal">01</p>
            <h3 class="mt-3 font-display text-lg font-semibold tracking-tight text-ink">Document the wire</h3>
            <p class="mt-3 text-sm leading-relaxed text-ink-dim">
              A protocol reference with the frame layout, the control plane and the
              head-amp records, plus a machine-checkable grammar that parses real
              captures. Every statement carries how it is known.
            </p>
          </article>
          <article class="rounded border border-edge bg-surface/60 p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-signal">02</p>
            <h3 class="mt-3 font-display text-lg font-semibold tracking-tight text-ink">Build the tools</h3>
            <p class="mt-3 text-sm leading-relaxed text-ink-dim">
              A shared C library holding the byte-layout facts, a REAC-to-AES67
              converter that runs on a router, transport that carries REAC across an
              OpenWrt network, and analysis tools for captured traffic.
            </p>
          </article>
          <article class="rounded border border-edge bg-surface/60 p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-signal">03</p>
            <h3 class="mt-3 font-display text-lg font-semibold tracking-tight text-ink">Prove it on real hardware</h3>
            <p class="mt-3 text-sm leading-relaxed text-ink-dim">
              Against real Roland stageboxes and real consoles, on a real rig. A
              decoder that agrees with itself proves nothing; the only interesting
              question is whether the metal agrees.
            </p>
          </article>
        </div>
      </div>
    </section>

    <section class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <div class="grid gap-10 lg:grid-cols-[1fr_1fr]">
          <div>
            <SectionHead eyebrow="How to read this site" title="A measurement and a guess do not look alike here." />
            <div class="space-y-4 text-base leading-relaxed text-ink-dim">
              <p>
                Reverse engineering produces two very different kinds of statement, and
                a document that presents them in the same voice is worse than useless
                to anyone trying to build against it.
              </p>
              <p>
                So every protocol statement on this site is graded. Measured means it
                was observed on our own captures of our own equipment. From prior work
                means it comes from published open-source reverse engineering and we
                have not independently confirmed it. Open means we do not know, and
                the page says so rather than quietly rounding it up.
              </p>
              <p>
                The open list is not an embarrassment to be minimised. It is the part
                that tells you where a device might surprise you.
              </p>
            </div>
          </div>
          <div class="space-y-3">
            <div class="rounded border border-verified/40 bg-verified/5 p-5">
              <Provenance level="measured" />
              <p class="mt-3 text-sm leading-relaxed text-ink-dim">
                The downstream frame is 1492 bytes with a 16-bit little-endian sequence
                counter at the start of its payload. Both were read straight off our own
                captures, and the counter is what loss is computed from.
              </p>
            </div>
            <div class="rounded border border-signal/40 bg-signal/5 p-5">
              <Provenance level="derived" />
              <p class="mt-3 text-sm leading-relaxed text-ink-dim">
                Some of the earliest structure came from published open-source work by
                others. Where we have since re-derived it ourselves, it is marked
                measured; where we have not, it stays here.
              </p>
            </div>
            <div class="rounded border border-open/40 bg-open/5 p-5">
              <Provenance level="open" />
              <p class="mt-3 text-sm leading-relaxed text-ink-dim">
                We have never captured REAC at 44.1 kHz. The packet rate for it follows
                from a rule that holds at the two rates we have measured, and that is
                a model, not an observation.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section>
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Why" title="A stagebox outlives the desk that came with it." />
        <div class="grid gap-10 lg:grid-cols-2">
          <div class="space-y-4 text-base leading-relaxed text-ink-dim">
            <p>
              A digital stagebox is a good piece of hardware: converters, preamps, and
              a cable run replaced by one Ethernet line. What it is not is independent.
              It speaks one protocol to one family of consoles, and when the console is
              gone or the mix has moved into software, an entirely serviceable box full
              of preamps becomes scrap.
            </p>
            <p>
              That is the whole motivation. Understanding the protocol is what lets the
              hardware keep working — with a different console, with a Linux machine,
              or bridged onto an open standard like AES67 so anything can receive it.
            </p>
          </div>
          <div class="space-y-4 text-base leading-relaxed text-ink-dim">
            <p>
              Everything here comes from equipment the project owns, captured on its
              own network. Nothing is redistributed from the vendor: no firmware, no
              binaries, no symbols, no decompilation listings. What is published is our
              own description of behaviour we observed.
            </p>
            <p>
              The full statement is at the bottom of every page on this site, and it is
              there deliberately rather than tucked away on a legal page nobody opens.
            </p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
