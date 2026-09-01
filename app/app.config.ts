// SPDX-License-Identifier: GPL-3.0-or-later
/**
 * Nuxt UI runtime config. `sig` is the signal-amber ramp declared as
 * `--color-sig-*` in assets/css/main.css; 500 is the accent the site is built on.
 */
export default defineAppConfig({
  ui: {
    colors: { primary: 'sig', neutral: 'zinc' },
  },
});
