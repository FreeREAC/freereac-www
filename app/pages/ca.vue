<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<script setup lang="ts">
useHead({ htmlAttrs: { lang: 'ca' } });

useSeoMeta({
  title: 'FreeREAC — eines de codi obert per a REAC de Roland a Linux',
  description:
    "FreeREAC ha fet enginyeria inversa de REAC de Roland i distribueix programari lliure per executar-lo a Linux: libreac, el protocol i el seu transport, i reac-pw, el punt final de PipeWire que posa una caixa d'escenari al graf. Instal·la, comença i troba aquí tots els repositoris.",
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
          Connecta una caixa d'escenari (stagebox) REAC de Roland a Linux, i ja
          està a punt.
        </h1>
        <p class="mt-8 max-w-3xl text-lg leading-relaxed text-ink-dim">
          REAC és el protocol propietari que fan servir les taules de mescles
          digitals de Roland per portar molts canals d'àudio a les seves caixes
          per un sol cable Ethernet. FreeREAC n'ha fet l'enginyeria inversa de
          debò — no una detecció parcial, sinó una implementació que funciona —
          i ho ha demostrat en taules i caixes reals: una M-200 fent anar REAC a
          44,1 i 48 kHz, una M-5000 a 96 kHz, i caixes S-1608, S-4000S i S-0808
          a l'altre extrem. Endolla una caixa a una màquina Linux i apareix al
          graf d'àudio: els tres ritmes de REAC (44,1/48/96 kHz), el control del
          preamplificador — guany, alimentació fantasma, atenuador (pad) —
          transmès pel cable, els papers de mestre i esclau, i segments troncals
          VLAN etiquetats.
        </p>
        <div class="mt-10 flex flex-wrap gap-3">
          <UButton to="#install" size="lg" color="primary" trailing-icon="i-lucide-arrow-right">
            Instal·la
          </UButton>
          <UButton to="#getting-started" size="lg" color="neutral" variant="outline">
            Comença amb una caixa d'escenari
          </UButton>
        </div>
      </div>
    </section>

    <section id="stack" class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="La pila" title="Dues capes." />
        <div class="grid gap-5 md:grid-cols-2">
          <RepoCard
            name="libreac"
            href="https://github.com/FreeREAC/libreac"
            licence="GPL-3.0-or-later"
            status="El protocol, i el seu transport — un repositori, dues biblioteques"
          >
            <p>
              <span class="text-ink">libreac</span> és qui defineix què
              signifiquen els bytes: el còdec de trames REAC, el bloc de
              control de 32 bytes i les seves sumes de verificació, els
              registres de preamplificador (guany, alimentació fantasma,
              atenuador), la identitat de la caixa, i les màquines d'estats
              d'establiment mestre/esclau. No toca cap socket ni cap rellotge.
            </p>
            <p>
              <span class="text-ink">libreac-transport</span>, construït des
              del mateix repositori, no té cap opinió sobre què significa una
              trama: sockets AF_PACKET, el ritmador (pacer) de temps real que
              marca el ritme del cable, i la gestió de subinterfícies VLAN en
              un port troncal.
            </p>
          </RepoCard>

          <RepoCard
            name="reac-pw"
            href="https://github.com/FreeREAC/reac-pw"
            licence="GPL-3.0-or-later"
            status="El punt final de PipeWire"
          >
            <p>
              Un client natiu de PipeWire que posa una caixa d'escenari REAC
              directament al graf d'àudio de Linux com a nodes d'origen
              (source) i de destinació (sink) — sense pont, sense una segona
              encapsulació. Enllaça amb libreac-transport per al cable i amb
              libreac per sota per al significat de les trames, en lloc de
              reimplementar cap dels dos.
            </p>
            <p>
              Pot funcionar com a mestre REAC, fent anar la caixa d'escenari
              directament, o com a esclau, incorporant-se al segment d'un
              altre mestre com si fos una caixa.
            </p>
          </RepoCard>
        </div>
        <p class="mt-8 max-w-3xl text-base leading-relaxed text-ink-dim">
          Les capçaleres públiques de libreac-transport no porten cap tipus de
          socket en cap signatura de crida: tot objecte de transport arriba al
          sistema operatiu a través d'un únic identificador opac
          (<code class="text-ink">include/reac/transport/reac_handle.h</code>).
          Cap consumidor veu <code class="text-ink">AF_PACKET</code> en la
          signatura d'una funció, de manera que un backend diferent — un mòdul
          del nucli de Linux, per exemple — es pot col·locar sota les mateixes
          capçaleres sense que cap client hagi de canviar. L'espai de noms ja
          hi és net.
        </p>
      </div>
    </section>

    <section id="install" class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Instal·lació" title="Un repositori dnf signat, per a Fedora 44." />
        <div class="grid gap-10 lg:grid-cols-[1.1fr_1fr]">
          <div>
            <pre class="overflow-x-auto rounded border border-edge bg-field p-5 text-sm leading-relaxed text-ink"><code>sudo dnf config-manager addrepo --from-repofile=https://freereac.github.io/rpm/freereac.repo
sudo rpm --import https://freereac.github.io/rpm/RPM-GPG-KEY-freereac
sudo dnf install reac-pw</code></pre>
            <p class="mt-5 text-base leading-relaxed text-ink-dim">
              Tots els paquets i les metadades del repositori estan signats
              amb GPG, i `dnf` verifica totes dues coses. `libreac` i
              `reac-pw` s'instal·len sols per al transport REAC; el mateix
              repositori també porta la consola openmixer (`sudo dnf install
              openmixer-full` per a la consola més el transport REAC, o
              `openmixer` només per a la consola).
            </p>
          </div>
          <div class="rounded border border-edge bg-field p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
              Compilació des del codi font
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              Cada repositori es compila de manera independent. `libreac` té
              un Makefile escrit a mà (`make && make test`); `reac-pw` fa
              servir Meson (`meson setup build && ninja -C build && meson test
              -C build`) i necessita `pipewire-devel`, `libreac-devel` i
              `libreac-transport-devel` a les versions que indica el seu
              `meson.build`. Cada README té les ordres exactes.
            </p>
          </div>
        </div>
      </div>
    </section>

    <section id="getting-started" class="border-b border-edge">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Primers passos" title="Una caixa d'escenari Roland REAC a Linux." />
        <div class="grid gap-10 lg:grid-cols-2">
          <ol class="space-y-5 text-base leading-relaxed text-ink-dim">
            <li>
              <span class="font-mono text-signal">1.</span> Instal·la
              `libreac` i `reac-pw` (a dalt), i connecta la caixa d'escenari a
              una interfície de xarxa que la màquina Linux pugui veure — un
              enllaç directe, o un port al mateix segment VLAN que la caixa.
            </li>
            <li>
              <span class="font-mono text-signal">2.</span> Executa <code class="text-ink">reac-pw</code>
              sense arguments. Escolta totes les interfícies connectades; un
              segment amb una caixa i sense mestre es pren com a mestre
              després d'una cerca curta i la caixa queda concedida, i un
              segment ja governat per una taula real s'hi incorpora com a
              esclau. No cal configurar res perquè una caixa aparegui.
            </li>
            <li>
              <span class="font-mono text-signal">3.</span> Els canals de la
              caixa d'escenari apareixen com a nodes de PipeWire — un origen
              `reac:capture` per a les seves entrades, una destinació
              `reac:playback` per a tot el que hagi de treure — connectables
              amb `pw-link`, `qpwgraph`, o qualsevol aplicació compatible amb
              PipeWire, igual que una targeta de so.
            </li>
            <li>
              <span class="font-mono text-signal">4.</span> El binari
              empaquetat s'executa sense root: l'RPM estableix les capacitats
              de fitxer que `reac-pw` necessita (`cap_net_raw`,
              `cap_net_admin`, `cap_sys_nice`).
            </li>
          </ol>
          <div class="rounded border border-edge bg-field p-6">
            <p class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
              Executar-ho com a servei
            </p>
            <p class="mt-4 text-sm leading-relaxed text-ink-dim">
              El paquet `reac-pw` només instal·la el binari, no una unitat de
              systemd. La consola openmixer gestiona `reac-pw` per tu, engegat
              i configurat des de la seva pròpia pàgina Setup → Adapters, i és
              la manera més senzilla de mantenir un segment en servei entre
              reinicis. Per executar `reac-pw` tot sol sense openmixer:
              engega'l a mà, o instal·la
              <code class="text-ink">packaging/reac-pw.service</code> del
              repositori `reac-pw` com a unitat d'usuari
              (`systemctl --user enable --now reac-pw`).
            </p>
          </div>
        </div>
      </div>
    </section>

    <section id="licence" class="border-b border-edge bg-surface/40">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Llicència" title="GPL-3.0-or-later, a tots els repositoris." />
        <div class="grid gap-10 lg:grid-cols-2 text-base leading-relaxed text-ink-dim">
          <p>
            Tot el codi de FreeREAC és GPL-3.0-or-later. Quan un fitxer deriva
            de la feina d'algú altre — el camí de descodificació de
            `reac-aes67` prové de `obs-h8819-source` de Norihiro Kamae —, els
            fitxers derivats porten el copyright d'aquest autor, i el fitxer
            `NOTICE` de cada repositori té l'atribució completa fitxer per
            fitxer.
          </p>
          <p>
            FreeREAC és un projecte independent d'interoperabilitat, no
            afiliat amb Roland, ni patrocinat ni avalat per Roland. REAC és
            una marca registrada de Roland Corporation, emprada aquí només per
            identificar el protocol. No es redistribueix cap firmware,
            binari, símbol ni llistat de descompilació de Roland; tot el que
            es publica és una reexpressió pròpia de FreeREAC del comportament
            observat en el seu propi equipament.
          </p>
        </div>
      </div>
    </section>

    <section id="sources">
      <div class="mx-auto max-w-6xl px-6 py-16">
        <SectionHead eyebrow="Repositoris" title="On viu el codi." />
        <p class="max-w-3xl text-base leading-relaxed text-ink-dim">
          <a href="https://github.com/FreeREAC/libreac" class="text-signal hover:underline" rel="noopener">libreac</a>
          — el protocol i el seu transport, libreac-transport, construït des
          del mateix repositori.
          <a href="https://github.com/FreeREAC/reac-pw" class="text-signal hover:underline" rel="noopener">reac-pw</a>
          — el punt final de PipeWire.
          <a href="https://github.com/FreeREAC/reac-protocol" class="text-signal hover:underline" rel="noopener">reac-protocol</a>
          — la referència del format de trama (wire format), en prosa més una
          gramàtica Kaitai Struct verificable per màquina: la font de veritat
          amb què es verifica cada repositori anterior.
        </p>
        <p class="mt-8 max-w-3xl text-base leading-relaxed text-ink-dim">
          <span class="font-mono text-xs uppercase tracking-[0.14em] text-ink-faint">
            També a l'organització
          </span><br>
          <a href="https://github.com/FreeREAC/reac-tools" class="text-signal hover:underline" rel="noopener">reac-tools</a>
          — anàlisi de captures: pèrdua, reordenació, jitter, i un
          analitzador de registres de preamplificador.
          <a href="https://github.com/FreeREAC/reac-captures" class="text-signal hover:underline" rel="noopener">reac-captures</a>
          — un corpus CC0 de domini públic de captures amb les adreces
          sanejades; el corpus complet porta adreces reals de maquinari i es
          manté privat.
          <a href="https://github.com/FreeREAC/reac-aes67" class="text-signal hover:underline" rel="noopener">reac-aes67</a>
          — un pont de REAC a AES67 que funciona en un router OpenWrt,
          mantingut per a routers sense PipeWire.
        </p>
        <p class="mt-8 max-w-3xl text-base leading-relaxed text-ink-dim">
          Tot el codi de FreeREAC viu a
          <a href="https://github.com/FreeREAC" class="text-signal hover:underline" rel="noopener">github.com/FreeREAC</a>.
          Les incidències (issues) i les propostes de canvi (pull requests)
          estan obertes a qualsevol d'ells.
        </p>
      </div>
    </section>
  </div>
</template>
