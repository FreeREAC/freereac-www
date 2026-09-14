// SPDX-License-Identifier: GPL-3.0-or-later
// freereac-www — the project website. Statically generated, no server at runtime.

export default defineNuxtConfig({
  ssr: true,
  nitro: { prerender: { crawlLinks: true, routes: ['/'], failOnError: true } },

  // Nuxt UI v4 owns the Tailwind v4 pipeline itself, so there is no separate
  // Tailwind module and no tailwind.config.
  modules: ['@nuxt/ui'],

  css: ['~/assets/css/main.css'],

  // Follows the system scheme by default; falls back to the dark look the site
  // shipped with when no preference can be read (pre-hydration, no-JS). Nuxt UI
  // tracks the resolved mode through this same `.dark` class from
  // @nuxtjs/color-mode — without it, its components render light variants over
  // a dark page. The header carries the one manual override control.
  colorMode: { preference: 'system', fallback: 'dark', classSuffix: '' },

  app: {
    // A project page under github.io lives at /<repo>/. Set NUXT_APP_BASE_URL at
    // generate time for that; the default serves from a domain root.
    head: {
      htmlAttrs: { lang: 'en' },
      meta: [
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'theme-color', content: '#f7f5f1', media: '(prefers-color-scheme: light)' },
        { name: 'theme-color', content: '#0d0d10', media: '(prefers-color-scheme: dark)' },
      ],
      link: [{ rel: 'icon', type: 'image/svg+xml', href: '/mark.svg' }],
    },
  },

  devtools: { enabled: false },
  future: { compatibilityVersion: 4 },
  compatibilityDate: '2025-09-01',
});
