# 🎯 Projetos Haskell# 🎯 Projetos Haskell



Este repositório contém diversos projetos e estudos em Haskell.Este repositório contém diversos projetos e estudos em Haskell.



## 📋 Projetos Disponíveis## 📋 Projetos Disponíveis



### 🔧 projeto-json### 🔧 projeto-json

Uma biblioteca Haskell simples para manipulação e geração de JSON válido.Uma biblioteca Haskell simples para manipulação e geração de JSON válido.



#### Características:#### Características:

- ✅ **Geração de JSON válido** com escape correto de strings- ✅ **Geração de JSON válido** com escape correto de strings

- ✅ **Suporte completo** a todos os tipos JSON (string, number, boolean, null, array, object)- ✅ **Suporte completo** a todos os tipos JSON (string, number, boolean, null, array, object)

- ✅ **Escape automático** de caracteres especiais e de controle- ✅ **Escape automático** de caracteres especiais e de controle

- ✅ **Formatação correta** de arrays e objetos aninhados- ✅ **Formatação correta** de arrays e objetos aninhados

- ✅ **API simples** e type-safe- ✅ **API simples** e type-safe



## 📦 Como usar## 📦 Como usar



### Pré-requisitos### Pré-requisitos

- [Stack](https://docs.haskellstack.org/en/stable/README/) instalado- [Stack](https://docs.haskellstack.org/en/stable/README/) instalado

- GHC compatível (testado com GHC 9.10.3)- GHC compatível (testado com GHC 9.10.3)



### Instalação e execução### Instalação e execução



1. **Clone o repositório:**1. **Clone o repositório:**

```bash```bash

git clone https://github.com/thallyson1997/Haskell.gitgit clone https://github.com/thallyson1997/Haskell.git

cd Haskellcd Haskell

``````



2. **Para o projeto JSON:**2. **Para o projeto JSON:**

```bash```bash

cd projeto-jsoncd projeto-json

stack build

stack exec projeto-json-exe2. **Compile o projeto:**

``````bash

stack build

## 📋 Exemplo de Uso (projeto-json)```



```haskell3. **Execute os exemplos:**

import SimpleJSON```bash

stack exec projeto-json-exe

main :: IO ()```

main = do

  let usuario = JObject [## 🎯 Uso da Biblioteca

        ("nome", JString "Maria"),

        ("idade", JNumber 25),### Importando

        ("ativo", JBool True),```haskell

        ("tags", JArray [JString "premium", JString "verificado"])import SimpleJSON

      ]```

  

  putJValue usuario### Tipos de Dados

  -- Resultado: {"nome": "Maria", "idade": 25.0, "ativo": true, "tags": ["premium", "verificado"]}```haskell

```data JValue

  = JString String

### Funções Principais  | JNumber Double

- `renderJValue :: JValue -> String` - Converte para JSON válido  | JBool Bool

- `putJValue :: JValue -> IO ()` - Imprime JSON  | JNull

- `getString`, `getNumber`, `getBool` - Accessors seguros  | JObject [(String, JValue)]

  | JArray [JValue]

## 📁 Estrutura do Repositório```



```### Exemplos Básicos

Haskell/

├── projeto-json/          # Biblioteca JSON#### Criando valores JSON:

│   ├── src/SimpleJSON.hs```haskell

│   ├── app/Main.hs-- String

│   ├── package.yamllet nome = JString "João"

│   └── README.md         # Documentação detalhada

└── README.md             # Este arquivo-- Número

```let idade = JNumber 30



## 🤝 Contribuindo-- Boolean

let ativo = JBool True

1. Faça um fork do projeto

2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)-- Null

3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)let vazio = JNull

4. Push para a branch (`git push origin feature/nova-feature`)

5. Abra um Pull Request-- Array

let scores = JArray [JNumber 85, JNumber 92, JNumber 78]

## 👨‍💻 Autor

-- Objeto

**Thallyson** - [GitHub](https://github.com/thallyson1997)let pessoa = JObject [

  ("nome", JString "Maria"),

---  ("idade", JNumber 25),

  ("ativo", JBool True)

💡 **Dica**: Para documentação detalhada de cada projeto, acesse a pasta específica!]
```

#### Gerando JSON:
```haskell
-- Converter para string JSON
renderJValue pessoa
-- Resultado: {"nome": "Maria", "idade": 25.0, "ativo": true}

-- Imprimir JSON no console
putJValue pessoa
```

#### Exemplo Completo:
```haskell
import SimpleJSON

main :: IO ()
main = do
  let usuario = JObject [
        ("id", JNumber 123),
        ("nome", JString "Ana Silva"),
        ("email", JString "ana@exemplo.com"),
        ("configuracoes", JObject [
          ("tema", JString "escuro"),
          ("notificacoes", JBool True)
        ]),
        ("tags", JArray [JString "premium", JString "verificado"])
      ]
  
  putJValue usuario
```

### Funções Disponíveis

#### Geração de JSON:
- `renderJValue :: JValue -> String` - Converte JValue para string JSON válida
- `putJValue :: JValue -> IO ()` - Imprime JSON no console

#### Accessors seguros:
- `getString :: JValue -> Maybe String`
- `getNumber :: JValue -> Maybe Double`
- `getBool :: JValue -> Maybe Bool`
- `getObject :: JValue -> Maybe [(String, JValue)]`
- `getArray :: JValue -> Maybe [JValue]`
- `isNull :: JValue -> Bool`

#### Exemplo de uso dos accessors:
```haskell
let valor = JString "hello"
case getString valor of
  Just s  -> putStrLn s      -- Imprime: hello
  Nothing -> putStrLn "Não é string"
```

## 🔧 Características Técnicas

### Escape de Strings
A biblioteca escapa automaticamente:
- Aspas duplas: `"` → `\"`
- Barra invertida: `\` → `\\`
- Caracteres de controle: `\n`, `\t`, `\r`, `\b`, `\f`
- Caracteres de controle baixo (0-31): convertidos para `\uXXXX`

### Formatação
- **Arrays**: `[item1, item2, item3]`
- **Objetos**: `{"chave": valor, "chave2": valor2}`
- **Strings**: Sempre entre aspas duplas
- **Números**: Sem aspas, com decimais quando necessário
- **Booleanos**: `true` / `false` (minúsculo)
- **Null**: `null` (minúsculo)

## 🧪 Testando

Execute os testes incluídos:
```bash
stack exec projeto-json-exe
```

Para validar se o JSON gerado é válido, copie qualquer saída e teste em: [JSONLint.com](https://jsonlint.com/)

## 📝 Estrutura do Projeto

```
projeto-json/
├── src/
│   └── SimpleJSON.hs       # Biblioteca principal
├── app/
│   └── Main.hs            # Exemplos e testes
├── package.yaml           # Configuração do projeto
├── stack.yaml            # Configuração do Stack
└── README.md             # Este arquivo
```

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença BSD-3-Clause.

## 👨‍💻 Autor

**Thallyson** - [GitHub](https://github.com/thallyson1997)

---

💡 **Dica**: Este projeto é ideal para aprender manipulação de tipos algébricos e geração de JSON em Haskell!