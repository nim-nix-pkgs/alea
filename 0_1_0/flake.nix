{
  description = ''A library to work with random variables'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-alea-0_1_0.flake = false;
  inputs.src-alea-0_1_0.ref   = "refs/tags/0.1.0";
  inputs.src-alea-0_1_0.owner = "andreaferretti";
  inputs.src-alea-0_1_0.repo  = "alea";
  inputs.src-alea-0_1_0.type  = "github";
  
  inputs."random".owner = "nim-nix-pkgs";
  inputs."random".ref   = "master";
  inputs."random".repo  = "random";
  inputs."random".dir   = "v0_5_7";
  inputs."random".type  = "github";
  inputs."random".inputs.nixpkgs.follows = "nixpkgs";
  inputs."random".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-alea-0_1_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-alea-0_1_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}