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

  callApi = graphql:
    let
      response =
        (pkgs.callPackage lib.theme.dermetfan.githubApi {
          fetchurlImpure = pkgs.callPackage lib.theme.dermetfan.fetchurlImpure {};
        })
          conf.secrets.github.personalAccessToken
          graphql;
    in
      if response ? "message"
      then builtins.throw response.message
      else response.data;

  data = (callApi ''{
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
