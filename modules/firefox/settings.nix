{
  # Disable firefox from overrride scroll settings
  "mousewheel.system_scroll_override.enabled" = false;

  # avoid hiding tabs and search bar in fullscreen
  "browser.fullscreen.autohide" = false;

  # Disable firefox intro tabs on the first start
  "browser.startup.homepage_override.mstone" = "ignore";

  # Disable new tab page intro
  "browser.newtabpage.introShown" = false;

  # Disable Sponsored Top Sites
  "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;

  # Disable about:config warning.
  "browser.aboutConfig.showWarning" = false;

  # Do not trim URLs in navigation bar
  # "browser.urlbar.trimURLs" = false;

  # Disable Heartbeat Userrating
  "browser.selfsupport.url" = "";

  # Content of the new tab page
  "browser.newtabpage.enhanced" = false;

  # Disable autoplay of video tags.
  # Per default, video tags are allowed to start automatically.
  # Note: When disabling autoplay, you will have to click pause and play again on
  # some video sites.
  "media.autoplay.enabled" = true;
  "media.autoplay.default" = 0;

  # Disable seinding Telemetry
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.archive.enabled" = false;
  "toolkit.telemetry.rejected" = true;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.unifiedIsOptIn" = false;
  "toolkit.telemetry.prompted" = 2;
  "toolkit.telemetry.server" = "";
  "toolkit.telemetry.cachedClientID" = "";
  "toolkit.telemetry.newProfilePing.enabled" = false;
  "toolkit.telemetry.shutdownPingSender.enabled" = false;
  "toolkit.telemetry.updatePing.enabled" = false;
  "toolkit.telemetry.bhrPing.enabled" = false;
  "toolkit.telemetry.firstShutdownPing.enabled" = false;
  "toolkit.telemetry.hybridContent.enabled" = false;
  "toolkit.telemetry.reportingpolicy.firstRun" = false;

  # Disable sending Firefox health reports to Mozilla
  # https://www.mozilla.org/privacy/firefox/#health-report
  "datareporting.healthreport.uploadEnabled" = false;
  "datareporting.policy.dataSubmissionEnabled" = false;
  "datareporting.healthreport.service.enabled" = false;

  # Disable shield studies
  # This feature allows mozilla to remotely install experimental addons.
  # https://wiki.mozilla.org/Firefox/Shield
  "app.normandy.enabled" = false;
  "app.normandy.api_url" = "";
  "app.shield.optoutstudies.enabled" = false;
  "extensions.shield-recipe-client.enabled" = false;
  "extensions.shield-recipe-client.api_url" = "";

  # Disable experiments
  # This feature allows Firefox to automatically download and run specially-designed
  # restartless addons based on certain conditions.
  # https://wiki.mozilla.org/Telemetry/Experiments
  "experiments.enabled" = false;
  "experiments.manifest.uri" = "";
  "experiments.supported" = false;
  "experiments.activeExperiment" = false;
  "network.allow-experiments" = false;

  # Disable Crash Reports
  # The crash report may contain data that identifies you or is otherwise sensitive to you.
  # https://www.mozilla.org/privacy/firefox/#crash-reporter
  "breakpad.reportURL" = "";
  "browser.tabs.crashReporting.sendReport" = false;
  "browser.crashReports.unsubmittedCheck.enabled" = false;
  "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
  "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

  # Opt out metadata updates
  # Firefox sends data about installed addons as metadata updates
  # so Mozilla is able to recommend you other addons.
  # https://blog.mozilla.org/addons/how-to-opt-out-of-add-on-metadata-updates/
  "extensions.getAddons.cache.enabled" = false;

  # Disable google safebrowsing
  # Google safebrowsing can detect phishing and malware but it also sends
  # informations to google together with an unique id called wrkey
  "browser.safebrowsing.enabled" = false;
  "browser.safebrowsing.downloads.remote.url" = "";
  "browser.safebrowsing.phishing.enabled" = false;
  "browser.safebrowsing.blockedURIs.enabled" = false;
  "browser.safebrowsing.downloads.enabled" = false;
  "browser.safebrowsing.downloads.remote.enabled" = false;
  "browser.safebrowsing.appRepURL" = "";
  "browser.safebrowsing.malware.enabled" = false;

  # Disable preloading of the new tab page.
  # "browser.newtab.preload" = false;

  # Disable access to device sensor data
  # Disallow websites to access sensor data (ambient light, motion, device
  # orientation and proximity data).
  "device.sensors.ambientLight.enabled" = false;
  "device.sensors.enabled" = false;
  "device.sensors.motion.enabled" = false;
  "device.sensors.orientation.enabled" = false;
  "device.sensors.proximity.enabled" = false;

  # Disable Firefox Suggest
  # This feature allows Mozilla to provide search suggestions in the US, which uses your
  # city location and search keywords to send suggestions. This is also used to
  # serve advertisements.
  # https://support.mozilla.org/en-US/kb/navigate-web-faster-firefox-suggest
  "browser.urlbar.groupLabels.enabled" = false;
  "browser.urlbar.quicksuggest.enabled" = false;

  # Disable Javascript in PDF viewer
  # It is possible that some PDFs are not rendered correctly due to missing functions.
  "pdfjs.enableScripting" = true;

  # Enable Do-not-Track
  "privacy.donottrackheader.enabled" = true;
  "privacy.donottrackheader.value" = 1;

  # Enable resistFingerprinting
  # This setting comes from the tor-browser. It hides some system properties
  # https://bugzilla.mozilla.org/show_bug.cgi?id=1308340">
  # This option may interfere with other privacy related settings 
  # https://github.com/allo-/firefox-profilemaker/issues/56#issuecomment-333397712
  "privacy.resistFingerprinting" = false;

  # Enable Mozilla Trackingprotection
  # Firefox has a builtin tracking protection which blocks a list of known tracking sites.
  # https://wiki.mozilla.org/Security/Tracking_protection
  "privacy.trackingprotection.pbmode.enabled" = true;
  "privacy.trackingprotection.enabled" = true;
  "privacy.trackingprotection.fingerprinting.enabled" = true;
  "privacy.trackingprotection.cryptomining.enabled" = true;

  # Enable firstparty isolation.
  # FPI works by separating cookies on a per-domain basis. In this way tracking
  # networks won't be able to locate the same cookie on different sites. 
  # Note that this might break third-party logins.
  "privacy.firstparty.isolate" = false;

  # Disable Browser Pings
  # Firefox sends "ping" requests when a website requests 
  # to be informed when a user clicks on a link.
  # http://kb.mozillazine.org/Browser.send_pings
  "browser.send_pings" = false;

  # Disable TLS session identifiers
  # TLS allows for session identifiers, which speed up the session resumption when a
  # connection was lost. These identifiers can be used for tracking
  # https://youbroketheinternet.org/trackedanyway
  "security.ssl.disable_session_identifiers" = true;

  # Disable Beacons
  # This eature allows websites to send tracking data after you left the website.
  # https://w3c.github.io/beacon/
  "beacon.enabled" = false;

  # Disable the Battery API
  # Firefox allows websites to read the charge level of the battery. 
  # This may be used for fingerprinting.
  "dom.battery.enabled" = false;

  # Disable media device queries
  # Prevent websites from accessing information about webcam and microphone
  # Possible fingerprinting
  # https://developer.mozilla.org/docs/Web/API/MediaDevices/enumerateDevices
  # "media.navigator.enabled" = false;

  # Disable form autofill
  # Automatically filled form fields are used for fingerprinting
  # This setting disables automatic form filling until you click on the field.
  # https://freedom-to-tinker.com/2017/12/27/no-boundaries-for-user-identities-web-trackers-exploit-browser-login-managers/
  # "signon.autofillForms" = false;

  # Disable webaudio API
  # Prevents fingerprinting.
  # https://bugzilla.mozilla.org/show_bug.cgi?id=1288359 
  # This can break web apps like Discord, which rely on the API.
  # "dom.webaudio.enabled" = false;

  # Disable video statistics
  # Prevent websites from measuring video performance. Possible fingerprinting
  # https://bugzilla.mozilla.org/show_bug.cgi?id=654550
  # "media.video_stats.enabled" = false;

  # Enable query parameter stripping
  # Firefox 102 introduced query parameter stripping like utm_source. Enabled by
  # default with Strict Enhanced Tracking Protection.
  "privacy.query_stripping" = true;

  # Disable autoupdate
  "app.update.auto" = false;

  # Disable extension blocklist from mozilla.
  # The extension blocklist is used by mozilla to deactivate individual addons in the browser, 
  # As a side effect it gives mozilla the ultimate control to disable any extension. 
  # Caution: When you disable the blocklist, you may keep using known malware addons.
  # https://blocked.cdn.mozilla.net/
  "extensions.blocklist.enabled" = true;

  # Enable HTTPS only mode
  # If enabled, allows connections only to sites that use the HTTPS protocol.
  "dom.security.https_only_mode" = true;
  "dom.security.https_only_mode_ever_enabled" = true;

  # Show Punycode.
  # This helps to protect against possible character spoofing.
  "network.IDN_show_punycode" = true;

  # Block Cookies
  # "network.cookie.cookieBehavior" = 1;

  # Block Referer
  # Firefox tells a website, from which site you're coming (the so called RefControl
  # (http://kb.mozillazine.org/Network.http.sendRefererHeader">referer</a>.
  # You can find more detailed settings in this
  # http://www.ghacks.net/2015/01/22/improve-online-privacy-by-controlling-referrer-information/
  # Install the "https://addons.mozilla.org/firefox/addon/refcontrol/ extension for per domain settings.
  # "network.http.referer.spoofSource" = true;

  # Disable DOM storage
  # Disables DOM storage, which enables so called "supercookies". 
  # Some modern sites will not work (i.e. missing "save" functions).
  # "dom.storage.enabled" = false;

  # Disable IndexedDB (breaks things)
  # abused for tracking (http://www.w3.org/TR/IndexedDB/">IndexedDB</a> is a way,
  # websites can store structured data. This can be <a
  # href="http://arstechnica.com/apple/2010/09/rldguid-tracking-cookies-in-safari-database-form/),
  # too. Disabling causes problems when sites depend on it like Tweetdeck or Reddit
  # and extensions that use it to store their data. Some users reported crashing
  # tabs when IndexedDB is disabled. Only disable it, when you know what you're
  # doing.
  # "dom.indexedDB.enabled" = false;

  # Disable the Offline Cache.
  # Websites can store up to 500 MB of data in an offline cache
  # (http://kb.mozillazine.org/Browser.cache.offline.enable), to be able to run even
  # when there is no working internet connection. This could possibly be used to
  # store an user id.
  # "browser.cache.offline.enable" = false;

  # Sessionstore Privacy
  # This preference controls when to store extra information about a session:
  # contents of forms, scrollbar positions, cookies, and POST data.
  "browser.sessionstore.privacy_level" = 2;

  # Disable Link Prefetching
  # "network.prefetch-next" = false;
  # "network.dns.disablePrefetch" = true;
  # "network.dns.disablePrefetchFromHTTPS" = true;
  # "network.predictor.enabled" = false;
  # "network.predictor.enable-prefetch" = false;

  # Disable speculative website loading.
  # In some situations Firefox already starts loading web pages on hover
  # This is to speed up the loading of web pages by a few milliseconds.
  # "network.http.speculative-parallel-limit" = 0;
  # "browser.urlbar.speculativeConnect.enabled" = false;

  # Use a private container for new tab page thumbnails
  # Load the pages displayed on the new tab page in a private container when creating thumbnails.
  "privacy.usercontext.about_newtab_segregation.enabled" = true;

  # Disable WebGL
  # Disables the WebGL function, to prevent (ab)use the full power of the graphics card
  # WebGL is part of some fingerprinting scripts used in the wild. 
  # Some interactive websites will not work, which are mostly games.
  # "webgl.disabled" = true;

  # Override graphics card vendor and model strings in the WebGL API
  # "webgl.renderer-string-override" = " ";
  # "webgl.vendor-string-override" = " ";

  # Disable WebRTC
  # It gives away your local ips. 
  # Some addons like uBlock origin provide settings to 
  # prevent WebRTC from exposing local ips without disabling WebRTC.
  # "media.peerconnection.enabled" = false;

  # Disable the clipboardevents.
  # Websites can get notifications if you copy, paste, or cut something
  # from a web page, and it lets them know which part of the page had been selected.
  # "dom.event.clipboardevents.enabled" = false;

  # Disable Search Suggestions
  # Firefox suggests search terms in the search field. 
  # This will send everything typed or pasted in the search field to the chosen search engine, 
  # even when you did not press enter.
  "browser.search.suggest.enabled" = true;

  # Disable Search Keyword
  # When you mistype some url, Firefox starts a search even from urlbar. 
  # This feature is useful for quick searching, but may harm your privacy, when it's unintended.
  "keyword.enabled" = true;

  # Disable Fixup URLs
  # When you type "something" in the urlbar and press enter, 
  # Firefox tries "something.com", if Fixup URLs is enabled.
  "browser.fixup.alternate.enabled" = true;

  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  "svg.context-properties.content.enabled" = true;

  "browser.download.dir" = "/home/yogesh/downloads";
  "browser.download.folderList" = 2;
  "browser.download.panel.shown" = true;
  "browser.download.viewableInternally.typeWasRegistered.avif" = true;
  "browser.download.viewableInternally.typeWasRegistered.webp" = true;
  "browser.toolbars.bookmarks.visibility" = "always";
  "browser.startup.couldRestoreSession.count" = 2;

  # "browser.uiCustomization.state" = ''
  #   {
  #     "placements": {
  #       "widget-overflow-fixed-list": [],
  #       "nav-bar": ["back-button","forward-button","home-button","stop-reload-button","customizableui-special-spring5","urlbar-container","save-to-pocket-button","customizableui-special-spring6","downloads-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","fxa-toolbar-menu-button"],
  #       "toolbar-menubar":["menubar-items"],
  #       "TabsToolbar":["tabbrowser-tabs","new-tab-button","privatebrowsing-button","alltabs-button"],
  #       "PersonalToolbar":["personal-bookmarks"]
  #     }
  #   }
  # '';
  # 
  #   user_pref(
  #   "browser.uiCustomization.state",
  #   '{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","home-button","stop-reload-button","customizableui-special-spring5","urlbar-container","customizableui-special-spring1","downloads-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","privatebrowsing-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","developer-button","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","ublock0_raymondhill_net-browser-action"],"dirtyAreaCache":["nav-bar","toolbar-menubar","TabsToolbar","PersonalToolbar"],"currentVersion":18,"newElementCount":2}'
  #   );

}
