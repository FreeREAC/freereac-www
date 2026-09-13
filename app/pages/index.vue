<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
useSeoMeta({
  title: 'FreeREAC — open-source tools for Roland REAC on Linux',
  description:
    'FreeREAC documents Roland REAC and ships free software to run it on Linux: a protocol library, a PipeWire endpoint, an OpenWrt bridge to AES67, and analysis tools. Install, get started, and find every repository here.',
});
</script>

<template>
  <div>
    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 pt-20 pb-16 sm:pt-24">
        <p class="font-mono text-xs uppercase tracking-[0.2em] text-signal">
          REAC Exposed Audio Communications · EtherType 0x8819
        </p>
        <h1 class="mt-6 max-w-4xl font-display text-3xl font-semibold leading-[1.15] tracking-tight text-ink sm:text-5xl">
          Free software for Roland REAC.
        </h1>
        <p class="mt-8 max-w-3xl text-lg leading-relaxed text-ink-dim">
          REAC is the audio-over-Ethernet protocol Roland's digital mixers and stageboxes
          use to carry many channels of low-latency audio over one cable. FreeREAC is an
          independent project that documents the protocol and ships GPL-3.0 software to
          run it on ordinary Linux machines: bring a stagebox onto a Linux audio graph,
          bridge it to standard AES67 multicast, and analyse captured traffic.
        </p>
        <div class="mt-10 flex flex-wrap gap-3">
          <UButton to="#install" size="lg" color="primary" trailing-icon="i-lucide-arrow-right">
            Install
          </UButton>
          <UButton to="#getting-started" size="lg" color="neutral" variant="outline">
            Get started with a stagebox
          </UButton>
        </div>
      </div>
    </section>

    <section id="components" class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="The software" title="What each piece does." />
        <div class="grid gap-5 md:grid-cols-2">
          <RepoCard
            name="libreac"
            href="https://github.com/FreeREAC/libreac"
            licence="GPL-3.0-or-later"
            status="The protocol library"
          >
            <p>
              A C library for the REAC wire format and control plane: the audio frame
              codec, the master/slave establishment and head-amp (gain, phantom power,
              pad) records. It touches no socket and no clock — it is the byte-layout
              truth that every other tool here links against, so they cannot disagree
              about what a frame means.
            </p>
          </RepoCard>

          <RepoCard
            name="libreac-transport"
            href="https://github.com/FreeREAC/libreac"
            licence="GPL-3.0-or-later"
            status="Sockets, pacer, VLAN — built from the libreac repository"
          >
            <p>
              The second library built from the libreac repository: the parts of a REAC
              endpoint that move frames but carry no opinion about their meaning —
              packet capture and send, the real-time pacer that clocks the wire, network
              interface and VLAN handling. `reac-pw` links it for transport and
              `libreac` underneath it for what the frames mean.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-pw"
            href="https://github.com/FreeREAC/reac-pw"
            licence="GPL-3.0-or-later"
            status="The PipeWire endpoint"
          >
            <p>
              A PipeWire-native client that puts a REAC stagebox directly on a Linux
              audio graph as source and sink nodes — no bridge, no second encapsulation.
              It can run as the REAC master (a Linux machine drives the stagebox) or as
              a slave (a Linux machine joins another master's segment as if it were a
              box). Use this when the Linux host has a network path onto the REAC
              segment itself.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-aes67"
            href="https://github.com/FreeREAC/reac-aes67"
            licence="GPL-3.0-or-later"
            status="The OpenWrt bridge to AES67"
          >
            <p>
              A daemon that runs on an OpenWrt router, decodes REAC on its wire, and
              re-emits it as standard AES67 (RTP L24) multicast — so any machine on
              ordinary networking can receive the channels with no dedicated REAC NIC.
              Use this when the Linux host cannot see the REAC segment directly, or the
              stagebox is reached over Wi-Fi or a routed link.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-protocol"
            href="https://github.com/FreeREAC/reac-protocol"
            licence="GPL-3.0-or-later"
            status="The protocol reference"
          >
            <p>
              The written wire-format reference and a machine-checkable
              <a href="https://kaitai.io" class="text-signal hover:underline" rel="noopener">Kaitai Struct</a>
              grammar that parses real captures: frame geometry, addressing, the
              control-plane handshakes, and head-amp control. Every statement is marked
              by how it is known — verified on FreeREAC's own captures, taken from prior
              open-source work, or still open.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-tools"
            href="https://github.com/FreeREAC/reac-tools"
            licence="GPL-3.0-or-later"
            status="Capture analysis"
          >
            <p>
              Diagnostics for a captured REAC stream, in pure Python with no
              dependencies beyond the standard library: loss, reordering, duplication,
              inter-arrival jitter, cross-mix between two capture points, and a
              control-plane parser for the head-amp records.
            </p>
          </RepoCard>

          <RepoCard name="reac-captures" licence="GPL-3.0-or-later" status="Not public — kept as private test material">
            <p>
              The raw packet captures the software above is verified against. They
              carry the real hardware addresses of the equipment they were taken from,
              so the corpus itself stays private; small, address-sanitised slices of it
              are published as test fixtures inside the repositories that need them.
            </p>
          </RepoCard>
        </div>
      </div>
    </section>

    <section id="install" class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Install" title="A signed dnf repository, for Fedora." />
        <div class="grid gap-10 lg:grid-cols-[1.1fr_1fr]">
          <div>
            <pre class="overflow-x-auto rounded border border-edge bg-field p-5 text-sm leading-relaxed text-ink"><code>sudo dnf config-manager addrepo --from-repofile=https://freereac.github.io/rpm/freereac.repo
sudo rpm --import https://freereac.github.io/rpm/RPM-GPG-KEY-freereac
sudo dnf install libreac reac-pw</code></pre>
            <p class="mt-5 text-base leading-relaxed text-ink-dim">
              Every package and the repository metadata are GPG-signed, and `dnf`
              verifies both. `libreac` and `reac-pw` install on their own for the REAC
              transport; the same repository also carries the openmixer console
              (`sudo dnf install openmixer-full` for the console plus the REAC
              transport, or `openmixer` for the console alone).
            </p>
          </div>
          <div class="rounded border border-edge bg-field p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
              Building from source
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              Every repository builds standalone. `libreac` is a hand-kept Makefile
              (`make && make test`); `reac-pw` is Meson
              (`meson setup build && meson compile -C build`) and needs
              `pipewire-devel` plus a `libreac-devel` new enough for the version its
              `meson.build` names. Each README has the exact commands.
            </p>
          </div>
        </div>
      </div>
    </section>

    <section id="getting-started" class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Getting started" title="A Roland REAC stagebox on Linux." />
        <div class="grid gap-10 lg:grid-cols-2">
          <ol class="space-y-5 text-base leading-relaxed text-ink-dim">
            <li>
              <span class="font-mono text-signal">1.</span> Install `libreac` and
              `reac-pw` (above), and connect the stagebox to a network interface the
              Linux machine can reach — a direct link, or a port on the same VLAN
              segment as the box.
            </li>
            <li>
              <span class="font-mono text-signal">2.</span> Run <code class="text-ink">reac-pw</code>
              with no arguments. It listens on every linked interface; a segment with a
              box and no master is taken as master after a short hunt and the box is
              granted, and a segment already mastered by a real desk is joined as a
              slave. Nothing has to be configured for a box to appear.
            </li>
            <li>
              <span class="font-mono text-signal">3.</span> The stagebox's channels
              appear as PipeWire nodes — a `reac:capture` source for its inputs, a
              `reac:playback` sink for anything it should output — patchable with
              `pw-link`, `qpwgraph`, or any PipeWire-aware application, same as a sound
              card.
            </li>
            <li>
              <span class="font-mono text-signal">4.</span> The packaged binary runs
              without root: the RPM sets the file capabilities `reac-pw` needs
              (`cap_net_raw`, `cap_net_admin`, `cap_sys_nice`).
            </li>
          </ol>
          <div class="rounded border border-edge bg-field p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
              Running it as a service
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              The `reac-pw` package installs the binary only, not a systemd unit. The
              openmixer console manages `reac-pw` for you, started and configured from
              its own Setup → Adapters page, and is the simplest way to keep a segment
              serviced across reboots. Running `reac-pw` on its own without openmixer:
              start it by hand, or install
              <code class="text-ink">packaging/reac-pw.service</code> from the
              `reac-pw` repository as a user unit
              (`systemctl --user enable --now reac-pw`).
            </p>
          </div>
        </div>
      </div>
    </section>

    <section id="licence" class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Licence" title="GPL-3.0-or-later, every repository." />
        <div class="grid gap-10 lg:grid-cols-2 text-base leading-relaxed text-ink-dim">
          <p>
            All FreeREAC code is GPL-3.0-or-later. Where a file derives from someone
            else's work — `reac-aes67`'s decode path descends from Norihiro Kamae's
            `obs-h8819-source` — the derived files carry that author's copyright, and
            each repository's own `NOTICE` file has the full per-file attribution.
          </p>
          <p>
            FreeREAC is an independent interoperability project, not affiliated with,
            sponsored by, or endorsed by Roland. REAC is a trademark of Roland
            Corporation, used here only to identify the protocol. No Roland firmware,
            binaries, symbols or decompilation listings are redistributed; everything
            published is FreeREAC's own re-expression of behaviour observed on its own
            equipment.
          </p>
        </div>
      </div>
    </section>

    <section id="sources">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Sources" title="Every repository is public." />
        <p class="max-w-3xl text-base leading-relaxed text-ink-dim">
          All FreeREAC code lives at
          <a href="https://github.com/FreeREAC" class="text-signal hover:underline" rel="noopener">github.com/FreeREAC</a>:
          <a href="https://github.com/FreeREAC/libreac" class="text-signal hover:underline" rel="noopener">libreac</a>
          (which also builds `libreac-transport`),
          <a href="https://github.com/FreeREAC/reac-pw" class="text-signal hover:underline" rel="noopener">reac-pw</a>,
          <a href="https://github.com/FreeREAC/reac-aes67" class="text-signal hover:underline" rel="noopener">reac-aes67</a>,
          <a href="https://github.com/FreeREAC/reac-protocol" class="text-signal hover:underline" rel="noopener">reac-protocol</a>
          and
          <a href="https://github.com/FreeREAC/reac-tools" class="text-signal hover:underline" rel="noopener">reac-tools</a>.
          Issues and pull requests are open on any of them.
        </p>
      </div>
    </section>
  </div>
</template>
