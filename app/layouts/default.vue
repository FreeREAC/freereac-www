<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
<template>
  <div class="flex min-h-screen flex-col bg-field font-sans text-ink antialiased">
    <SiteHeader />
    <main class="flex-1">
      <slot />
    </main>
    <SiteFooter />
  </div>
</template>
