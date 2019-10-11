env:
data:

builtins.replaceStrings ["\n"] [""] ''
  <iframe
    width="${data.width or "100%"}"
    style="
      height: ${data.height or "100vh"};
    "
    src="${data.src or data}"
  ></iframe>
''
