<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
useSeoMeta({
  title: 'Contribute — FreeREAC',
  description:
    'What FreeREAC needs: captures from hardware nobody here owns, independent confirmation of inherited claims, and the discipline that keeps an interoperability document honest.',
});
</script>

<template>
  <div>
    <PageHero
      eyebrow="Contribute"
      title="What would actually help."
      lede="This project is limited by hardware and by evidence, in that order. The most valuable thing anyone can send is a capture from a device nobody here owns."
    />

    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Most wanted" title="Hardware we do not have." />
        <div class="grid gap-5 md:grid-cols-3">
          <article class="rounded border border-edge bg-surface/60 p-6">
            <h3 class="font-display text-base font-semibold tracking-tight text-ink">A console at 44.1 kHz</h3>
            <p class="mt-3 text-sm leading-relaxed text-ink-dim">
              We have never captured REAC at 44.1 kHz, because every desk we own runs at
              one of the other two rates. Everything this project says about 44.1 kHz
              is extrapolation from a rule, and one capture would settle it.
            </p>
          </article>
          <article class="rounded border border-edge bg-surface/60 p-6">
            <h3 class="font-display text-base font-semibold tracking-tight text-ink">Two boxes, one segment</h3>
            <p class="mt-3 text-sm leading-relaxed text-ink-dim">
              How a master assigns downstream slots to more than one stagebox is the
              single largest gap, and it blocks multi-box operation. We hold exactly one
              accidental capture of it.
            </p>
          </article>
          <article class="rounded border border-edge bg-surface/60 p-6">
            <h3 class="font-display text-base font-semibold tracking-tight text-ink">Box models beyond ours</h3>
            <p class="mt-3 text-sm leading-relaxed text-ink-dim">
              Head-amp addressing is predicted from a box's declared width, and three
              competing explanations fit every establishment we hold equally well. A box
              of a width or generation we have not seen would separate them.
            </p>
          </article>
        </div>
      </div>
    </section>

    <section class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="How to send a capture" title="What makes one useful." />
        <div class="grid gap-10 lg:grid-cols-[1fr_1fr]">
          <div class="space-y-4 text-base leading-relaxed text-ink-dim">
            <p>
              Capture the whole frame, not a truncated snapshot — the payload is the
              interesting part and a short snap length throws it away. Capture on a link
              that carries the traffic you care about; a mirror port is fine and is often
              the only option, but say that it was one, because a mirror can add or drop
              bytes the wire never carried.
            </p>
            <p>
              Write down what you did while capturing, with rough timings. A capture of
              somebody changing gain on channel four is worth ten captures of a console
              sitting idle, and it is only worth that if we know channel four is what
              moved.
            </p>
            <p>
              Say what the equipment is: model, firmware version if the front panel will
              tell you, sample rate, and what else was on the segment.
            </p>
          </div>
          <div class="rounded border border-edge bg-field p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
              Before you send it
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              A capture contains the hardware addresses of everything on your network,
              and possibly more. Ours are kept in a private archive for exactly that
              reason, and only small sanitised slices become public test fixtures.
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              Look at what you are about to publish before you publish it, and if in
              doubt, open an issue describing the capture rather than attaching it and
              we can work out where it should live.
            </p>
          </div>
        </div>
      </div>
    </section>

    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Code and documentation" title="How this project works." />
        <div class="grid gap-x-10 gap-y-8 md:grid-cols-2">
          <div>
            <h3 class="font-display text-base font-semibold text-ink">Say how you know</h3>
            <p class="mt-2 text-base leading-relaxed text-ink-dim">
              Every protocol statement carries its provenance: verified on our own
              captures, taken from prior open-source work, or still inferred. A patch to
              the reference that adds a fact without saying which of the three it is
              will be asked for that before anything else.
            </p>
          </div>
          <div>
            <h3 class="font-display text-base font-semibold text-ink">An empty result is not a finding</h3>
            <p class="mt-2 text-base leading-relaxed text-ink-dim">
              A search that finds nothing and a broken search look exactly alike. Two
              claims inherited from earlier work were retired here only after a control
              proved the same search could find something when something was there.
              Prove your probe can detect presence before you report absence.
            </p>
          </div>
          <div>
            <h3 class="font-display text-base font-semibold text-ink">Re-express, never copy</h3>
            <p class="mt-2 text-base leading-relaxed text-ink-dim">
              Findings are published in our own words and tables. No vendor firmware,
              binaries, symbols or decompilation listings are reproduced, and
              contributions containing them cannot be accepted. This is what keeps the
              project on the right side of the line it is standing on.
            </p>
          </div>
          <div>
            <h3 class="font-display text-base font-semibold text-ink">Test against a known answer</h3>
            <p class="mt-2 text-base leading-relaxed text-ink-dim">
              An analyser that has never been shown a fault it was told about in advance
              is an opinion generator. The analysis tools inject known faults and require
              exactly those faults to be reported; new analysis should arrive the same
              way.
            </p>
          </div>
          <div>
            <h3 class="font-display text-base font-semibold text-ink">Plain C for the wire</h3>
            <p class="mt-2 text-base leading-relaxed text-ink-dim">
              The libraries and daemons that touch frames are plain C, with the
              byte-layout facts in one shared library rather than copied into each tool.
              Analysis tooling is Python with no dependencies beyond the standard
              library, so a capture can be examined on any machine.
            </p>
          </div>
          <div>
            <h3 class="font-display text-base font-semibold text-ink">Licensing</h3>
            <p class="mt-2 text-base leading-relaxed text-ink-dim">
              Code is GPL-3.0-or-later. Where a component has to link against something
              with a different requirement it says so in its own notice, and derived
              work keeps the original authors' copyright and credit.
            </p>
          </div>
        </div>
      </div>
    </section>

    <section>
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Where" title="Start here." />
        <div class="grid gap-5 md:grid-cols-2">
          <RepoCard
            name="The organisation"
            href="https://github.com/FreeREAC"
            licence="GPL-3.0-or-later"
            status="Issues and pull requests on any repository"
          >
            <p>
              Every published repository takes issues. If you are not sure which one
              something belongs to, the protocol reference is a reasonable default —
              most questions turn out to be about the wire.
            </p>
          </RepoCard>
          <RepoCard
            name="The protocol reference"
            href="https://github.com/FreeREAC/reac-protocol"
            licence="GPL-3.0-or-later"
            status="The document a contribution usually touches"
          >
            <p>
              The wire format, the grammar that parses real captures, the capture
              how-to, and the census of what is still unknown. If you want to know
              whether something is already understood, the census is the honest half to
              read first.
            </p>
          </RepoCard>
        </div>
      </div>
    </section>
  </div>
</template>
