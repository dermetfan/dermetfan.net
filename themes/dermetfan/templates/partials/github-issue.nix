{ lib, ... }:
ownerArg: repoArg: numberArg:
showArg:

let
  show =
    if builtins.isList showArg then
      { # only explicit ones
        repo = false;
        type = false;
        title = false;
        state = false;
      } // builtins.listToAttrs (
        map (x: { name = x; value = true; }) showArg
      )
    else
      { # sensible defaults
        repo = false;
        type = true;
        title = true;
        state = true;
      } // showArg;

  repo = builtins.fromJSON (
    builtins.readFile (
      builtins.fetchurl "https://api.github.com/repos/${ownerArg}/${repoArg}"
    )
  );

  issue = builtins.fromJSON (
    builtins.readFile (
      builtins.fetchurl "https://api.github.com/repos/${ownerArg}/${repoArg}/issues/${toString numberArg}"
    )
  );

  pr = if !issue ? "pull_request" then {} else builtins.fromJSON (
    builtins.readFile (
      builtins.fetchurl issue.pull_request.url
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
