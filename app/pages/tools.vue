<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
useSeoMeta({
  title: 'Tools — FreeREAC',
  description:
    'The FreeREAC toolchain: libreac, reac-aes67, reac-transport, reac-repacer, reac-tools and reac-label — with the honest status of each, and what is not published yet.',
});
</script>

<template>
  <div>
    <PageHero
      eyebrow="Tools"
      title="What you can actually run."
      lede="Each piece is independent and composes with the others. A REAC link is just Layer-2 frames: something puts them on a defined segment, something re-clocks them if the path is bursty, and something terminates them into audio you can use."
    />

    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="The stack" title="How the pieces fit." />
        <div class="rounded border border-edge bg-field p-6 sm:p-8">
          <ol class="space-y-5">
            <li class="flex flex-col gap-2 sm:flex-row sm:items-baseline sm:gap-5">
              <span class="w-40 flex-none font-mono text-sm text-signal">reac-transport</span>
              <span class="text-sm leading-relaxed text-ink-dim">
                Carries the frames across an OpenWrt network — a tagged VLAN on one LAN,
                or a tunnel across Wi-Fi or a routed hop.
              </span>
            </li>
            <li class="flex flex-col gap-2 sm:flex-row sm:items-baseline sm:gap-5">
              <span class="w-40 flex-none font-mono text-sm text-signal">reac-repacer</span>
              <span class="text-sm leading-relaxed text-ink-dim">
                Sits on a jittery hop and re-clocks the stream, so a clock-slave box on
                the far side stays locked. A late frame is a late sample, so a bursty
                link needs this or it needs nothing at all.
              </span>
            </li>
            <li class="flex flex-col gap-2 sm:flex-row sm:items-baseline sm:gap-5">
              <span class="w-40 flex-none font-mono text-sm text-signal">reac-aes67</span>
              <span class="text-sm leading-relaxed text-ink-dim">
                Terminates REAC into standard AES67 multicast, so anything that speaks
                an open standard can receive the channels.
              </span>
            </li>
            <li class="flex flex-col gap-2 sm:flex-row sm:items-baseline sm:gap-5">
              <span class="w-40 flex-none font-mono text-sm text-signal">libreac</span>
              <span class="text-sm leading-relaxed text-ink-dim">
                Underneath all of them: one C library holding the byte-layout facts, so
                three projects cannot drift apart about what a frame means.
              </span>
            </li>
          </ol>
        </div>
      </div>
    </section>

    <section class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Published" title="Repositories you can clone today." />
        <div class="grid gap-5 md:grid-cols-2">
          <RepoCard
            name="libreac"
            href="https://github.com/FreeREAC/libreac"
            version="0.7.1"
            licence="GPL-3.0-or-later"
            status="Working · consumed by three projects"
          >
            <p>
              The shared C library: mode descriptors, rate detection, frame helpers, the
              channel-pair braid, the 24-bit sample codec, and decode and encode in both
              directions.
            </p>
            <p>
              It deliberately does not touch a socket, a clock or a protocol state
              machine. It is the byte-layout truth and nothing else, which is what makes
              it safe for everything else to depend on.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-aes67"
            href="https://github.com/FreeREAC/reac-aes67"
            version="0.3.0 in tree"
            licence="GPL-3.0-or-later"
            status="Hardware-validated on one router · a second target still pending"
          >
            <p>
              A C daemon plus OpenWrt packaging that decodes REAC on a router and
              re-emits it as AES67 multicast, so any Linux or PipeWire machine receives
              all channels. Cross-built for both supported targets, with a web interface
              for configuration.
            </p>
            <p>
              Validated end to end on a Cudy WR2100: discovery through to a
              forty-channel node. On-device smoke testing on the other target is still
              outstanding, and the page says so rather than implying both are equal.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-transport"
            href="https://github.com/FreeREAC/reac-transport"
            version="0.1.0"
            licence="GPL-3.0-or-later"
            status="Working, and narrower than its name"
          >
            <p>
              Carrying REAC across an OpenWrt network expressed purely as native network
              and firewall configuration — a tunnel, VLAN sub-interfaces, and a
              return-path drop. There is no compiled code in it at all.
            </p>
            <p>
              Two cautions it states itself: the tunnel handler's behaviour has not been
              checked on every OpenWrt release, and its firewall rule is unconditional —
              install it with no re-pacer running and the box receives nothing and never
              locks.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-repacer"
            href="https://github.com/FreeREAC/reac-repacer"
            licence="GPL-3.0-or-later"
            status="Published · not re-verified for this page"
          >
            <p>
              A transparent Layer-2 de-jitter and re-pacing relay for a REAC stream
              carried over a bursty link, packaged for OpenWrt with a web interface.
            </p>
            <p>
              It is listed here because it is a published part of the stack. Its current
              state has not been re-checked while writing this page, so take its own
              repository as the authority rather than this card.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-tools"
            href="https://github.com/FreeREAC/reac-tools"
            version="0.1.0"
            licence="GPL-3.0-or-later"
            status="Working · the analyser is round-trip tested"
          >
            <p>
              Analysis and diagnostics for captured REAC traffic, in pure Python with no
              dependencies beyond the standard library: loss, reordering, duplication,
              cross-mix between two capture points, and inter-arrival jitter, plus a
              control-plane parser.
            </p>
            <p>
              Its test suite injects a known fault with a simulator and requires the
              analyser to report exactly that fault — so the analyser is trustworthy
              before it ever sees a real capture. A measurement tool nobody has tested
              against a known answer is an opinion generator.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-protocol"
            href="https://github.com/FreeREAC/reac-protocol"
            licence="GPL-3.0-or-later"
            status="The reference · every fact graded by provenance"
          >
            <p>
              The protocol reference itself: wire format, a machine-checkable grammar
              that parses real captures, a capture how-to, and the census of what is
              still unknown.
            </p>
            <p>
              Every statement carries whether it was verified on our own captures, taken
              from prior open-source work, or is still inferred.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-label"
            href="https://github.com/FreeREAC/reac-label"
            version="0.1.0"
            licence="GPL-3.0-or-later"
            status="Working, on exactly one path"
          >
            <p>
              A read-only tool that asks a Roland V-Mixer over its remote-control port
              for a slot-to-channel-name table, so the converted AES67 streams carry
              real names instead of numbers.
            </p>
            <p>
              Two honest limits: its contract with the converter has not been tested
              from end to end, and on an M-5000 the routing simply is not exposed over
              that port — measured, not assumed.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-docs"
            href="https://github.com/FreeREAC/reac-docs"
            licence="GPL-3.0-or-later"
            status="Engineering findings · partly superseded"
          >
            <p>
              The investigation behind carrying REAC across a 5 GHz Wi-Fi link, the rig
              recipe that came out of it, and a feasibility answer on doing AES67 in
              firmware.
            </p>
            <p>
              Written in June and not fully revised since. Parts of it have been
              overtaken by later work, so where it disagrees with the protocol
              reference, the protocol reference wins.
            </p>
          </RepoCard>
        </div>
      </div>
    </section>

    <section class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Not published" title="Work that exists and is not yours to clone yet." />
        <div class="grid gap-5 md:grid-cols-2">
          <RepoCard
            name="reac-pw"
            licence="GPL-3.0-or-later"
            status="Not published — held pending validation against an OHRCA console"
          >
            <p>
              A PipeWire-native REAC endpoint: a client that registers a REAC fabric as
              nodes in a PipeWire graph, able to run as master or as slave. It is what
              lets a Linux machine be either end of a REAC link.
            </p>
            <p>
              It is deliberately unpublished. The decision on record is to keep the
              join and hold handshake private until it has been validated against a real
              M-5000, and that validation has not happened — the console grants us and
              then goes back to hunting.
            </p>
            <p class="text-ink-faint">
              It is described here because the compatibility page rests on results
              measured with it, and it would be dishonest to report those without saying
              the tool behind them is not something you can check.
            </p>
          </RepoCard>

          <RepoCard
            name="Packages"
            licence="—"
            status="Build from source"
          >
            <p>
              There is packaging in several of these repositories — OpenWrt packages for
              the router-side tools and RPM specifications elsewhere — and there is no
              published package repository serving them.
            </p>
            <p>
              If you find a repository definition in a tree, treat it as a template for
              the intended end state rather than as somewhere to point a package
              manager today.
            </p>
          </RepoCard>
        </div>
      </div>
    </section>

    <section>
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Related work" title="Not ours, and worth knowing about." />
        <div class="grid gap-5 md:grid-cols-2">
          <RepoCard
            name="obs-h8819-source"
            href="https://github.com/norihiro/obs-h8819-source"
            licence="GPL-3.0-or-later"
            status="Third-party · by Norihiro Kamae"
          >
            <p>
              An OBS Studio source plugin that receives REAC audio directly, developed
              and tested against a Roland M-200i at 48 kHz. If your route to REAC is a
              stream into OBS rather than into a mixing console, start here.
            </p>
            <p>
              It is not a FreeREAC project and we do not speak for it. Parts of
              FreeREAC's own early understanding are derived from it and from
              per-gron's REAC driver, and both are credited in the repositories that
              carry that derivation.
            </p>
          </RepoCard>

          <RepoCard
            name="openmixer"
            href="https://github.com/FreeMixer/openmixer"
            licence="GPL-3.0-or-later"
            status="Sibling project · a software mixing console"
          >
            <p>
              A mixing console built in software for Linux, which drives REAC stageboxes
              through this project's work: discovery, patching and head-amp control on
              real Roland boxes.
            </p>
            <p>
              It is where the protocol work goes to be useful, and it is where several
              of the hardware results on the compatibility page were measured.
            </p>
          </RepoCard>
        </div>
      </div>
    </section>
  </div>
</template>
