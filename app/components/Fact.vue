<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
/** One protocol statement, carrying how it is known. */
defineProps<{ title: string; level: 'measured' | 'derived' | 'open' }>();
</script>

<template>
  <article class="border-t border-edge py-7 first:border-t-0 first:pt-0">
    <div class="flex flex-wrap items-baseline gap-x-3 gap-y-2">
      <h3 class="font-display text-base font-semibold tracking-tight text-ink">{{ title }}</h3>
      <Provenance :level="level" />
    </div>
    <div class="mt-3 space-y-3 text-base leading-relaxed text-ink-dim">
      <slot />
    </div>
  </article>
</template>
