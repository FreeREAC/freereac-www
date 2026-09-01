<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
useSeoMeta({
  title: 'The protocol — FreeREAC',
  description:
    'What is known about REAC: frame layout, the sequence counter, the channel-pair audio braid, sample rates and packet cadence, clocking, and head-amp control — with what is still open stated plainly.',
});

const rates = [
  { rate: '44.1 kHz', pps: '3675', how: 'Modelled. Never captured.' },
  { rate: '48 kHz', pps: '4000', how: 'Measured on our own captures.' },
  { rate: '96 kHz', pps: '8000', how: 'Measured on our own captures.' },
];
</script>

<template>
  <div>
    <PageHero
      eyebrow="The protocol"
      title="What is known, and what is not."
      lede="REAC is a flat Layer-2 protocol on EtherType 0x8819. This page is the explanation: what the frames look like, how the clock works, how the head-amps are controlled, and where our understanding runs out."
    />

    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Frames" title="One shape, two directions." />
        <div class="grid gap-10 lg:grid-cols-[1fr_1fr]">
          <div>
            <FrameMap />
          </div>
          <div class="space-y-5">
            <Fact title="The downstream frame is a fixed 1492 bytes" level="measured">
              <p>
                The master broadcasts to the whole segment, always at full width: forty
                channels of twelve samples, three bytes each. A console with fewer
                inputs does not send a smaller frame; it sends the same frame.
              </p>
            </Fact>
            <Fact title="The upstream frame is sized by the box" level="measured">
              <p>
                A box replies by unicast, and its frame is as wide as the box is: an
                eight-input box sends 340 bytes, a sixteen-input box 628, a
                thirty-two-input box 1204. This is how a receiver knows what it is
                talking to before anything identifies itself.
              </p>
              <p>
                It is also how the link is declared alive: connection state follows
                packet length, and a box is considered gone after a second with no
                correctly sized audio frame.
              </p>
            </Fact>
            <Fact title="A 16-bit sequence counter opens the payload" level="measured">
              <p>
                Little-endian, incremented once per frame, wrapping at 0xFFFF. Loss,
                reordering and duplication are all computed from it, and it is the first
                thing worth checking when audio is granular.
              </p>
            </Fact>
            <Fact title="Frame types, and the one that is not there" level="measured">
              <p>
                There is a filler type, a control type and a master announcement. There
                is no separate audio type, because audio rides in every frame — including
                the filler.
              </p>
            </Fact>
          </div>
        </div>
      </div>
    </section>

    <section class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Audio layout" title="Channels are interleaved in pairs, not in order." />
        <div class="grid gap-10 lg:grid-cols-[1.1fr_1fr]">
          <div class="space-y-4 text-base leading-relaxed text-ink-dim">
            <p>
              The obvious reading of the payload — sample-major, channels in order — is
              wrong, and it is wrong in a way that produces plausible-sounding audio,
              which is what makes it expensive. Channels are braided in pairs: each
              even and odd pair shares a six-byte group, and the three bytes of each
              sample are distributed across that group rather than laid out
              consecutively.
            </p>
            <p>
              The layout holds in both directions and across every mixer generation we
              have captured.
            </p>
            <p>
              This one is worth a note on method. The braid originally came from
              published open-source work by others; it would have been easy to inherit
              it and move on. It is marked measured here because it was independently
              re-derived — by autocorrelation on our own rig captures, by
              known-good fixtures, and by an encoder that has to read back a frame it
              built itself.
            </p>
          </div>
          <div class="rounded border border-edge bg-field p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
              Why this is the first thing to get right
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              A decoder that reads the payload the obvious way still produces sound.
              It produces sound on the wrong channels, with the low byte of one sample
              landing in the middle of another, which reads as distortion rather than
              as a layout error.
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              The library at the bottom of this project once wrote the braid on the way
              out and read plain layout on the way in, so it could not read back a
              frame it had just built: of 480 samples in a frame of its own making, zero
              agreed. That is recorded rather than quietly fixed, because it is the
              exact failure anyone implementing this from scratch will hit.
            </p>
          </div>
        </div>
      </div>
    </section>

    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Rate and cadence" title="The frame never changes. The packet rate does." />
        <div class="grid gap-10 lg:grid-cols-[1fr_1fr]">
          <div class="space-y-4 text-base leading-relaxed text-ink-dim">
            <p>
              The sample rate is not a field. It is not announced, and it cannot be read
              from a single frame — the frame is rate-invariant. What changes is how
              often frames arrive: each one carries twelve samples per channel, so the
              packet rate is simply the sample rate divided by twelve.
            </p>
            <p>
              This has a consequence worth stating plainly, because a natural
              assumption gets it backwards: 96 kHz does not halve the channel count. It
              doubles the packet rate and keeps all forty channels. We measured a real
              96 kHz link at eight thousand packets per second carrying forty channels,
              which is about 97 Mbit/s — enough to essentially fill a 100 Mbit link,
              and a good reason to care what the switch between the box and the console
              actually is.
            </p>
            <p>
              44.1 kHz follows from the same rule, and the site marks it open, because
              we have never captured it. A rule that holds at two points is a model
              until a third confirms it.
            </p>
          </div>
          <div>
            <div class="overflow-x-auto rounded border border-edge">
              <table class="w-full border-collapse text-sm">
                <thead>
                  <tr class="border-b border-edge bg-surface/60 text-left font-mono text-xs uppercase tracking-[0.1em] text-ink-faint">
                    <th class="px-4 py-3 font-normal">Sample rate</th>
                    <th class="px-4 py-3 font-normal">Packets/s</th>
                    <th class="px-4 py-3 font-normal">How we know</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="r in rates" :key="r.rate" class="border-b border-edge/60 last:border-0">
                    <td class="px-4 py-3 font-mono text-ink">{{ r.rate }}</td>
                    <td class="px-4 py-3 font-mono text-ink-dim">{{ r.pps }}</td>
                    <td class="px-4 py-3 text-ink-dim">{{ r.how }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="mt-5 rounded border border-edge bg-field p-6">
              <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">Clocking</p>
              <p class="mt-3 text-sm leading-relaxed text-ink-dim">
                One master owns the clock and the frame cadence <em class="text-ink">is</em>
                the word clock. The receiving box is a hardware clock slave with no
                jitter buffer: it does not buffer and resample, it recovers word clock
                from the arrival cadence of the packets.
              </p>
              <p class="mt-3 text-sm leading-relaxed text-ink-dim">
                So a late frame is a late sample. That single sentence explains most of
                what goes wrong when REAC is carried over anything that was not built
                to deliver frames on a metronome — and it is why a de-jittering re-pacer
                exists at all.
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="The control plane" title="Head-amps, and a protocol inside the protocol." />
        <div class="grid gap-10 lg:grid-cols-[1fr_1fr]">
          <div class="space-y-5">
            <Fact title="Head-amp records are Roland MIDI SysEx in a Layer-2 wrapper" level="measured">
              <p>
                The container carries a genuine Roland Data Set message — the same
                family the company's gear has used for decades. Two independent things
                confirm it: the classic Roland checksum rule reproduces the observed
                byte on every record, and the command byte changes in exactly the
                documented way when the console asks a question instead of setting a
                value.
              </p>
            </Fact>
            <Fact title="Three parameters, and the set is closed" level="measured">
              <p>
                Phantom power, pad and sensitivity. Nothing else. We looked for more by
                exercising the console: polarity, pan, level, high-pass and EQ each
                produced not one head-amp record, and a full state push from the console
                dumps exactly three records per channel and no others.
              </p>
              <p>
                The rule that seems to explain it — the protocol carries only what
                cannot be done in software downstream — is a prediction rather than a
                description, and EQ was the test that could have falsified it.
              </p>
            </Fact>
            <Fact title="Sensitivity is linear, one decibel per step" level="measured">
              <p>
                Fifty-six values across fifty-five decibels: no lookup table, no curve.
                The pad shifts the whole scale by twenty decibels and the
                <em class="text-ink">box</em> applies that offset, not the console —
                which matters, because it means a controller that also applies it is
                twenty decibels wrong and sounds merely odd rather than broken.
              </p>
            </Fact>
            <Fact title="Control is declarative, not transactional" level="measured">
              <p>
                REAC control is raw Layer-2: broadcast, with no acknowledgement, no
                retransmission and no sequence recovery. A master does not send a
                command and hope. It continuously restates the world, and a box that
                missed a frame is corrected by the next one.
              </p>
              <p>
                Anything driving a REAC fabric has to be written that way round.
              </p>
            </Fact>
          </div>
          <div class="rounded border border-edge bg-field p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
              The addressing that is measured but not explained
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              Head-amp records address a channel by a number whose base depends on how
              wide the box declares itself to be. An eight-input box bases at zero. A
              sixteen-input box bases at thirty-two. A thirty-two-input box bases at
              zero again.
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              We can predict it and we have confirmed the prediction from the receiving
              end, with a software stagebox that sends no model identity at all and is
              still addressed exactly where the width says it should be.
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              What we cannot do is explain <em class="text-ink">why</em> sixteen means
              thirty-two, and that matters: three candidate explanations fit every
              establishment we have captured equally well, so nothing here predicts what
              a box model we have never seen will do.
            </p>
            <p class="mt-4">
              <Provenance level="open" />
            </p>
          </div>
        </div>
      </div>
    </section>

    <section>
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Open questions" title="What we do not know." >
          <p class="mt-4 max-w-3xl text-base leading-relaxed text-ink-dim">
            This list is part of the documentation, not a disclaimer at the end of it. If
            you are implementing against REAC, this is the section that tells you where
            the ground is soft.
          </p>
        </SectionHead>
        <div class="grid gap-x-10 gap-y-6 md:grid-cols-2">
          <div class="border-l-2 border-open/50 pl-5">
            <h3 class="font-display text-base font-semibold text-ink">Multiple boxes on one segment</h3>
            <p class="mt-2 text-sm leading-relaxed text-ink-dim">
              How the master assigns downstream slots when more than one box is present
              is not understood. We have one accidental two-box capture and no
              systematic study, and this blocks multi-box operation outright.
            </p>
          </div>
          <div class="border-l-2 border-open/50 pl-5">
            <h3 class="font-display text-base font-semibold text-ink">What decides the head-amp base</h3>
            <p class="mt-2 text-sm leading-relaxed text-ink-dim">
              Three different carriers in the establishment exchange predict it
              identically across every capture we hold. Until something separates them,
              a new box model is a guess.
            </p>
          </div>
          <div class="border-l-2 border-open/50 pl-5">
            <h3 class="font-display text-base font-semibold text-ink">44.1 kHz, in every respect</h3>
            <p class="mt-2 text-sm leading-relaxed text-ink-dim">
              We own no console that runs at it, so we have no capture of it. Everything
              stated about 44.1 kHz anywhere in this project is extrapolation.
            </p>
          </div>
          <div class="border-l-2 border-open/50 pl-5">
            <h3 class="font-display text-base font-semibold text-ink">A console-identifying field</h3>
            <p class="mt-2 text-sm leading-relaxed text-ink-dim">
              One byte distinguishes console families, and it also tracks which sample
              rates they can run. Every desk we own runs exactly one rate, so
              "generation" and "rate class" explain our whole corpus equally well and we
              cannot tell them apart.
            </p>
          </div>
          <div class="border-l-2 border-open/50 pl-5">
            <h3 class="font-display text-base font-semibold text-ink">What triggers a full re-assert</h3>
            <p class="mt-2 text-sm leading-relaxed text-ink-dim">
              Consoles periodically restate their entire head-amp state. The intervals
              we have measured do not correlate with anything an operator did, and our
              own notes disagree with each other about it.
            </p>
          </div>
          <div class="border-l-2 border-open/50 pl-5">
            <h3 class="font-display text-base font-semibold text-ink">The identity exchange</h3>
            <p class="mt-2 text-sm leading-relaxed text-ink-dim">
              Boxes answer an identity request with a per-model reply we carry as opaque
              bytes. We can reproduce it; we cannot read it.
            </p>
          </div>
        </div>

        <div class="mt-12 rounded border border-edge bg-surface/60 p-6 sm:p-8">
          <h3 class="font-display text-lg font-semibold tracking-tight text-ink">
            Two claims we inherited and our own captures contradict
          </h3>
          <p class="mt-3 max-w-4xl text-base leading-relaxed text-ink-dim">
            Earlier open-source work described markers we have never once seen: across
            millions of frames, neither appears. Both were checked with a control that
            proves the search can find something when something is there, because an
            empty result and a broken search look identical.
          </p>
          <p class="mt-3 max-w-4xl text-base leading-relaxed text-ink-dim">
            A related caution about naming: several frame labels in circulation come
            from a third-party driver's enumeration, in the region where its author was
            numbering things he had not identified. A confident-looking name is not
            evidence, and we are retiring those.
          </p>
        </div>

        <div class="mt-8 rounded border border-edge bg-field p-6 sm:p-8">
          <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">The full reference</p>
          <p class="mt-3 max-w-4xl text-base leading-relaxed text-ink-dim">
            This page is the explanation. The complete reference — the byte-level wire
            format, the machine-checkable grammar that parses real captures, how to
            capture and analyse REAC yourself, and the full census of what remains
            unknown — is published in the protocol repository.
          </p>
          <a
            href="https://github.com/FreeREAC/reac-protocol"
            class="mt-4 inline-flex items-center gap-1.5 font-mono text-sm text-signal hover:underline"
            rel="noopener"
          >github.com/FreeREAC/reac-protocol<UIcon name="i-lucide-arrow-up-right" class="size-3.5" /></a>
        </div>
      </div>
    </section>
  </div>
</template>
