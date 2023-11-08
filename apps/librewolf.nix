{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
	
  username = (import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix")).username;

in

{
  environment.systemPackages = with pkgs; [
    librewolf
  ];


#  nixpkgs.config.packageOverrides = pkgs: {
#    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
#      inherit pkgs;
#    };
#  };


#  home-manager.users.${username}.programs.librewolf.profiles."default" = {
#    enable = true;

#    extensions = with pkgs.nur.repos.rycee.librewolf-addons; [
#      darkreader
#      bitwarden
#      simplelogin
#      noscript
#      translate-web-pages
#      #https-everywhere
#      ublock-origin
#      privacy-badger
#      i-dont-care-about-cookies
#      search-by-image
#      ];

#    profiles.default.settings = {
#
#      #- Région FR
#      "general.useragent.locale" = "FR";
#      "doh-rollout.home-region" = "FR";
#      "browser.search.region" = "FR";
#      "intl.accept_languages" = "fr";
#      "intl.locale.requested" = "fr";
#      "layout.spellcheckDefault" = 0;
#
#
#      #- Moteur de recherche
#      "browser.urlbar.placeholderName" = "DuckDuckGo";
#      "browser.urlbar.placeholderName.private" = "DuckDuckGo";   
#
#
#      #- User interface
#      "browser.bookmarks.defaultLocation" = "0kVHJmN5c6xx";
#      "browser.proton.toolbar.version" = 3;
#      "browser.engagement.home-button.has-removed" = true;
#      "browser.engagement.downloads-button.has-used" = true;
#      "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"personal-bookmarks\",\"urlbar-container\",\"downloads-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action\",\"https-everywhere_eff_org-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\",\"_d04b0b40-3dab-4f0b-97a6-04ec3eddbfb0_-browser-action\",\"idcac-pub_guus_ninja-browser-action\",\"_2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c_-browser-action\",\"_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"import-button\",\"save-to-pocket-button\"]},\"seen\":[\"save-to-pocket-button\",\"developer-button\",\"_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action\",\"_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action\",\"https-everywhere_eff_org-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"jid1-mnnxcxisbpnsxq_jetpack-browser-action\",\"jid1-kkzogwgsw3ao4q_jetpack-browser-action\",\"_d04b0b40-3dab-4f0b-97a6-04ec3eddbfb0_-browser-action\",\"_2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c_-browser-action\",\"_36bdf805-c6f2-4f41-94d2-9b646342c1dc_-browser-action\",\"idcac-pub_guus_ninja-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":18,\"newElementCount\":5}";
#      "browser.newtabpage.enabled" = false;
#      "app.normandy.first_run" = false;
#      "browser.startup.homepage" = "about:blank";
#      "browser.startup.couldRestoreSession.count" = 2;      
#      "browser.newtabpage.activity-stream.feeds.topsites" = false;
#      "browser.newtabpage.activity-stream.showSearch" = false;
#
#
#      #- Disable suggestions / recommendations
#      "extensions.htmlaboutaddons.recommendations.enabled" = false;
#      "browser.dataFeatureRecommendations.enabled" = false;
#      "browser.search.suggest.enabled" = false;
#      "browser.urlbar.suggest.engines" = false;
#      "browser.urlbar.suggest.openpage" = false;
#      "browser.urlbar.suggest.topsites" = false;
#      "browser.urlbar.suggest.history" = false;
#      "browser.urlbar.suggest.bestmatch" = false;
#      "browser.urlbar.suggest.searches" = false;
#      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
#      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
#
#
#      #- Disable studies
#      "app.shield.optoutstudies.enabled" = false;
#
#
#      #- Disable Password saving
#      "signon.rememberSignons" = false;
#      "signon.generation.enabled" = false;
#      "signon.autofillForms" = false;      
#      "signon.management.page.breach-alerts.enabled" = false;
#     
#
#      #- Disable Telemetry
#      "datareporting.healthreport.uploadEnabled" = false;
#      "datareporting.policy.dataSubmissionEnabled" = false;
#      "toolkit.telemetry.archive.enabled" = false;
#
#      #- Advanced disable telemetry
#      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
#      "browser.newtabpage.activity-stream.telemetry" = false;
#      "browser.ping-centre.telemetry" = false;
#      "toolkit.telemetry.bhrPing.enabled" = false;
#      "toolkit.telemetry.enabled" = false;
#      "toolkit.telemetry.firstShutdownPing.enabled" = false;
#      "toolkit.telemetry.hybridContent.enabled" = false;
#      "toolkit.telemetry.newProfilePing.enabled" = false;
#      "toolkit.telemetry.reportingpolicy.firstRun" = false;
#      "toolkit.telemetry.shutdownPingSender.enabled" = false;
#      "toolkit.telemetry.unified" = false;
#      "toolkit.telemetry.updatePing.enabled" = false;
#      "toolkit.telemetry.pioneer-new-studies-available" = false;
#      "devtools.onboarding.telemetry.logged" = false;
#      "datareporting.sessions.current.clean" = true;
#
#
#      #- Privacy - tracking
#      "privacy.donottrackheader.enabled" = true;
#      "privacy.trackingprotection.enabled" = true;
#      "privacy.trackingprotection.socialtracking.enabled" = true;
#      "privacy.annotate_channels.strict_list.enabled" = true;
#      "browser.contentblocking.category" = "strict";
#      
#
#      #- Privacy - history
#      "browser.privatebrowsing.autostart" = true;
#      "privacy.sanitize.sanitizeOnShutdown" = true;
#      "privacy.sanitize.pending" = "[{\"id\":\"shutdown\",\"itemsToClear\":[\"cache\",\"cookies\",\"offlineApps\"],\"options\":{}},{\"id\":\"newtab-container\",\"itemsToClear\":[],\"options\":{}}]";
#      "places.history.enabled" = false;
#      "privacy.clearOnShutdown.offlineApps" = true;
#
#
#      #- Privacy - Security
#      "browser.safebrowsing.downloads.remote.block_uncommon" = false;
#      "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
#      "dom.security.https_only_mode" = true;
#      "dom.security.https_only_mode_ever_enabled" = true;
#      "network.dns.disablePrefetch" = true;
#
#
#      #- Disable autofill
#      "dom.forms.autocomplete.formautofill" = false;
#      "extensions.formautofill.creditCards.enabled" = false;
#
#
#      #- Disable pocket
#      "extensions.pocket.enabled" = false;
#      "extensions.pocket.showHome" = false;      
#
#      };
#
#    };
#


}
