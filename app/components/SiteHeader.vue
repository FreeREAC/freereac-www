<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
const route = useRoute();
const isCa = computed(() => route.path === '/ca' || route.path.startsWith('/ca/'));
const prefix = computed(() => (isCa.value ? '/ca' : ''));

const linksEn = [
  { to: '/#stack', label: 'The stack' },
  { to: '/#install', label: 'Install' },
  { to: '/#getting-started', label: 'Get started' },
  { to: '/#licence', label: 'Licence' },
] as const;
const linksCa = [
  { to: '/ca#stack', label: 'La pila' },
  { to: '/ca#install', label: "Instal·lació" },
  { to: '/ca#getting-started', label: 'Primers passos' },
  { to: '/ca#licence', label: 'Llicència' },
] as const;
const links = computed(() => (isCa.value ? linksCa : linksEn));

// The counterpart of the current page in the other language, for the switch.
const otherHref = computed(() => (isCa.value ? '/' : '/ca'));
const otherLabel = computed(() => (isCa.value ? 'English' : 'Català'));
const menuLabel = computed(() => (isCa.value ? 'Menú' : 'Menu'));

// UColorModeButton toggles the resolved mode (colorMode.value) and, on click,
// sets an explicit preference — it starts by following the system scheme
// (colorMode.preference: 'system' in nuxt.config.ts) and only pins to one
// mode once the visitor overrides it. $attrs land after the component's own
// computed aria-label, so this one wins; it stays in the visitor's language.
const themeLabel = computed(() => (isCa.value ? 'Canvia el tema clar/fosc' : 'Toggle light/dark theme'));

const open = ref(false);
</script>

<template>
  <header class="sticky top-0 z-50 border-b border-edge bg-field/90 backdrop-blur-md">
    <div class="mx-auto flex max-w-6xl items-center gap-6 px-6 py-4">
      <NuxtLink :to="prefix || '/'" class="flex items-center gap-3" aria-label="FreeREAC home">
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

      <NuxtLink
        :to="otherHref"
        class="hidden rounded border border-edge px-3 py-1.5 font-mono text-xs uppercase tracking-[0.14em] text-ink-dim transition-colors hover:text-ink md:block"
      >{{ otherLabel }}</NuxtLink>

      <UColorModeButton class="ml-auto md:ml-0" color="neutral" variant="ghost" :aria-label="themeLabel" />

      <UButton
        class="md:hidden"
        color="neutral"
        variant="ghost"
        :icon="open ? 'i-lucide-x' : 'i-lucide-menu'"
        :aria-expanded="open"
        :aria-label="menuLabel"
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
      <NuxtLink
        :to="otherHref"
        class="block px-6 py-3 font-mono text-xs uppercase tracking-[0.14em] text-ink-dim"
        @click="open = false"
      >{{ otherLabel }}</NuxtLink>
    </nav>
  </header>
</template>
