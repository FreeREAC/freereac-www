<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
useSeoMeta({
  title: 'Compatibility — FreeREAC',
  description:
    'The Roland stageboxes and consoles FreeREAC has real experience with, what was done with each, and where it stopped. Reported as experience, not as certification.',
});
</script>

<template>
  <div>
    <PageHero
      eyebrow="Compatibility"
      title="What we have worked with."
      lede="This is a record of experience, not a compatibility matrix and not a certification. Each entry says what was done, on our own units, on our own rig. Another unit, another firmware or another console may behave differently, and where we have seen two units of the same model differ, we say so."
    />

    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Stageboxes" title="Roland S-series." />
        <div class="grid gap-5 md:grid-cols-2">
          <DeviceCard
            name="S-0808"
            kind="8 inputs"
            experience="Established end to end · head-amp mapped against it"
          >
            <p>
              A real box connects from cold to a software master, is granted, reaches
              established state and holds a steady one-per-second heartbeat with no
              drops. Its microphone channels arrive as audio and run through a console.
            </p>
            <p>
              Most of what is known about head-amp control was measured against this
              box, by watching a real Roland console drive it from a mirror port with
              our own master stopped — so the reference behaviour is the vendor's, not
              ours.
            </p>
            <p>
              Two smaller findings: it is the only box we have seen announce its own
              model name in plain text, and it has no analogue high-pass filter — we
              swept for one and it was silent.
            </p>
          </DeviceCard>

          <DeviceCard
            name="S-1608"
            kind="16 inputs"
            experience="Established · 16 channels end to end · head-amp drives real hardware"
          >
            <p>
              Sixteen microphone channels decoded into a live audio graph and run
              through a console end to end. Head-amp control reaches the metal: bank
              switching drives the box's own indicators.
            </p>
            <p>
              The head-amp addressing prediction was made before the test rather than
              after it — with the box alone on the segment we predicted which channel
              base every edit would land on, and all twenty-six operator edits landed
              there and nowhere else.
            </p>
            <p>
              Two units measured. Known rough edges: the upper bank of inputs can sit at
              the converter floor until it is enrolled, and this box's audio patch and
              its head-amp addressing use two different offsets, which is measured and
              not yet explained.
            </p>
          </DeviceCard>

          <DeviceCard
            name="S-4000S"
            kind="32 inputs"
            experience="Full 32-channel width established"
          >
            <p>
              The widest box we have, and the one that forced the width handling to be
              right. It initially came up at eight channels under our own master; the
              cause was in the enrolment exchange, and once corrected the box delivers
              its full thirty-two.
            </p>
            <p>
              Its upstream frames were also what settled a question about the frame
              trailer: this box's returns carry a real checksum, where an apparently
              similar trailer in the other direction turned out to be an artefact of how
              the traffic was captured.
            </p>
            <p>
              One gap worth naming: we have never captured this box announcing its own
              identity, so what we know about identifying it is inference from width.
            </p>
          </DeviceCard>
        </div>
      </div>
    </section>

    <section class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Consoles" title="Roland mixers." >
          <p class="mt-4 max-w-3xl text-base leading-relaxed text-ink-dim">
            Two different relationships appear here. A console can be watched while it
            drives a box — which is how the protocol was learned — or it can be asked to
            accept a software stagebox of ours, which is a much harder test and the one
            that is not finished.
          </p>
        </SectionHead>
        <div class="grid gap-5 md:grid-cols-2">
          <DeviceCard
            name="M-200 / M-200i"
            kind="V-Mixer"
            experience="Accepted a software stagebox and held the link"
          >
            <p>
              The strongest result on this page. A real M-200, cold-booted, enrolled our
              software endpoint as a sixteen-channel stagebox in its own REAC menu and
              held the link across a five-minute run. From the console's point of view
              it was simply a box.
            </p>
            <p>
              It is also the console used as the reference for head-amp behaviour,
              captured passively while it drove an S-0808.
            </p>
          </DeviceCard>

          <DeviceCard
            name="M-300"
            kind="V-Mixer"
            experience="Observed driving stageboxes"
          >
            <p>
              Captured while driving both of our stageboxes, and one of the consoles
              that confirmed the sixteen-input head-amp addressing base. It is our 48 kHz
              reference for comparing one console's downstream traffic against another's.
            </p>
          </DeviceCard>

          <DeviceCard
            name="M-5000"
            kind="OHRCA"
            experience="Wire schema confirmed · will not hold a software stagebox yet"
          >
            <p>
              Captures from both of its REAC ports confirmed the frame schema on real
              hardware, and corrected some channel-information values inherited from
              earlier third-party work.
            </p>
            <p>
              It does not yet accept a software stagebox. It grants us and then returns
              to hunting, and the open question is the exact shape of the established
              state that an OHRCA console expects. This is not a clocking wall — it is a
              protocol state we have not got right.
            </p>
            <p class="text-ink-faint">
              This console is the gate. The endpoint that would let a Linux machine be a
              REAC device stays unpublished until this test passes.
            </p>
          </DeviceCard>

          <DeviceCard
            name="M-5000 remote control"
            kind="separate protocol"
            experience="Measured: routing is not exposed"
          >
            <p>
              Separate from REAC, Roland consoles answer an ASCII remote-control
              protocol over the network, and on the V-Mixers it is where channel names
              come from.
            </p>
            <p>
              On a live M-5000 the routing queries come back empty. That is a
              measurement, not an assumption, and it means there is no route to a
              slot-to-name table on that console over that protocol.
            </p>
          </DeviceCard>
        </div>
      </div>
    </section>

    <section>
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Reading this page fairly" title="What experience does and does not imply." />
        <div class="grid gap-8 lg:grid-cols-2">
          <div class="space-y-4 text-base leading-relaxed text-ink-dim">
            <p>
              Everything above was measured on hardware the project owns, on one rig,
              at 48 and 96 kHz. It does not mean a model is supported, and it does not
              mean yours will behave the same way. Firmware versions differ; we have
              seen two units of one model differ.
            </p>
            <p>
              A box not listed here is not incompatible. It is untested, which is a
              different thing, and if you have one we would rather have a capture than
              a guess.
            </p>
          </div>
          <div class="rounded border border-edge bg-field p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
              A caution about evidence, from experience
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              A muted channel and a dead signal path read identically on a meter that
              taps after the mute. An injected test tone that lands one channel sideways
              reports the same silence as a broken console. A packet capture through a
              switch's mirror port can show a trailer the wire never carried.
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              Every one of those cost real time here. If you are testing REAC gear:
              before believing a negative result, prove your measurement can detect a
              positive one.
            </p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>
