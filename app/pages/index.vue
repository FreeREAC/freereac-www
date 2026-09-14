<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
useSeoMeta({
  title: 'FreeREAC — open-source tools for Roland REAC on Linux',
  description:
    'FreeREAC reverse-engineered Roland REAC and ships free software to run it on Linux: libreac, the protocol and its transport, and reac-pw, the PipeWire endpoint that puts a stagebox on the graph. Install, get started, and find every repository here.',
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
          Plug a Roland REAC stagebox into Linux, and it is ready.
        </h1>
        <p class="mt-8 max-w-3xl text-lg leading-relaxed text-ink-dim">
          REAC is the proprietary protocol Roland's digital mixers use to carry many
          channels of audio to their stageboxes over one Ethernet cable. FreeREAC
          reverse-engineered it for real — not a partial sniff, a working
          implementation — and proved it on real desks and real boxes: an M-200
          driving REAC at 44.1 and 48 kHz, an M-5000 at 96 kHz, and S-1608, S-4000S
          and S-0808 stageboxes on the other end. Plug a box into a Linux machine and
          it comes up on the audio graph: the three REAC paces (44.1/48/96 kHz),
          head-amp control — gain, phantom power, pad — carried on the wire, both
          master and slave roles, and tagged VLAN trunk segments.
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

    <section id="stack" class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="The stack" title="Two layers." />
        <div class="grid gap-5 md:grid-cols-2">
          <RepoCard
            name="libreac"
            href="https://github.com/FreeREAC/libreac"
            licence="GPL-3.0-or-later"
            status="The protocol, and its transport — one repository, two libraries"
          >
            <p>
              <span class="text-ink">libreac</span> owns what the bytes mean: the REAC
              frame codec, the 32-byte control block and its checksums, head-amp
              records (gain, phantom, pad), box identity, and the master/slave
              establishment state machines. It touches no socket and no clock.
            </p>
            <p>
              <span class="text-ink">libreac-transport</span>, built from the same
              repository, carries no opinion about what a frame means: AF_PACKET
              sockets, the real-time pacer that clocks the wire, and VLAN
              sub-interface handling on a trunk port.
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
              audio graph as source and sink nodes — no bridge, no second
              encapsulation. It links libreac-transport for the wire and libreac
              underneath it for what the frames mean, rather than reimplementing
              either.
            </p>
            <p>
              It can run as the REAC master, driving the stagebox itself, or as a
              slave, joining another master's segment as if it were a box.
            </p>
          </RepoCard>
        </div>
        <p class="mt-8 max-w-3xl text-base leading-relaxed text-ink-dim">
          libreac-transport's public headers carry no socket type in any call shape:
          every transport object reaches the operating system through one opaque
          handle (<code class="text-ink">include/reac/transport/reac_handle.h</code>).
          No consumer sees <code class="text-ink">AF_PACKET</code> in a function
          signature, so a different backend — a Linux kernel module, for instance —
          can sit under the same headers without any caller changing. The namespace
          is already clean for it.
        </p>
      </div>
    </section>

    <section id="install" class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Install" title="A signed dnf repository, for Fedora 44." />
        <div class="grid gap-10 lg:grid-cols-[1.1fr_1fr]">
          <div>
            <pre class="overflow-x-auto rounded border border-edge bg-field p-5 text-sm leading-relaxed text-ink"><code>sudo dnf config-manager addrepo --from-repofile=https://freereac.github.io/rpm/freereac.repo
sudo rpm --import https://freereac.github.io/rpm/RPM-GPG-KEY-freereac
sudo dnf install reac-pw</code></pre>
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
              (`meson setup build && ninja -C build && meson test -C build`) and needs
              `pipewire-devel`, `libreac-devel` and `libreac-transport-devel` at the
              versions its `meson.build` names. Each README has the exact commands.
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
            else's work, the derived files carry that author's copyright, and each
            repository's own `NOTICE` file has the full per-file attribution.
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
        <SectionHead eyebrow="Repositories" title="Where the code lives." />
        <p class="max-w-3xl text-base leading-relaxed text-ink-dim">
          <a href="https://github.com/FreeREAC/libreac" class="text-signal hover:underline" rel="noopener">libreac</a>
          — the protocol and its transport, libreac-transport, built from the same
          repository.
          <a href="https://github.com/FreeREAC/reac-pw" class="text-signal hover:underline" rel="noopener">reac-pw</a>
          — the PipeWire endpoint.
          <a href="https://github.com/FreeREAC/reac-protocol" class="text-signal hover:underline" rel="noopener">reac-protocol</a>
          — the wire-format reference, prose plus a machine-checkable Kaitai Struct
          grammar: the source of truth every repository above is verified against.
        </p>
        <p class="mt-8 max-w-3xl text-base leading-relaxed text-ink-dim">
          <span class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
            Also in the organisation
          </span><br>
          <a href="https://github.com/FreeREAC/reac-tools" class="text-signal hover:underline" rel="noopener">reac-tools</a>
          — capture analysis: loss, reordering, jitter, and a head-amp record parser.
          <a href="https://github.com/FreeREAC/reac-captures" class="text-signal hover:underline" rel="noopener">reac-captures</a>
          — a CC0 public-domain corpus of address-sanitised capture fixtures; the full
          corpus carries real hardware addresses and stays private.
        </p>
        <p class="mt-8 max-w-3xl text-base leading-relaxed text-ink-dim">
          All FreeREAC code lives at
          <a href="https://github.com/FreeREAC" class="text-signal hover:underline" rel="noopener">github.com/FreeREAC</a>.
          Issues and pull requests are open on any of them.
        </p>
      </div>
    </section>
  </div>
</template>
