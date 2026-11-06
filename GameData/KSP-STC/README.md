# KSP-STC: Kerbol Scope

A browser-based system chart and traffic display for Kerbal Space Program 1.12, styled like a
retro ship's navigation console. It follows your running game live:

- **Game clock and real body data** from Telemachus Reborn, so rescale and realism packs match.
- **Your active vessel**, updated live.
- **Every vessel in your save** from kRPC, each kept moving on its last known orbit.
- **Vessel switching**: double-click a ship on the map, or press Switch in Traffic › Tracked.
- Transfer-window timing, a fleet simulator with automated routes, stations and a mission log.

Status: **0.0.1 pre-alpha**. Tested against stand-in servers, not yet inside KSP.

## Install with CKAN

1. Download [`KSP-STC.ckan`](KSP-STC.ckan).
2. In CKAN: **File › Install from .ckan…** and pick the file.
3. CKAN also installs the two required mods: **Telemachus Reborn** and **kRPC**.

Manual install: unzip `dist/KSP-STC-0.0.1.zip` into your KSP folder (it contains `GameData/`),
then install Telemachus Reborn and kRPC yourself.

## One-time kRPC setup

kRPC needs a WebSockets server for the browser to talk to:

1. Start KSP and load a save. Open the kRPC window from the toolbar.
2. **Add server**, set **Protocol** to *Protobuf over WebSockets*, address `127.0.0.1`,
   port `50000`. (If your TCP/IP server already uses 50000, give one of them another port and
   enter it in Kerbol Scope's Settings › Fleet link.)
3. Tick **Auto-start server** and **Auto-accept new clients**, then start the server.

## Open the map

With KSP running, open:

    http://localhost:8085/telemachus/kerbol-scope.html

Bookmark it. Served from the game, the page links to both mods by itself. From another device on
your network, use your PC's address instead of `localhost`.

### Open it automatically when KSP starts (Linux / macOS)

`GameData/KSP-STC/stc-launch.sh` starts the game and opens the map as soon as Telemachus answers.

Steam: Properties › Launch Options:

    "/path/to/KSP/GameData/KSP-STC/stc-launch.sh" %command%

Without Steam: `./stc-launch.sh ./KSP.x86_64`. Set `STC_URL` to change the address.

## What lives where

| Path | Purpose |
|---|---|
| `GameData/Telemachus/Plugins/PluginData/Telemachus/kerbol-scope.html` | The map, served by Telemachus |
| `GameData/KSP-STC/` | Version file, licence, launcher |
| `tools/stc-launch.sh` | Launcher source |
| `KSP-STC.ckan` | CKAN metadata for "Install from .ckan" |
| `dist/` | Release zip that CKAN downloads |

## Notes

- Simulated ships stay accurate until they change orbit; switch to one to refresh it.
- Ship trails, stations, the fleet and the mission log are saved in your browser.
- Planet descriptions are original summaries written for this project.

Licence: MIT.
