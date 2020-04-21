{ lib, templates, ... }:
data:

lib.concatStrings [
  (templates.tag.link-css { href = templates.url "/styles/asciidoctor-default-anchor.css"; })
  ''
    <style>
    .olist > ol > li > p,
    .ulist > ul > li > p {
        margin-bottom: 0;
    }
    </style>
  ''
]
