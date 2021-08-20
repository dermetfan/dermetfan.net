{ lib, ... }:
{
  alt ? "Input Output",
  title ? alt
}:

builtins.replaceStrings ["\n"] [" "] ''
  <img
    src="/iog.png"
    alt="${lib.escapeHTML alt}"
    title="${lib.escapeHTML title}"
    style="
      display: inline;
      height: 1em;
      vertical-align: middle;
      margin: 0;
    "
  />
''
