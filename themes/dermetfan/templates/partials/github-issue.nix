{ lib, conf, pkgs, ... }:
owner: repo: number: showArg:

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
        map (field: lib.nameValuePair field true) showArg
      )
    else
      { # sensible defaults
        owner = false;
        repo = false;
        type = true;
        title = true;
        state = true;
      } // showArg;

  libPkgs = lib.theme.dermetfan.pkgs {
    inherit pkgs;
    inherit (conf.data) secrets hashes;
  };

  data = (libPkgs.githubApi {
    name = "github_${owner}_${repo}_issues_${toString number}";
  } ''{
    repository(name: "${repo}", owner: "${owner}") {
      issueOrPullRequest(number: ${toString number}) {
        ... on Issue {
          url title
          issueState: state
        }
        ... on PullRequest {
          url title
          prState: state
        }
      }
    }
  }'').repository.issueOrPullRequest;
in

lib.concatStringsSep " " (
  (lib.optional show.repo repo) ++
  (lib.optional show.type (if data ? prState then "PR" else "issue")) ++
  [ "<a href=\"${data.url}\">#${toString number}</a>" ] ++
  (lib.optional show.title "\"${lib.escapeHTML (lib.escape [ "[" "]" "(" ")" "`" ] data.title)}\"") ++
  (lib.optional show.state "(${lib.toLower (data.prState or data.issueState)})")
)
