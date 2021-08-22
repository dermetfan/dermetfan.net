{ lib }:

{
  theme.dermetfan = rec {
    filePath = file: "${./files}/${file}";

    readFile = file: builtins.readFile (filePath file);

    lines = text: lib.strings.splitString "\n" text;

    window = first: last: list: lib.lists.sublist first (last - first) list;

    repeat = string: count:
      lib.lists.foldr (i: accumulator:
        accumulator + string
      ) string (lib.lists.range 2 count);

    indent = prefix: count: lines:
      let
        fullPrefix = repeat prefix count;
      in
        map (line: fullPrefix + line) lines;

    codeSnippetLines =
      let
        removeCommonPrefixes = prefix: lines:
          let
            prefixCount_ = prefix: string: count:
              if lib.strings.hasPrefix prefix string
              then count + 1 + (prefixCount_ prefix (lib.strings.removePrefix prefix string) count)
              else count;

            prefixCount = prefix: string: prefixCount_ prefix string 0;

            prefixCounts = lib.lists.remove false (map (line:
              if line == ""
              then false
              else prefixCount prefix line
            ) lines);

            maxLineLength = lib.lists.foldr (len1: len2:
              lib.trivial.max len1 len2
            ) 0 (map builtins.stringLength lines);

            commonPrefixCount = lib.lists.foldr (count1: count2:
              lib.trivial.min count1 count2
            ) maxLineLength prefixCounts;

            commonPrefix = repeat prefix commonPrefixCount;
          in map (line:
            lib.strings.removePrefix commonPrefix line
          ) lines;

        unindent = lines: removeCommonPrefixes " " (
          removeCommonPrefixes "\t" lines
        );
      in first: last: file:
        unindent (
          window (first - 1) last (
            lines (
              readFile file
            )
          )
        );

    codeSnippet = first: last: file:
      lib.strings.concatStringsSep "\n" (
        codeSnippetLines first last file
      );

    codeSnippetIndent = first: last: file: prefix: count:
      lib.strings.concatStringsSep "\n" (
        indent prefix count (codeSnippetLines first last file)
      );

    capitalize = string:
      if string == "" then string else
      let
        chars = lib.strings.stringToCharacters string;
      in lib.concatStrings (
        [ (lib.strings.toUpper (lib.lists.head chars)) ] ++ (lib.lists.tail chars)
      );

    pkgs = { pkgs, secrets, hashes }: {
      inherit (
        pkgs.appendOverlays [ (self: super: {
          fetchurlCentral = { name, ... } @ args:
            super.fetchurl (
              (if hashes ? ${name} then {
                hash = hashes.${name};
              } else (builtins.trace "theme.dermetfan.pkgs.fetchurlCentral: no hash in ./hashes.nix for ${name}" {})) //
              args
            );

          githubApi = { checkError ? true, name ? null }: query:
            let
              response = builtins.fromJSON (
                builtins.readFile (let
                  data = builtins.toJSON { inherit query; };
                in self.fetchurlCentral {
                  url = https://api.github.com/graphql;
                  curlOpts = lib.concatStringsSep " " [
                    # needs argument files due to https://github.com/NixOS/nixpkgs/issues/41820
                    "-X" "POST"
                    "-H" ("@" + (super.writeText "headers.txt" ''
                      Authorization: token ${secrets.github.personalAccessToken}
                    ''))
                    "-d" ("@" + (super.writeText "data.txt" data))
                  ];
                  name = if name != null then name else
                    "githubApi-" + (builtins.hashString "md5" data);
                })
              );
            in if checkError then (
              if response ? "message"
              then builtins.throw response.message
              else response.data
            ) else response;
        }) ]
      ) fetchurlCentral githubApi;
    };
  };
}
