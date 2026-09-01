# freereac-www

The FreeREAC project website. Nuxt, statically generated, no server at runtime.

## Build

```
npm install
npm run generate
```

The result is a directory of plain files in `.output/public`. Serve it with anything:

```
npx serve .output/public
```

`npm run dev` runs it with hot reload on <http://localhost:3000>.

## The base URL is a build input, not a serving option

A prerendered page names its assets absolutely. A site built for `/` and then served
under a path prefix has every asset 404 one level above the mount, so the prefix has to
be known at build time:

```
NUXT_APP_BASE_URL=/freereac-www/ npm run generate   # a GitHub project page
npm run generate                                    # a domain root
```

## Publishing

### GitHub Pages

`.github/workflows/pages.yml` builds and publishes on a push to `main`. It is inert until
the repository is pushed and Pages is switched on — Settings → Pages → Build and
deployment → **GitHub Actions**. The workflow sets `NUXT_APP_BASE_URL=/freereac-www/`;
change it if the repository is renamed or a custom domain is used.

Note that the organisation already publishes `freereac.github.io`. If this site is ever
meant to live at the organisation root rather than at a project path, it moves to that
repository and the base URL becomes `/`.

### The cluster

`.output/public` is a static tree with no runtime dependencies, so it can also be served
from the cluster behind the existing ingress — copy the directory into a web root, or
build an image `FROM` any static file server with the tree at its document root.

## The non-affiliation notice is not optional

It lives in `app/components/SiteFooter.vue`, which is in the layout, so it renders on
every page without anyone having to remember it. **Do not move it into individual
pages.** A build can be checked in one command:

```
grep -c "not affiliated with, sponsored by, or endorsed by" .output/public/*/index.html .output/public/index.html
```

Every line must read `1`. The wording matches the NOTICE files in the project's
repositories and the organisation profile; if it changes there, change it here.

## What goes on this site

Authored explanation, not working notes. The protocol page is a white paper about the
protocol; the raw lab material, the captures and the firmware analysis stay where they
are and are not linked or reproduced here.

Every claim is graded by how it is known — measured on our own captures, taken from
prior open-source work, or still open — and the open list is published rather than
minimised. Unpublished work is described as unpublished instead of being linked.

## Structure

```
app/pages/         one file per route: index, protocol, tools, compatibility, contribute
app/components/    the shared pieces, including the provenance badge and the frame map
app/assets/css/    Tailwind entry, Nuxt UI, and the palette — the only stylesheet
```

Styling is Tailwind utilities and Nuxt UI components. There are no hand-written CSS rules
and no second stylesheet.

## Licence

GPL-3.0-or-later, matching the FreeREAC repositories.
