module SimpleJSON
  (
  -- * Tipos de dados
    JValue(..)
  
  -- * Funções de acesso seguro (safe accessors)  
  , getString
  , getNumber
  , getBool
  , getObject
  , getArray
  , isNull
  
  -- * Geração de JSON
  , renderJValue    -- ^ Função pura: converte JValue para String JSON
  , putJValue       -- ^ Função impura: imprime JSON no console
  ) where

import Data.List (intercalate)
import Data.Char (ord)

-- | Tipo algébrico que representa todos os valores JSON possíveis
data JValue
  = JString String              -- ^ String JSON
  | JNumber Double              -- ^ Número JSON (sempre Double)
  | JBool Bool                  -- ^ Boolean JSON (true/false)
  | JNull                       -- ^ Valor null JSON
  | JObject [(String, JValue)]  -- ^ Objeto JSON (mapa chave-valor)
  | JArray [JValue]             -- ^ Array JSON (lista de valores)
  deriving (Eq, Ord, Show)

-- | Extrai String de JValue de forma segura
getString :: JValue -> Maybe String
getString (JString s) = Just s
getString _           = Nothing

-- | Extrai Double de JValue de forma segura
getNumber :: JValue -> Maybe Double
getNumber (JNumber n) = Just n
getNumber _           = Nothing

-- | Extrai Bool de JValue de forma segura
getBool :: JValue -> Maybe Bool
getBool (JBool b) = Just b
getBool _         = Nothing

-- | Extrai Object de JValue de forma segura
getObject :: JValue -> Maybe [(String, JValue)]
getObject (JObject o) = Just o
getObject _           = Nothing

-- | Extrai Array de JValue de forma segura
getArray :: JValue -> Maybe [JValue]
getArray (JArray a) = Just a
getArray _          = Nothing

-- | Verifica se JValue é null
isNull :: JValue -> Bool
isNull JNull = True
isNull _     = False

-- | Converte JValue para String JSON válida (função pura)
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

-- | FUNÇÃO AUXILIAR PRIVADA - NÃO EXPORTADA
-- Escapa caracteres especiais para JSON válido
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

-- | Imprime JValue como JSON no console (função impura)
putJValue :: JValue -> IO ()
putJValue v = putStrLn (renderJValue v)
