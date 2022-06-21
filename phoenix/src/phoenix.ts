// Using this release:
// https://github.com/kasper/phoenix/releases/tag/3.0.0

/* view logs:
  log stream --process Phoenix
*/

import { focusOrStart, logAllApps } from "./utils";

import {
  center,
  leftHalf,
  rightHalf,
  nextScreen,
  prevScreen,
} from "./movement";

const alt: Phoenix.ModifierKey[] = ["alt"];
const double: Phoenix.ModifierKey[] = ["cmd", "alt"];
const triple: Phoenix.ModifierKey[] = ["cmd", "alt", "ctrl"];

// ------------
// Launch Apps
// ------------
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

// ------------
// Move Windows
// ------------
Key.on("left", double, leftHalf);
Key.on("right", double, rightHalf);
Key.on("left", triple, prevScreen);
Key.on("right", triple, nextScreen);
Key.on("c", double, center);
