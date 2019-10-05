module Data.Char.Utils
  ( fromCodePoint
  , isSurrogate
  , toCodePoint
  , unsafeFromCodePoint
  )
where

import Data.Function.Uncurried ( Fn1, Fn3, runFn1, runFn3 )
import Data.Int.Bits           ( (.&.) )
import Data.Maybe              ( Maybe(Just, Nothing) )
import Prelude
import Prim.TypeError          ( class Warn, Text )


-- | DEPRECATED: With the adoption of CodePoints in `purescript-strings`, this
-- | function can now be reproduced via `map Data.String.singleton <<< toEnum`.
-- | In order to keep the string-related API surface area small, this function
-- | will probably be removed at some point.
-- |
-- | Return the character corresponding to the given Unicode code point and
-- | `Nothing` if the given number is outside the range 0 .. 0x10FFFF.
-- | This function uses `String` instead of `Char` because PureScript
-- | `Char`s must be UTF-16 code units and hence cannot represent all Unicode
-- | code points.
fromCodePoint
  :: Warn (Text "DEPRECATED: `Data.Char.Utils.fromCodePoint`")
  => Int -> Maybe String
fromCodePoint n = runFn3 fromCodePointImpl Just Nothing n

foreign import fromCodePointImpl
  :: Fn3 (∀ a. a -> Maybe a) (∀ a. Maybe a) Int (Maybe String)

-- | Return true if the given character (Unicode code point) is a high or low
-- | surrogate code point.
-- | This function uses `String` instead of `Char` because PureScript
-- | `Char`s must be UTF-16 code units and hence cannot represent all Unicode
-- | code points.
isSurrogate :: String -> Boolean
isSurrogate c = toCodePoint c .&. 0x1FF800 == 0xD800

-- | Return the Unicode code point of a character.
-- | This function uses `String` instead of `Char` because PureScript
-- | `Char`s must be UTF-16 code units and hence cannot represent all Unicode
-- | code points.
-- |
-- | Example:
-- | ```purescript
-- | toCodePoint '∀' == 8704
-- | ```
toCodePoint :: String -> Int
toCodePoint s = runFn1 toCodePointImpl s

foreign import toCodePointImpl :: Fn1 String Int

-- | Return the character corresponding to the given Unicode code point.
-- | **Unsafe:** Throws runtime exception if the given number is outside the
-- | range 0 .. 0x10FFFF.
-- | This function uses `String` instead of `Char` because PureScript
-- | `Char`s must be UTF-16 code units and hence cannot represent all Unicode
-- | code points.
unsafeFromCodePoint :: Int -> String
unsafeFromCodePoint n = runFn1 unsafeFromCodePointImpl n

foreign import unsafeFromCodePointImpl :: Fn1 Int String
