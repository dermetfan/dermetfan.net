{
  styx,
  styxLib ? import styx.lib styx,
  extraConf ? {},
  pkgs
} @ args:

rec {
  inherit (
    let
      themes = with (import styx.themes { inherit pkgs; }); [
        generic-templates
        ghostwriter
        themes/dermetfan
      ];
    in
      styxLib.themes.load {
        inherit styxLib themes;
        extraEnv = { inherit data pages pkgs; };
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
      url = conf.siteUrl;
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

  site = (with lib; mkSite {
    inherit files;

    pageList = pagesToList {
      inherit pages;
      default = { layout = templates.layout; };
    };

    substitutions = {
      inherit (conf) siteUrl;
    };

    postGen = ''
      asciidoctor_css=$(dirname $(realpath ${pkgs.asciidoctor}/bin/asciidoctor))/../lib/ruby/gems/*/gems/${pkgs.asciidoctor.meta.name}/data/stylesheets/asciidoctor-default.css
      head -n 185 $asciidoctor_css | tail -n 3 > $out/styles/asciidoctor-default-anchor.css

      cd $out/posts/zig-with-c-web-servers
      tar -chaf h2o.tar.gz h2o
      tar -chaf facil.io.tar.gz facil.io
    '';
  }) // {
    overrideArgs = f: (import ./site.nix (args // (f args))).site;
  };
}
