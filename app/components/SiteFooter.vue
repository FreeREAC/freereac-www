<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
/**
 * The footer, and with it the non-affiliation notice.
 *
 * The notice is NOT optional and NOT per-page: it is in the layout footer so it
 * appears on every page of this site without anyone having to remember it. The
 * wording is the project's own, as carried in the repositories' NOTICE files and
 * the organisation profile.
 */
</script>

<template>
  <footer class="mt-24 border-t border-edge bg-surface/40">
    <div class="mx-auto grid max-w-6xl gap-8 px-6 py-12 sm:grid-cols-3">
      <div>
        <p class="font-display text-base font-semibold tracking-tight">
          <span class="text-signal">Free</span><span class="text-ink">REAC</span>
        </p>
        <p class="mt-2 max-w-xs text-sm leading-relaxed text-ink-dim">
          Open documentation and tools for REAC, the audio-over-Ethernet protocol
          used by Roland digital mixers and their stageboxes.
        </p>
      </div>
      <div>
        <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">On this page</p>
        <ul class="mt-3 space-y-2 text-sm">
          <li><NuxtLink to="/#components" class="text-ink-dim hover:text-signal">Software</NuxtLink></li>
          <li><NuxtLink to="/#install" class="text-ink-dim hover:text-signal">Install</NuxtLink></li>
          <li><NuxtLink to="/#getting-started" class="text-ink-dim hover:text-signal">Get started</NuxtLink></li>
          <li><NuxtLink to="/#sources" class="text-ink-dim hover:text-signal">Sources</NuxtLink></li>
        </ul>
      </div>
      <div>
        <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">Licence</p>
        <p class="mt-3 text-sm leading-relaxed text-ink-dim">
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
          Non-affiliation
        </p>
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
      </div>
    </div>
  </footer>
</template>
