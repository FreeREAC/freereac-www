<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
const links = [
  { to: '/#components', label: 'Software' },
  { to: '/#install', label: 'Install' },
  { to: '/#getting-started', label: 'Get started' },
  { to: '/#licence', label: 'Licence' },
] as const;
const open = ref(false);
</script>

<template>
  <header class="sticky top-0 z-50 border-b border-edge bg-field/90 backdrop-blur-md">
    <div class="mx-auto flex max-w-6xl items-center gap-6 px-6 py-4">
      <NuxtLink to="/" class="flex items-center gap-3" aria-label="FreeREAC home">
        <img src="/mark.svg" alt="" class="h-8 w-8" width="32" height="32">
        <span class="font-display text-lg font-semibold tracking-tight">
          <span class="text-signal">Free</span><span class="text-ink">REAC</span>
        </span>
      </NuxtLink>

      <nav class="ml-auto hidden items-center gap-1 md:flex" aria-label="Main">
        <NuxtLink
          v-for="l in links"
          :key="l.to"
          :to="l.to"
          class="rounded px-3 py-2 font-mono text-xs uppercase tracking-[0.14em] text-ink-dim transition-colors hover:text-ink"
          active-class="text-signal"
        >{{ l.label }}</NuxtLink>
      </nav>

      <UButton
        class="ml-auto md:hidden"
        color="neutral"
        variant="ghost"
        :icon="open ? 'i-lucide-x' : 'i-lucide-menu'"
        :aria-expanded="open"
        aria-label="Menu"
        @click="open = !open"
      />
    </div>

    <nav v-if="open" class="border-t border-edge md:hidden" aria-label="Main">
      <NuxtLink
        v-for="l in links"
        :key="l.to"
        :to="l.to"
        class="block border-b border-edge px-6 py-3 font-mono text-xs uppercase tracking-[0.14em] text-ink-dim"
        active-class="text-signal"
        @click="open = false"
      >{{ l.label }}</NuxtLink>
    </nav>
  </header>
</template>
