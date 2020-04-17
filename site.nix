{
  styx,
  extraConf ? {}
}:

rec {
  inherit (
    let
      themes = with (import styx.themes); [
        generic-templates
        ghostwriter
        themes/dermetfan
      ];

      styxLib = import styx.lib styx;
    in
      styxLib.themes.load {
        inherit styxLib themes;
        extraEnv = { inherit data pages; };
        extraConf = [ ./conf.nix extraConf ];
      }
  ) conf lib files templates env;

  data = with lib; {
    about = loadFile {
      file = ./data/pages/about.md;
      inherit env;
    };

    posts = sortBy "date" "dsc" (loadDir {
      dir = ./data/posts;
      inherit env;
    });

    tags = mkTaxonomyData {
      data = pages.posts.list;
      taxonomies = [ "tags" ];
    };

    menu = with pages; [
      (lib.head index)
      {
        title = "Tags";
        path = lib.mkTaxonomyPath "tags";
      }
      about
    ];

    author = {
      name = "dermetfan";
      url = http://dermetfan.net;
    };
  };

  pages = with lib; rec {
    index = mkSplit {
      title = "Home";
      basePath = "/index";
      itemsPerPage = conf.theme.itemsPerPage;
      template = templates.index;
      data = posts.list;
    };

    feed = {
      path = "/feed.xml";
      template = templates.feed.atom;
      layout = id;
      items = take conf.theme.itemsPerPage posts.list;
    };

    about = {
      path = "/about/index.html";
      template = templates.page.full;
    } // data.about;

    posts = mkPageList {
      data = data.posts;
      pathPrefix = "/posts/";
      template = templates.post.full;
      author = data.author;
    };

    tags = mkTaxonomyPages {
      data = data.tags;
      taxonomyTemplate = templates.taxonomy.full;
      termTemplate = templates.taxonomy.term.full;
      taxonomyPageFn = taxonomy: {
        title = lib.theme.dermetfan.capitalize taxonomy;
      };
      termPageFn = taxonomy: tag: {
        title =
          (lib.strings.removeSuffix "s" (
            lib.theme.dermetfan.capitalize taxonomy
          )) +
          ": ${tag}";
      };
    };
  };

  site = with lib; mkSite {
    inherit files;

    pageList = pagesToList {
      inherit pages;
      default = { layout = templates.layout; };
    };

    substitutions = {
      inherit (conf) siteUrl;
    };

    postGen = ''
      cd $out/posts/zig-with-c-web-servers
      tar -chaf h2o.tar.gz h2o
      tar -chaf facil.io.tar.gz facil.io
    '';
  };
}
