function logWindow(window) {
  console.log("------");
  console.log("title", window.title());
  console.log("isMain", window.isMain());
  console.log("isNormal", window.isNormal());
  console.log("isFullScreen", window.isFullScreen());
  console.log("isVisible", window.isVisible());
  console.log("------");
}

function logAllApps() {
  App.all().forEach(function (app) {
    console.log(
      "app: " +
        JSON.stringify({
          name: app.name && app.name(),
          bundleIdentifier: app.bundleIdentifier && app.bundleIdentifier(),
        })
    );
  });

  console.log("focused", App.focused().name());
}
