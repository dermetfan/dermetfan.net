env:
data:

with data;

builtins.replaceStrings ["\n"] [" "] ''
  <iframe
    width="${width or "100%"}"
    style="
      height: ${height or "100vh"};
    "
    src="${src or data}"
  ></iframe>
''
