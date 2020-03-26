{ lib }: {
  siteUrl = http://dermetfan.net;

  theme = {
    itemsPerPage = 10;

    site = {
      title = "dermetfan";
      description = "Blog";
      copyright = "Public Domain";
    };

    social = {
      github = https://github.com/dermetfan;
      # email = "serverkorken@gmail.com"; # bug in styx templates/partials/content-pre.nix
      linked-in = https://www.linkedin.com/in/dermetfan;
      stack-overflow = https://stackoverflow.com/users/2317275/dermetfan?tab=profile;
      twitter = https://twitter.com/dermetfan;
    };

    lib.highlightjs = {
      enable = true;
      extraLanguages = [ "nix" "rust" ];
    };
  };
}
