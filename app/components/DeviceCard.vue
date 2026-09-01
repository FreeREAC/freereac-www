<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
/**
 * One device we have worked with. `experience` is the headline and it is written
 * as experience, never as certification: what we did, on our unit, on our rig.
 */
defineProps<{ name: string; kind: string; experience: string }>();
</script>

<template>
  <article class="rounded border border-edge bg-surface/60 p-6">
    <div class="flex flex-wrap items-baseline gap-x-3 gap-y-1">
      <h3 class="font-display text-lg font-semibold tracking-tight text-ink">{{ name }}</h3>
      <span class="font-mono text-xs text-ink-faint">{{ kind }}</span>
    </div>
    <p class="mt-3 font-mono text-xs leading-relaxed text-signal">{{ experience }}</p>
    <div class="mt-3 space-y-2 text-sm leading-relaxed text-ink-dim">
      <slot />
    </div>
  </article>
</template>
