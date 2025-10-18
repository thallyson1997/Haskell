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

import Data.List (intercalate)
import Data.Char (ord)

-- Tipo algébrico que representa valores JSON
data JValue
  = JString String
  | JNumber Double
  | JBool Bool
  | JNull
  | JObject [(String, JValue)]
  | JArray [JValue]
  deriving (Eq, Ord, Show)

-- Funções acessoras seguras (safe accessors)
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

-- Função pura: converte um JValue em JSON válido
renderJValue :: JValue -> String
renderJValue (JString s) = "\"" ++ escapeString s ++ "\""
renderJValue (JNumber n) = show n
renderJValue (JBool True)  = "true"
renderJValue (JBool False) = "false"
renderJValue JNull = "null"
renderJValue (JArray xs) =
  "[" ++ intercalate ", " (map renderJValue xs) ++ "]"
renderJValue (JObject kvs) =
  "{" ++ intercalate ", " (map renderPair kvs) ++ "}"
  where
    renderPair (k, v) =
      renderJValue (JString k) ++ ": " ++ renderJValue v

-- Função auxiliar (não exportar)
escapeString :: String -> String
escapeString = concatMap escapeChar
  where
    escapeChar '"'  = "\\\""
    escapeChar '\\' = "\\\\"
    escapeChar '\b' = "\\b"
    escapeChar '\f' = "\\f"
    escapeChar '\n' = "\\n"
    escapeChar '\r' = "\\r"
    escapeChar '\t' = "\\t"
    escapeChar c
      | ord c < 0x20 = "\\u" ++ padLeft 4 '0' (toHex (ord c))
      | otherwise    = [c]

    padLeft n ch s = replicate (n - length s) ch ++ s

    toHex :: Int -> String
    toHex n
      | n == 0    = "0"
      | otherwise = reverse (go n)
      where
        hexDigits = "0123456789abcdef"
        go 0 = ""
        go x = (hexDigits !! (x `mod` 16)) : go (x `div` 16)

-- Função impura: imprime um valor JSON no terminal
putJValue :: JValue -> IO ()
putJValue v = putStrLn (renderJValue v)
