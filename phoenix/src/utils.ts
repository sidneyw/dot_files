export function logAllApps() {
  App.all().forEach(function (app) {
    console.log(
      "app: " +
        JSON.stringify({
          name: app.name && app.name(),
          bundleIdentifier: app.bundleIdentifier && app.bundleIdentifier(),
        })
    );
  });
}
