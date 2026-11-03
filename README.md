# Pazzle Hunt

A Cloudflare Pages puzzle hunt for Lakeside teams. The public site and admin control room use separate HTML, CSS, and JavaScript files. Server-side Pages Functions store teams, puzzles, hints, guesses, solves, and settings in Cloudflare D1.

## Features

- Team registration restricted to `@lakesideschool.org`
- Six sequential puzzle levels
- Answer checking and saved progress
- Public leaderboard
- Reserved `admin` team with protected solution and hint access
- Admin controls for level assignment, introduction editing, leaderboard visibility, and team removal
- Responsive Pazzle visual design

## Cloudflare setup

1. Run `npm install`.
2. Create a D1 database: `npx wrangler d1 create pazzle-hunt-db`.
3. Put the returned database ID in `wrangler.toml`.
4. Apply migrations: `npm run db:remote`.
5. In Cloudflare Pages settings, add encrypted secrets `SESSION_SECRET` and `ADMIN_BOOTSTRAP_PASSWORD`. Set `ADMIN_EMAIL` to the Lakeside email allowed to create the reserved `admin` team.
6. Connect the GitHub repository to Cloudflare Pages. Use no build command and `/` as the output directory.

The first person who registers the exact team name `admin` must supply `ADMIN_EMAIL` and `ADMIN_BOOTSTRAP_PASSWORD`. The server rejects all other attempts to claim that name.

## Puzzle content

The migration includes six starter records based on visible titles in the Canva deck. Replace the placeholder bodies, answers, hints, and solutions after exporting the final Canva slides and speaker notes.

