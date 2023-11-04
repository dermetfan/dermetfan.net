{---
title = "About";
---}

Site Reliability Engineer at [IOHK](https://iohk.io).  
*Views expressed are my own and do not necessarily reflect the view of IOHK.*

Currently I focus on [Zig], [Rust], and the [NixOS] ecosystem.

[Zig]: https://ziglang.org
[Rust]: https://rust-lang.org
[NixOS]: https://nixos.org

Find me on:

- Sourcehut: [Git](https://git.sr.ht/~dermetfan), [Hg](https://hg.sr.ht/~dermetfan)
- [GitHub](https://github.com/dermetfan)
- [LinkedIn](https://www.linkedin.com/in/dermetfan)

E-Mail: serverkorken *ät* gmail *dot* com  
PGP Key: [`F557 0395 64B9 E4F0 D5A1 2AEC FEC7 CED7 D00E 2CBD`](https://keys.openpgp.org/vks/v1/by-fingerprint/F557039564B9E4F0D5A12AECFEC7CED7D00E2CBD)

---

## Projects

### Nix / NixOS

- My personal Nix flake that defines:
	- [NixOS configurations](https://git.sr.ht/~dermetfan/garnix/tree/master/item/parts/nixosConfigurations) for my laptops and home servers
	- my [dotfiles](https://git.sr.ht/~dermetfan/garnix/tree/master/item/parts/homeManagerProfiles/dermetfan) using [home-manager](https://github.com/rycee/home-manager/).
	- a few [nix packages](https://git.sr.ht/~dermetfan/garnix/tree/master/item/parts/overlays), [NixOS modules](https://git.sr.ht/~dermetfan/garnix/tree/master/item/parts/nixosModules), [home-manager modules](https://git.sr.ht/~dermetfan/garnix/tree/master/item/parts/homeManagerModules), and [library functions](https://git.sr.ht/~dermetfan/garnix/tree/master/item/parts/lib) that are not in nixpkgs
- [This blog](https://hg.sr.ht/~dermetfan/dermetfan-blog) using the [Styx](https://styx-static.github.io/styx-site/) static site generator
- [home-manager-shell](https://git.sr.ht/~dermetfan/home-manager-shell), like nix-shell for your home-manager configuration
- A [NixOS module for SeaweedFS](https://hg.sr.ht/~dermetfan/seaweedfs-nixos) I wrote to test failure scenarios
- A [Nix flake for Filestash](https://git.sr.ht/~dermetfan/filestash.nix) that defines packages and a NixOS module
- A [Nix package for Keymouse](https://git.sr.ht/~dermetfan/keymouse-flake)

### Rust

- [ISO 8601](https://crates.io/crates/iso-8601) parser  
  *Born out of {{ templates.partials.github-issue "chronotope" "chrono" 244 { repo = true; title = false; } }}.*
- Learning project: Conway's [Game of Life](https://hg.sr.ht/~dermetfan/cursedlife) for the terminal using ncurses

### Zig

- [embed-dir](https://hg.sr.ht/~dermetfan/embed-dir): A small Zig library for embedding directory trees with `@embedFile`

### Java

- [libGDX] tutorials on [YouTube](https://youtube.com/dermetfan)
- [`libgdx-utils`](https://hg.sr.ht/~dermetfan/libgdx-utils) and `libgdx-utils-box2d`, a support library for [libGDX]-powered games and applications  
  *I have not worked on this library in years so I am happy to see it live on in Tommy Ettinger's [fork](https://github.com/tommyettinger/gdx-utils).*

[libGDX]: https://libgdx.com

### Go

- [Cicero](https://github.com/input-output-hk/cicero), an if-this-then-that machine on HashiCorp Nomad that is both event- and state-based.  
  {{ templates.partials.iog-logo-inline { title = "IOHK project"; } }} *This is an IOHK project on which I am the primary author.*  
  *See IOHK's ci-world repository for our [production deployment](https://github.com/input-output-hk/ci-world/blob/main/nix/cloud/nomadEnvs/cicero/default.nix).*
- [Tullia](https://github.com/input-output-hk/tullia), a sandboxed multi-runtime task DAG runner with Cicero integration.  
  {{ templates.partials.iog-logo-inline { title = "IOHK project"; } }} *This is an IOHK project on which I am the secondary author.*

### Lua

- [Git and Mercurial plugin](https://hg.sr.ht/~dermetfan/micro-vcs) for the [micro](https://micro-editor.github.io/) text editor  
  *Abandoned as such a feature comes with micro since {{ templates.partials.github-issue "zyedidia" "micro" 1487 [ "title" ] }}.*

## Involvement in Free and Open Source Projects

### Home Manager

#### Authored

- {{ templates.partials.github-issue "rycee" "home-manager" 2644 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 2642 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 2641 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 1185 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 1163 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 1162 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"  932 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"  296 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"   56 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"   20 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"   19 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"   16 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"    3 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"    2 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 122 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"  84 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"  55 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager"   4 {} }}

#### Reviewed or Merged

- {{ templates.partials.github-issue "rycee" "home-manager" 4603 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 3273 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 3272 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 1289 {} }}
- {{ templates.partials.github-issue "rycee" "home-manager" 1106 {} }}

### NixOS-shell

- {{ templates.partials.github-issue "Mic92" "nixos-shell" 5 {} }}
- {{ templates.partials.github-issue "Mic92" "nixos-shell" 4 {} }}
- {{ templates.partials.github-issue "Mic92" "nixos-shell" 1 {} }}
- {{ templates.partials.github-issue "Mic92" "nixos-shell" 3 {} }}

### NixOS / Nixpkgs

- {{ templates.partials.github-issue "NixOS" "nixpkgs" 210705 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs" 144458 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs" 138801 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs" 137395 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs" 136122 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs" 136121 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs" 134946 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  74781 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  74552 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  54197 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  29113 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  26552 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  26541 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  26215 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  25802 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  25009 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  21538 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  20020 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  17068 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  20448 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  20449 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  21540 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  22737 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  23282 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  24438 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  29026 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  29037 {} }}
- {{ templates.partials.github-issue "NixOS" "nixpkgs"  29055 {} }}

### Nix

- {{ templates.partials.github-issue "NixOS" "nix" 8284 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}
- {{ templates.partials.github-issue "NixOS" "nix" 6083 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### nix.dev

- {{ templates.partials.github-issue "NixOS" "nix.dev" 316 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### bitte

- {{ templates.partials.github-issue "input-output-hk" "bitte"     63 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}
- {{ templates.partials.github-issue "input-output-hk" "bitte-cli" 28 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### Cardano Node

- {{ templates.partials.github-issue "input-output-hk" "cardano-node" 4489 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}
- {{ templates.partials.github-issue "input-output-hk" "cardano-node" 4518 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### Cardano DB Sync

- {{ templates.partials.github-issue "input-output-hk" "cardano-db-sync" 1280 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### Cardano Ledger

- {{ templates.partials.github-issue "input-output-hk" "cardano-ledger" 3137 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}
- {{ templates.partials.github-issue "input-output-hk" "cardano-ledger" 3097 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### Cardano Ogmios

- {{ templates.partials.github-issue "input-output-hk" "cardano-ogmios" 5 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### Cardano Addresses

- {{ templates.partials.github-issue "input-output-hk" "cardano-addresses" 205 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### Cardano Base

- {{ templates.partials.github-issue "input-output-hk" "cardano-base" 339 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}
- {{ templates.partials.github-issue "input-output-hk" "cardano-base" 323 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### data-merge

- {{ templates.partials.github-issue "divnix" "data-merge" 1 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### nomad-driver-podman

- {{ templates.partials.github-issue "hashicorp" "nomad-driver-podman" 183 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### go-echarts

- {{ templates.partials.github-issue "go-echarts" "go-echarts" 207 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}
- {{ templates.partials.github-issue "go-echarts" "go-echarts" 206 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### indoc

- {{ templates.partials.github-issue "dtolnay" "indoc" 33 {} }}

### id-tree

- {{ templates.partials.github-issue "iwburns" "id-tree" 89 {} }}
- {{ templates.partials.github-issue "iwburns" "id-tree" 87 {} }}

### Yew

- {{ templates.partials.github-issue "yewstack" "yew" 480 {} }}

### yew_svg

- {{ templates.partials.github-issue "ywzjackal" "yew_svg" 1 {} }}

### ructe

- {{ templates.partials.github-issue "kaj" "ructe" 33 {} }}
- {{ templates.partials.github-issue "kaj" "ructe"  4 {} }}

### Cursive

- {{ templates.partials.github-issue "gyscos" "cursive" 254 {} }}
- {{ templates.partials.github-issue "gyscos" "cursive" 107 {} }}
- {{ templates.partials.github-issue "gyscos" "cursive" 106 {} }}
- {{ templates.partials.github-issue "gyscos" "cursive" 105 {} }}

### micro

- {{ templates.partials.github-issue "zyedidia" "micro" 841 {} }}
- {{ templates.partials.github-issue "zyedidia" "micro" 808 {} }}
- {{ templates.partials.github-issue "zyedidia" "micro" 807 {} }}
- {{ templates.partials.github-issue "zyedidia" "micro" 804 {} }}
- {{ templates.partials.github-issue "zyedidia" "micro" 803 {} }}
- {{ templates.partials.github-issue "zyedidia" "micro" 799 {} }}
- {{ templates.partials.github-issue "zyedidia" "micro" 798 {} }}

### Kakoune

- {{ templates.partials.github-issue "mawww" "kakoune" 4267 {} }}

### Zig

- {{ templates.partials.github-issue "ziglang" "zig" 4797 {} }}

### Zig Language Server

- {{ templates.partials.github-issue "zigtools" "zls" 330 {} }}

### Broot

- {{ templates.partials.github-issue "Canop" "broot" 467 {} }}

### libGDX

- {{ templates.partials.github-issue "libgdx" "libgdx" 3151 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2976 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2945 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2572 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2571 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2328 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2316 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 1692 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 1665 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 1602 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx"  861 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 3057 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2974 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2947 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2943 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2777 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2710 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 2345 {} }}
- {{ templates.partials.github-issue "libgdx" "libgdx" 1951 {} }}

### swaylock-fancy

- {{ templates.partials.github-issue "Big-B" "swaylock-fancy" 4 {} }}
- {{ templates.partials.github-issue "Big-B" "swaylock-fancy" 3 {} }}

### EdgeDB

- {{ templates.partials.github-issue "edgedb" "edgedb" 2231 {} }}
- {{ templates.partials.github-issue "edgedb" "edgedb" 2232 {} }}

### CUE

- {{ templates.partials.github-issue "cue-lang" "cue" 1123 {} }} {{ templates.partials.iog-logo-inline { title = "while working for IOHK"; } }}

### svelte-select

- {{ templates.partials.github-issue "rob-balfre" "svelte-select" 247 {} }}

### Flowblade

- {{ templates.partials.github-issue "jliljebl" "flowblade" 131 {} }}

### jadpole.github.io

- {{ templates.partials.github-issue "jadpole" "jadpole.github.io" 7 {} }}
