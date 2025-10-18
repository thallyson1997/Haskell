module Main where

import SimpleJSON

main :: IO ()
main = do
  putStrLn "=== TESTANDO renderJValue - GERAÇÃO DE JSON VÁLIDO ==="
  putStrLn "Verifique se cada saída é um JSON válido!\n"
  
  -- TESTE 1: Strings com escape
  putStrLn "TESTE 1: STRINGS COM ESCAPE"
  putStrLn "String simples:"
  putJValue (JString "hello world")
  
  putStrLn "\nString com aspas e barras:"
  putJValue (JString "texto com \"aspas\" e barra\\invertida")
  
  putStrLn "\nString com quebras de linha:"
  putJValue (JString "linha1\nlinha2\tcom_tab")
  
  -- TESTE 2: Caracteres de controle
  putStrLn "\nTESTE 2: CARACTERES DE CONTROLE"
  putStrLn "Caracteres de controle (devem virar \\uXXXX):"
  putJValue (JString "\x01\x02\x1F")
  
  -- TESTE 3: Números
  putStrLn "\nTESTE 3: NÚMEROS"
  putStrLn "Número positivo:"
  putJValue (JNumber 42)
  putStrLn "Número decimal:"
  putJValue (JNumber 3.14159)
  putStrLn "Número negativo:"
  putJValue (JNumber (-123.45))
  
  -- TESTE 4: Booleanos e null
  putStrLn "\nTESTE 4: BOOLEANOS E NULL"
  putJValue (JBool True)
  putJValue (JBool False)
  putJValue JNull
  
  -- TESTE 5: Arrays
  putStrLn "\nTESTE 5: ARRAYS"
  putStrLn "Array vazio:"
  putJValue (JArray [])
  putStrLn "Array com tipos mistos:"
  putJValue (JArray [JString "texto", JNumber 123, JBool True, JNull])
  
  -- TESTE 6: Objetos
  putStrLn "\nTESTE 6: OBJETOS"
  putStrLn "Objeto vazio:"
  putJValue (JObject [])
  putStrLn "Objeto simples:"
  putJValue (JObject [("nome", JString "João"), ("idade", JNumber 30)])
  
  -- TESTE 7: Estrutura complexa
  putStrLn "\nTESTE 7: JSON COMPLEXO"
  let usuario = JObject [("nome", JString "Maria"), ("ativo", JBool True)]
  let pontuacoes = JArray [JNumber 95.5, JNumber 87.2]
  let complexo = JObject [("usuario", usuario), ("pontuacoes", pontuacoes)]
  putJValue complexo
  
  putStrLn "\nTODOS OS TESTES CONCLUÍDOS!"