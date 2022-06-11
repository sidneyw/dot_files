// Using this release:
// https://github.com/kasper/phoenix/releases/tag/3.0.0

/* view logs:
  log stream --process Phoenix
*/

require("./utils.js");

App.focusOrStart = function (title) {
  var app = App.get(title);

  if (!app) {
    app = App.launch(title);
    return;
  }

  app.focus();
};

var alt = ["alt"];
// var altShift = ["alt", "shift"];

Key.on("b", alt, () => App.focusOrStart("Brave Browser"));
Key.on("q", alt, () => App.focusOrStart("iTerm2"));
Key.on("r", alt, () => App.focusOrStart("Roam Research"));
Key.on("1", alt, () => App.focusOrStart("Slack"));
Key.on("p", alt, () => App.focusOrStart("Spark"));
Key.on("s", alt, () => App.focusOrStart("Spotify"));
Key.on("t", alt, () => App.focusOrStart("TickTick"));
Key.on("z", alt, () => App.focusOrStart("zoom.us"));

// For debugging
Key.on("2", alt, logAllApps);
