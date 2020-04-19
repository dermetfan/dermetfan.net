{ lib }:

{
  theme.dermetfan = rec {
    readFile = file: builtins.readFile (./files + "/${file}");

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
      let
        chars = lib.strings.stringToCharacters string;
      in lib.concatStrings (
        [ (lib.strings.toUpper (lib.lists.head chars)) ] ++ (lib.lists.tail chars)
      );

    fetchurlImpure = { runCommandLocal, curl, cacert }:
      { url, curlOpts ? "" }:
      runCommandLocal "fetchurlImpure-${builtins.getEnv "STYX_FETCHURL_VERSION"}" {
        __noChroot = true;
        inherit url;
        buildInputs = [
          curl
          cacert
        ];
      } ''
        curl ${curlOpts} "$url" > $out
      '';
  };
}
