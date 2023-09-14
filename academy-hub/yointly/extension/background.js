// background.js

// When a new tab is created or a tab's content is updated (navigation change)
browser.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  if (changeInfo.status === "complete") {
    console.log("Document loaded or navigation changed: " + tab.url);
  }
});

// When a new tab is created
browser.tabs.onCreated.addListener((tab) => {
  console.log("New tab opened: " + tab.url);
});
