// Using this release:
// https://github.com/kasper/phoenix/releases/tag/3.0.0

/* view logs:
	log stream --process Phoenix
*/

import { focusOrStart, logAllApps } from "./utils";

import {
  centerTwoThirds,
  // center,
  // leftHalf,
  // rightHalf,
  // nextScreen,
  // prevScreen,
  // fullScreen,
} from "./movement";

const alt: Phoenix.ModifierKey[] = ["alt"];
const double: Phoenix.ModifierKey[] = ["cmd", "alt"];
const doubleShift: Phoenix.ModifierKey[] = double.concat(["shift"]);
// const triple: Phoenix.ModifierKey[] = ["cmd", "alt", "ctrl"];

// ------------
// Launch Apps
// ------------
// Key.on("a", alt, () => focusOrStart("Arc"));
// Key.on("q", alt, () => focusOrStart("Alacritty"));
// Key.on("b", alt, () => focusOrStart("Brave Browser"));
// Took the place of  roam and therefore has r trigger
// Key.on("r", alt, () => focusOrStart("Logseq"));
// Key.on("n", alt, () => focusOrStart("Notion"));
// Key.on("c", alt, () => focusOrStart("Notion Calendar"));
// Key.on("m", alt, () => focusOrStart("Messages"));
// Key.on("r", alt, () => focusOrStart("Roam Research"));
// Key.on("1", alt, () => focusOrStart("Slack"));
// Key.on("p", alt, () => focusOrStart("Spark"));
// Key.on("s", alt, () => focusOrStart("Spotify"));
// Key.on("t", alt, () => focusOrStart("TickTick"));
// Key.on("z", alt, () => focusOrStart("zoom.us"));

// ------------
// Move Windows
// ------------
// Key.on("c", doubleShift, centerTwoThirds);
// Key.on("left", double, leftHalf);
// Key.on("right", double, rightHalf);
// Key.on("left", triple, prevScreen);
// Key.on("right", triple, nextScreen);
// Key.on("c", double, center);
// Key.on("f", double, fullScreen);

// Print out the name of all running apps
// Key.on("2", alt, logAllApps);
