module Data.UUID.Aeson where

import Control.Applicative (pure)
import Data.UUID.Types (UUID, fromASCIIBytes, toASCIIBytes)
import Data.Aeson (ToJSON,FromJSON, toJSON, parseJSON) 
import Data.Aeson.Types (Value(String), typeMismatch)
import qualified Data.Text.Encoding as T
import qualified Data.Text as T

instance ToJSON UUID where toJSON = String . T.decodeUtf8 . toASCIIBytes

instance FromJSON UUID where
  parseJSON json@(String t) = 
    case fromASCIIBytes (T.encodeUtf8 t) of
      Just uuid -> pure uuid 
      Nothing   -> typeMismatch "UUID" json 
  parseJSON unknown = typeMismatch "UUID" unknown
