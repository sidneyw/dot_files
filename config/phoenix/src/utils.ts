import log from "./logger";

export function focusOrStart(title: string) {
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

export function frameOfNextScreen(window?: Window): Rectangle | undefined {
  if (!window) {
    return;
  }

  if (!window || !window.screen().next()) {
    return;
  }
  return window.screen().next().flippedVisibleFrame();
}

export function frameOfPrevScreen(window?: Window): Rectangle | undefined {
  if (!window) {
    return;
  }

  if (!window || !window.screen().previous()) {
    return;
  }
  return window.screen().previous().flippedVisibleFrame();
}

export function windowFitsInFrame(window: Window, targetFrame: Rectangle) {
  const windowFrame = window.frame();
  return (
    windowFrame.width <= targetFrame.width &&
    windowFrame.height <= targetFrame.height
  );
}
export function centerWindowInFrame(window: Window, targetFrame: Rectangle) {
  const windowFrame = window.frame(),
    targetFrameCenter = {
      x: targetFrame.x + targetFrame.width / 2,
      y: targetFrame.y + targetFrame.height / 2,
    };
  window.setTopLeft({
    x: targetFrameCenter.x - windowFrame.width / 2,
    y: targetFrameCenter.y - windowFrame.height / 2,
  });
}

export function maximizeWindowInFrame(window: Window, targetFrame: Rectangle) {
  window.setFrame(targetFrame);
}
