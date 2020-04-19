{ lib, conf, pkgs, ... }:
ownerArg: repoArg: numberArg:
showArg:

let
  show =
    if builtins.isList showArg then
      { # only explicit ones
        owner = false;
        repo = false;
        type = false;
        title = false;
        state = false;
      } // builtins.listToAttrs (
        map (x: { name = x; value = true; }) showArg
      )
    else
      { # sensible defaults
        owner = false;
        repo = false;
        type = true;
        title = true;
        state = true;
      } // showArg;

  fetchurlImpure = url: (pkgs.callPackage lib.theme.dermetfan.fetchurlImpure {}) {
    inherit url;
    curlOpts = "-H 'Authorization: token ${conf.secrets.github.personalAccessToken}'";
  };

  callApi = endpoint: builtins.fromJSON (
    builtins.readFile (
      fetchurlImpure "https://api.github.com/${endpoint}"
    )
  );

  repo = callApi "repos/${ownerArg}/${repoArg}";

  issue = callApi "repos/${ownerArg}/${repoArg}/issues/${toString numberArg}";

  pr = if !issue ? "pull_request" then {} else builtins.fromJSON (
    builtins.readFile (
      fetchurlImpure issue.pull_request.url
    )
  );
in

lib.concatStringsSep " " (
  (lib.optional show.repo repo.name) ++
  (lib.optional show.type (if pr != {} then "PR" else "issue")) ++
  [ "[\\#${toString issue.number}](${issue.html_url})" ] ++
  (lib.optional show.title "\"${issue.title}\"") ++
  (lib.optional show.state "(${if pr.merged or false then "merged" else issue.state})")
)
