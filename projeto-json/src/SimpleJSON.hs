-- src/SimpleJSON.hs
module SimpleJSON
  ( JValue(..)
  , getString
  , getNumber
  , getBool
  , getObject
  , getArray
  , isNull
  , renderJValue
  , putJValue
  ) where

-- Tipo algébrico que representa valores JSON
data JValue
  = JString String
  | JNumber Double
  | JBool Bool
  | JNull
  | JObject [(String, JValue)]
  | JArray [JValue]
  deriving (Eq, Ord, Show)

-- Funções acessoras (ainda sem corpo — vamos preencher depois)
getString :: JValue -> Maybe String
getString (JString s) = Just s
getString _           = Nothing

getNumber :: JValue -> Maybe Double
getNumber (JNumber n) = Just n
getNumber _           = Nothing

getBool :: JValue -> Maybe Bool
getBool (JBool b) = Just b
getBool _         = Nothing

getObject :: JValue -> Maybe [(String, JValue)]
getObject (JObject o) = Just o
getObject _           = Nothing

getArray :: JValue -> Maybe [JValue]
getArray (JArray a) = Just a
getArray _          = Nothing

isNull :: JValue -> Bool
isNull JNull = True
isNull _     = False

-- Serialização: converter para String (ainda simples)
renderJValue :: JValue -> String
renderJValue (JString s) = show s
renderJValue (JNumber n) = show n
renderJValue (JBool True)  = "true"
renderJValue (JBool False) = "false"
renderJValue JNull = "null"
renderJValue (JObject o) = "{" ++ show o ++ "}"
renderJValue (JArray a) = "[" ++ show a ++ "]"

-- Função impura (de IO)
putJValue :: JValue -> IO ()
putJValue v = putStrLn (renderJValue v)
