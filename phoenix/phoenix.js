// Using this release:
// https://github.com/kasper/phoenix/releases/tag/2.6.3

/* view logs:
  log stream --process Phoenix
*/

require("./utils.js");

console.log("CONFIG LOADED");

App.allWithTitle = function (title) {
  return App.all().filter(function (app) {
    if (app.name() === title) {
      return true;
    }
  });
};

App.focusOrStart = function (title) {
  var apps = App.allWithTitle(title);
  if (_.isEmpty(apps)) {
    App.launch(title);
    return;
  }

  apps.map(function (x) {
    return x.focus();
  });
};

var alt = ["alt"];
// var altShift = ["alt", "shift"];

Key.on("z", alt, () => App.focusOrStart("zoom.us"));
Key.on("s", alt, () => App.focusOrStart("Spotify"));
Key.on("q", alt, () => App.focusOrStart("iTerm2"));
Key.on("1", alt, () => App.focusOrStart("Slack"));
Key.on("b", alt, () => App.focusOrStart("Brave Browser"));

// For debugging
Key.on("2", alt, logAllApps);
