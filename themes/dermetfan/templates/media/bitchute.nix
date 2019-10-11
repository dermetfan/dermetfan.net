env:
data:

builtins.replaceStrings ["\n"] [""] ''
  <iframe
    width="${data.width or toString 640}"
    height="${data.height or toString 360}"
    scrolling="no"
    frameborder="0"
    style="border: none;"
    src="https://www.bitchute.com/embed/${data.id or data}/"
  ></iframe>
''
