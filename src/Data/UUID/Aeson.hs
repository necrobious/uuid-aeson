module Data.UUID.Aeson where

import Control.Applicative (pure)

import Data.UUID (UUID, fromString)

import Data.Aeson (ToJSON,FromJSON, toJSON, parseJSON) 
import Data.Aeson.Types (Value(String), typeMismatch)

import qualified Data.Text as T

instance ToJSON UUID where
  toJSON = String . T.pack . show

instance FromJSON UUID where
  parseJSON json@(String t) = 
    let uuidString = T.unpack t
    in case fromString uuidString of
         Just uuid -> pure uuid 
         Nothing   -> typeMismatch "UUID" json 
  parseJSON unknown = typeMismatch "UUID" unknown
