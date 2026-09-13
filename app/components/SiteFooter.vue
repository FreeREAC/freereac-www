<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
/**
 * The footer, and with it the non-affiliation notice.
 *
 * The notice is NOT optional and NOT per-page: it is in the layout footer so it
 * appears on every page of this site without anyone having to remember it. The
 * wording is the project's own, as carried in the repositories' NOTICE files and
 * the organisation profile. It is carried in both languages this site ships —
 * the Catalan text is a faithful translation, kept next to the English original
 * so the two never drift apart unnoticed.
 */
const route = useRoute();
const isCa = computed(() => route.path === '/ca' || route.path.startsWith('/ca/'));
</script>

<template>
  <footer class="mt-24 border-t border-edge bg-surface/40">
    <div class="mx-auto grid max-w-6xl gap-8 px-6 py-12 sm:grid-cols-3">
      <div>
        <p class="font-display text-base font-semibold tracking-tight">
          <span class="text-signal">Free</span><span class="text-ink">REAC</span>
        </p>
        <p v-if="isCa" class="mt-2 max-w-xs text-sm leading-relaxed text-ink-dim">
          Documentació i eines obertes per a REAC, el protocol d'àudio sobre
          Ethernet que fan servir les taules de mescles digitals de Roland i les
          seves caixes d'escenari.
        </p>
        <p v-else class="mt-2 max-w-xs text-sm leading-relaxed text-ink-dim">
          Open documentation and tools for REAC, the audio-over-Ethernet protocol
          used by Roland digital mixers and their stageboxes.
        </p>
      </div>
      <div v-if="isCa">
        <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">En aquesta pàgina</p>
        <ul class="mt-3 space-y-2 text-sm">
          <li><NuxtLink to="/ca#stack" class="text-ink-dim hover:text-signal">La pila</NuxtLink></li>
          <li><NuxtLink to="/ca#install" class="text-ink-dim hover:text-signal">Instal·lació</NuxtLink></li>
          <li><NuxtLink to="/ca#getting-started" class="text-ink-dim hover:text-signal">Primers passos</NuxtLink></li>
          <li><NuxtLink to="/ca#sources" class="text-ink-dim hover:text-signal">Repositoris</NuxtLink></li>
        </ul>
      </div>
      <div v-else>
        <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">On this page</p>
        <ul class="mt-3 space-y-2 text-sm">
          <li><NuxtLink to="/#stack" class="text-ink-dim hover:text-signal">The stack</NuxtLink></li>
          <li><NuxtLink to="/#install" class="text-ink-dim hover:text-signal">Install</NuxtLink></li>
          <li><NuxtLink to="/#getting-started" class="text-ink-dim hover:text-signal">Get started</NuxtLink></li>
          <li><NuxtLink to="/#sources" class="text-ink-dim hover:text-signal">Repositories</NuxtLink></li>
        </ul>
      </div>
      <div>
        <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">{{ isCa ? 'Llicència' : 'Licence' }}</p>
        <p v-if="isCa" class="mt-3 text-sm leading-relaxed text-ink-dim">
          El codi és <span class="font-mono text-ink">GPL-3.0-or-later</span>. La
          documentació és una reexpressió pròpia de FreeREAC del comportament
          observat del protocol.
        </p>
        <p v-else class="mt-3 text-sm leading-relaxed text-ink-dim">
          The code is <span class="font-mono text-ink">GPL-3.0-or-later</span>. The
          documentation is FreeREAC's own re-expression of observed protocol
          behaviour.
        </p>
        <a
          href="https://github.com/FreeREAC"
          class="mt-3 inline-flex items-center gap-1.5 text-sm text-ink-dim hover:text-signal"
          rel="noopener"
        >
          github.com/FreeREAC
          <UIcon name="i-lucide-arrow-up-right" class="size-3.5" />
        </a>
      </div>
    </div>

    <div class="border-t border-edge bg-field">
      <div class="mx-auto max-w-6xl px-6 py-6">
        <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
          {{ isCa ? 'No-afiliació' : 'Non-affiliation' }}
        </p>
        <template v-if="isCa">
          <p class="mt-3 max-w-4xl text-sm leading-relaxed text-ink-dim">
            FreeREAC és un projecte independent d'interoperabilitat. No està
            <span class="text-ink">afiliat amb Roland, ni patrocinat ni avalat per
            Roland</span>. REAC és una marca registrada de Roland Corporation,
            emprada aquí només per identificar el protocol amb què interopera
            aquest projecte.
          </p>
          <p class="mt-3 max-w-4xl text-sm leading-relaxed text-ink-dim">
            L'enginyeria inversa per a la interoperabilitat és permesa, i les
            interfícies de protocol no són susceptibles de copyright. FreeREAC
            publica les seves pròpies troballes, reexpressades amb les seves
            pròpies paraules i taules, derivades de les seves pròpies captures de
            paquets en equipament propi i de feina de codi obert amb llicència
            GPL. No redistribueix cap firmware, binari, símbol ni llistat de
            descompilació del fabricant. Això no és documentació oficial de
            Roland.
            <span class="text-ink-faint">(No és assessorament legal.)</span>
          </p>
        </template>
        <template v-else>
          <p class="mt-3 max-w-4xl text-sm leading-relaxed text-ink-dim">
            FreeREAC is an independent interoperability project. It is
            <span class="text-ink">not affiliated with, sponsored by, or endorsed by
            Roland</span>. REAC is a trademark of Roland Corporation, used here only to
            identify the protocol this project interoperates with.
          </p>
          <p class="mt-3 max-w-4xl text-sm leading-relaxed text-ink-dim">
            Reverse engineering for interoperability is permitted, and protocol
            interfaces are not copyrightable. FreeREAC publishes its own findings,
            re-expressed in its own words and tables, derived from its own packet
            captures on equipment it owns and from GPL-licensed open-source work. It
            redistributes no vendor firmware, binaries, symbols or decompilation
            listings. This is not official Roland documentation.
            <span class="text-ink-faint">(Not legal advice.)</span>
          </p>
        </template>
      </div>
    </div>
  </footer>
</template>
