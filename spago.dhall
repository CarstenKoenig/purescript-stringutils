{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "stringutils"
, license =
    "Apache-2.0"
, repository =
    "git://github.com/menelaos/purescript-stringutils.git"
, dependencies =
    [ "arrays"
    , "assert"
    , "console"
    , "effect"
    , "either"
    , "functions"
    , "integers"
    , "lists"
    , "maybe"
    , "partial"
    , "prelude"
    , "psci-support"
    , "quickcheck"
    , "strings"
    , "unsafe-coerce"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
