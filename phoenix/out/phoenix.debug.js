(()=>{"use strict";const n=Object.assign((function(...n){n=n.map((n=>o(n))),Phoenix.log(...n),console.trace(...n)}),{notify:(...n)=>{n=n.map((n=>o(n))),Phoenix.log(...n);const e=n.join(" ");Phoenix.notify(e),console.trace(...n)},noTrace:(...n)=>{n=n.map((n=>o(n))),Phoenix.log(...n),console.log(...n)}});function o(n){if(n instanceof Error){let o="";if(n.stack){const e=n.stack.trim().split("\n");e[0]+=` (:${n.line}:${n.column})`,o=`\n${e.map((n=>"\t at "+n)).join("\n")}`}return`\n${n.toString()}${o}`}switch(typeof n){case"object":return"\n"+JSON.stringify(n,null,2);case"function":return n.toString();default:return n}}function e(o){var e=App.get(o);if(!e)return e=App.launch(o),void n("launching",e?.name());n("focusing",e.name()),e.focus()}const t=["alt"];Key.on("b",t,(()=>e("Brave Browser"))),Key.on("q",t,(()=>e("iTerm2"))),Key.on("r",t,(()=>e("Roam Research"))),Key.on("1",t,(()=>e("Slack"))),Key.on("p",t,(()=>e("Spark"))),Key.on("s",t,(()=>e("Spotify"))),Key.on("t",t,(()=>e("TickTick"))),Key.on("z",t,(()=>e("zoom.us"))),Key.on("2",t,(function(){App.all().forEach((function(n){console.log("app: "+JSON.stringify({name:n.name&&n.name(),bundleIdentifier:n.bundleIdentifier&&n.bundleIdentifier()}))}))}))})();