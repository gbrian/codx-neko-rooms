// ==UserScript==
// @name           Navigation Event Listener
// @namespace      http://your.namespace.com
// @description    Listens for navigation events in Firefox
// @include        *
// ==/UserScript==

console.log("Loading yointly uc")
// Import the necessary interfaces
const { classes: Cc, interfaces: Ci, utils: Cu } = Components;

// Event listener for when a new page starts loading
function onPageLoad(event) {
  const { subject, topic } = event;
  if (topic === 'xul-overlay-merged') {
    // Get the web progress object from the subject
    const webProgress = subject.QueryInterface(Ci.nsIInterfaceRequestor)
                               .getInterface(Ci.nsIWebProgress);
    // Get the new URI that the browser is navigating to
    const location = webProgress.DOMWindow.document.location.href;
    console.log('Navigating to:', location);

    // You can perform additional actions here based on the navigation event
    // For example, you could check the domain, page title, etc., and react accordingly.
  }
}

// Register the event listener
const registrar = Cc["@mozilla.org/embedcomp/window-watcher;1"].getService(Ci.nsIWindowWatcher);
registrar.registerNotification(onPageLoad);

// Cleanup function when the script is unloaded
function cleanup() {
  registrar.unregisterNotification(onPageLoad);
}

// Register the cleanup function to be called when the script is unloaded
window.addEventListener('unload', cleanup);