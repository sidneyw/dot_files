import {
  centerWindowInFrame,
  frameOfNextScreen,
  frameOfPrevScreen,
  maximizeWindowInFrame,
  windowFitsInFrame,
} from "./utils";

export function center() {
  const window = Window.focused();
  if (!window) {
    return;
  }

  centerWindowInFrame(window, window.screen().frame());
}

export function centerTwoThirds() {
  const window = Window.focused();
  if (!window) {
    return;
  }
  const screenFrame = window.screen().flippedVisibleFrame();

  const width = (screenFrame.width * 2) / 3;
  const leftPad = (screenFrame.width - width) / 2;

  window.setFrame({
    x: leftPad,
    y: screenFrame.y,
    width: width,
    height: screenFrame.height,
  });
}

export function leftHalf() {
  const window = Window.focused();
  if (!window) {
    return;
  }
  const screenFrame = window.screen().flippedVisibleFrame();

  window.setFrame({
    x: screenFrame.x,
    y: screenFrame.y,
    width: screenFrame.width / 2,
    height: screenFrame.height,
  });
}

export function rightHalf() {
  const window = Window.focused();
  if (!window) {
    return;
  }
  const screenFrame = window.screen().flippedVisibleFrame();

  window.setFrame({
    x: screenFrame.x + screenFrame.width / 2,
    y: screenFrame.y,
    width: screenFrame.width / 2,
    height: screenFrame.height,
  });
}

export function nextScreen() {
  const window = Window.focused();
  const nextScreenFrame = frameOfNextScreen(window);
  if (!window || !nextScreenFrame) {
    return;
  }

  if (windowFitsInFrame(window, nextScreenFrame)) {
    centerWindowInFrame(window, nextScreenFrame);
  } else {
    maximizeWindowInFrame(window, nextScreenFrame);
  }
}

export function prevScreen() {
  const window = Window.focused();
  const prevScreenFrame = frameOfPrevScreen(window);
  if (!window || !prevScreenFrame) {
    return;
  }

  if (windowFitsInFrame(window, prevScreenFrame)) {
    centerWindowInFrame(window, prevScreenFrame);
  } else {
    maximizeWindowInFrame(window, prevScreenFrame);
  }
}

export function fullScreen() {
  const window = Window.focused();
  if (!window) {
    return;
  }
  const screenFrame = window.screen().flippedVisibleFrame();

  window.setFrame({
    x: screenFrame.x,
    y: screenFrame.y,
    width: screenFrame.width,
    height: screenFrame.height,
  });
}
