// firefox config for neko
lockPref("browser.tabs.closeWindowWithLastTab", false);
lockPref("app.update.auto", false);
lockPref("app.update.enabled", false);
lockPref("app.update.silent", true);
lockPref("browser.cache.disk.capacity", 1000);
lockPref("browser.download.useDownloadDir", false);
lockPref("browser.rights.3.shown", true);
lockPref("browser.search.update", false);
lockPref("browser.shell.checkDefaultBrowser", false);
lockPref("extensions.update.enabled", false);
lockPref("plugin.default_plugin_disabled", false);
lockPref("plugin.scan.plid.all", true);
lockPref("plugins.hide_infobar_for_missing_plugin", true);
lockPref("profile.allow_automigration", false);
lockPref("signon.prefillForms", false);
lockPref("signon.rememberSignons", false);
lockPref("browser.download.manager.retention", 0);
lockPref("browser.download.folderList",	2);
lockPref("browser.download.forbid_open_with", true);
lockPref("browser.safebrowsing.downloads.enabled", false);
lockPref("browser.safebrowsing.downloads.remote.enabled",	false);
lockPref("browser.helperApps.alwaysAsk.force",	false);
lockPref("browser.helperApps.neverAsk.saveToDisk",	"application/zip,application/octet-stream,image/jpeg,application/vnd.ms-outlook,text/html,application/pdf");
lockPref("browser.helperApps.neverAsk.openFile",	"application/zip,application/octet-stream,image/jpeg,application/vnd.ms-outlook,text/html,application/pdf");
// Language
lockPref("intl.locale.requested", "en");
lockPref("intl.locale.matchOS", false);
// dark mode
lockPref("reader.color_scheme", "dark");
lockPref("devtools.theme", "dark");
lockPref("ui.systemUsesDarkTheme", 1);
lockPref("lightweightThemes.usedThemes","[]");
lockPref("lightweightThemes.selectedThemeID", "firefox-compact-dark@mozilla.org");
lockPref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
lockPref("browser.theme.toolbar-theme", 0);
lockPref("browser.in-content.dark-mode", true);
lockPref("browser.newtabpage.activity-stream.default.sites",	"http://www.yointly.com/,http://www.yointly.com/");

lockPref("intl.accept_languages", "en-US, en");

// user agent
lockPref('general.useragent.override', 'Mozilla/5.0 (X11; Linux; rv:109.0) codx yointly Gecko/20100101 Firefox/117.0');

// userChrome.js
lockPref('xpinstall.signatures.required', false);
lockPref('extensions.install_origins.enabled', false);
lockPref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

try {
  const cmanifest = Cc['@mozilla.org/file/directory_service;1'].getService(Ci.nsIProperties).get('UChrm', Ci.nsIFile);
  cmanifest.append('utils');
  cmanifest.append('chrome.manifest');
  Components.manager.QueryInterface(Ci.nsIComponentRegistrar).autoRegister(cmanifest);

  const objRef = ChromeUtils.import('resource://gre/modules/addons/AddonSettings.jsm');
  const temp = Object.assign({}, Object.getOwnPropertyDescriptors(objRef.AddonSettings), {
    REQUIRE_SIGNING: { value: false }
  });
  objRef.AddonSettings = Object.defineProperties({}, temp);

  Cu.import('chrome://userchromejs/content/BootstrapLoader.jsm');
} catch (ex) {};

try {
  Cu.import('chrome://userchromejs/content/userChrome.jsm');
} catch (ex) {};
