{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Data.UUID.Aeson () where

import Data.UUID.Types (UUID, toText, fromText)
import Data.Aeson (ToJSON (..), FromJSON (..), withText)
#if MIN_VERSION_aeson(1,0,0)
import Data.Aeson.Types (ToJSONKey(..), toJSONKeyText, FromJSONKey (..), FromJSONKeyFunction (..))
#endif

instance ToJSON UUID where
  toJSON = toJSON . toText

instance FromJSON UUID where
  parseJSON = withText "UUID" parser
    where
      parser t = case fromText t of
        Just uuid -> return uuid
        Nothing   -> fail "invalid UUID"

#if MIN_VERSION_aeson(1,0,0)
instance ToJSONKey UUID where
  toJSONKey = toJSONKeyText toText

instance FromJSONKey UUID where
  fromJSONKey = FromJSONKeyTextParser parser
    where
      parser t = case fromText t of
        Just uuid -> return uuid
        Nothing   -> fail "invalid UUID"
#endif
