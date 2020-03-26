{ lib, ... }:
taxonomy: terms:

let
  liStyle = ''
    display: inline-block;
    padding-right: 2em;
  '';
in

''
  <ul style="
    list-style: none;
    opacity: 0.5;
  ">
    <li style="${liStyle}">
      ${lib.theme.dermetfan.capitalize taxonomy}:
    </li>
'' +

lib.concatStrings (
  map (term: ''
    <li style="${liStyle}">
      <a href="${lib.mkTaxonomyTermPath taxonomy term}">
        ${term}
      </a>
    </li>
  '') terms
) +

"</ul>"
