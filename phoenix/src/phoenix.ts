// Using this release:
// https://github.com/kasper/phoenix/releases/tag/3.0.0

/* view logs:
  log stream --process Phoenix
*/

import { logAllApps } from "./utils";
import log from "./logger";

function focusOrStart(title: string) {
  var app = App.get(title);

  if (!app) {
    app = App.launch(title);
    // TODO(sidneyw): Add check and display error for non-existent app after
    // launching
    log("launching", app?.name());
    return;
  }

  log("focusing", app.name());
  app.focus();
}

const alt: Phoenix.ModifierKey[] = ["alt"];
// var altShift = ["alt", "shift"];

Key.on("b", alt, () => focusOrStart("Brave Browser"));
Key.on("q", alt, () => focusOrStart("iTerm2"));
Key.on("r", alt, () => focusOrStart("Roam Research"));
Key.on("1", alt, () => focusOrStart("Slack"));
Key.on("p", alt, () => focusOrStart("Spark"));
Key.on("s", alt, () => focusOrStart("Spotify"));
Key.on("t", alt, () => focusOrStart("TickTick"));
Key.on("z", alt, () => focusOrStart("zoom.us"));

// For debugging
Key.on("2", alt, logAllApps);
