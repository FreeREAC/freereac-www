<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
/**
 * The downstream frame, drawn as a schematic rather than to scale — at true
 * proportions the 36-byte header would be under three pixels wide next to the
 * payload, which teaches nothing.
 *
 * The arithmetic is the point and it closes: 14 + 36 + 1440 + 2 = 1492.
 */
const blocks = [
  { span: 'bytes 0–13', name: 'Ethernet header', size: '14 B', note: 'destination, source, EtherType 0x8819', tone: 'bg-surface-2 text-ink-dim' },
  { span: 'bytes 14–49', name: 'REAC header', size: '36 B', note: 'counter (2) · type (2) · control block (32)', tone: 'bg-signal/15 text-signal' },
  { span: 'bytes 50–1489', name: 'Audio', size: '1440 B', note: '40 channels × 12 samples × 3 bytes', tone: 'bg-verified/10 text-verified' },
  { span: 'bytes 1490–1491', name: 'End marker', size: '2 B', note: '0xC2 0xEA', tone: 'bg-surface-2 text-ink-dim' },
] as const;
</script>

<template>
  <figure class="rounded border border-edge bg-field p-6">
    <figcaption class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
      The downstream frame — 1492 bytes, fixed · schematic, not to scale
    </figcaption>
    <div class="mt-5 space-y-2">
      <div
        v-for="b in blocks"
        :key="b.name"
        class="rounded border border-edge px-4 py-3"
        :class="b.tone"
      >
        <div class="flex flex-wrap items-baseline gap-x-3">
          <span class="font-display text-sm font-semibold">{{ b.name }}</span>
          <span class="font-mono text-xs">{{ b.size }}</span>
          <span class="ml-auto font-mono text-[11px] text-ink-faint">{{ b.span }}</span>
        </div>
        <p class="mt-1 font-mono text-xs text-ink-dim">{{ b.note }}</p>
      </div>
    </div>
    <p class="mt-5 font-mono text-xs leading-relaxed text-ink-faint">
      14 + 36 + 1440 + 2 = 1492 &nbsp;·&nbsp; the general form is 52 + n × 36 bytes,
      so each channel costs 36 bytes and a 40-channel downstream frame fills the wire.
    </p>
  </figure>
</template>
