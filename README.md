uuid-aeson
==========

Aeson types for UUID instances.

example
=======

Data.UUID.Aeson Data.UUID.V4 Data.Aeson Control.Monad> liftM (fromJSON .toJSON) nextRandom  :: IO (Result UUID)

Success 99644d7c-298c-44a9-b9bb-d0ca9940cc4e
