{ lib }: {
  siteUrl = http://dermetfan.net;

  theme = {
    itemsPerPage = 10;
    site = {
      title = "dermetfan";
      description = "Blog";
      copyright = "Public Domain";
    };

    lib.highlightjs = {
      enable = true;
      extraLanguages = [ "nix" "rust" ];
    };
  };
}
