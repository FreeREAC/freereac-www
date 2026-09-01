<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
/**
 * A repository. `href` is optional on purpose: not everything in the stack is
 * published, and a card with no link says so in plain words instead of pointing
 * at a page nobody can open.
 */
defineProps<{
  name: string;
  href?: string;
  version?: string;
  licence: string;
  status: string;
}>();
</script>

<template>
  <article class="rounded border border-edge bg-surface/60 p-6">
    <div class="flex flex-wrap items-baseline gap-x-3 gap-y-1">
      <component
        :is="href ? 'a' : 'span'"
        v-bind="href ? { href, rel: 'noopener' } : {}"
        class="font-display text-lg font-semibold tracking-tight"
        :class="href ? 'text-ink hover:text-signal' : 'text-ink'"
      >{{ name }}</component>
      <span v-if="version" class="font-mono text-xs text-ink-faint">{{ version }}</span>
      <span class="ml-auto font-mono text-[10px] uppercase tracking-[0.12em] text-ink-faint">{{ licence }}</span>
    </div>
    <p class="mt-3 font-mono text-xs leading-relaxed text-signal">{{ status }}</p>
    <div class="mt-3 space-y-2 text-sm leading-relaxed text-ink-dim">
      <slot />
    </div>
    <a
      v-if="href"
      :href="href"
      class="mt-4 inline-flex items-center gap-1.5 font-mono text-xs text-ink-faint hover:text-signal"
      rel="noopener"
    >{{ href.replace('https://', '') }}<UIcon name="i-lucide-arrow-up-right" class="size-3" /></a>
  </article>
</template>
