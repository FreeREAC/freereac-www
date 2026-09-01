<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
/**
 * How a statement on this site is known. The project grades every protocol fact
 * this way in its own reference, and the site does the same, because the whole
 * value of an interoperability document is that a reader can tell a measurement
 * from a guess without having to trust the author's tone.
 */
const props = defineProps<{ level: 'measured' | 'derived' | 'open' }>();

const LABEL = {
  measured: 'Measured',
  derived: 'From prior work',
  open: 'Open',
} as const;

const TONE = {
  measured: 'border-verified/40 text-verified',
  derived: 'border-signal/40 text-signal',
  open: 'border-open/40 text-open',
} as const;

const label = computed(() => LABEL[props.level]);
const tone = computed(() => TONE[props.level]);
</script>

<template>
  <span
    class="inline-flex flex-none items-center rounded border px-2 py-0.5 font-mono text-[10px] uppercase tracking-[0.12em]"
    :class="tone"
  >{{ label }}</span>
</template>
