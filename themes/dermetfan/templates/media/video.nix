{ lib, ... }:
data:

builtins.replaceStrings ["\n"] [""] ''
  <video
    controls
    width="${data.width or toString 640}"
    ${lib.optionalString (data ? height) ''height="${toString data.height}"''}
    src="${data.src or data}"
  >${data.fallback or ""}</video>
''
