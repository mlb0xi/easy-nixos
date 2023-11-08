{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
  ];


  programs.chromium = {
    enable = true;    
          
    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://duckduckgo.com/?t=ffab&q={searchTerms}";

    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      #"doojmbjmlfjjnbmnoijecmcbfeoakpjm" # noscript
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # privacy badger
      "edibdbjcniadpccecjdfdjjppcpchdlm" # i still dont care about cookies
      "gebbhagfogifgggkldgodflihgfeippi" # youtube dislike
    ];


    extraOpts = {
      "SpellcheckEnabled" = false;
      "PasswordManagerEnabled" = false;
      "AutoFillEnabled" = false;
      "AutofillAddressEnabled" = false;
      "AutoFillCreditCardEnabled" = false;
      "PaymentMethodQueryEnabled" = false;
      "SyncDisabled" = true;
      "BrowserSignin" = 0;
      "HomepageIsNewTabPage" = true;   # Nouvel onglet page accueil
      "BackgroundModeEnabled" = false; # Poursuivre l'exécution en arrière-plan
      "BlockThirdPartyCookies" = true; # Bloquer les cookies tiers
      "EnableExperimentalPolicies" = false; # Activer les règles expérimentales
      "SafeBrowsingProtectionLevel" = 0; # Désactiver la navigation "sécurisée" Google
      "HttpsOnlyMode" = true;
    };

  };
  
}
