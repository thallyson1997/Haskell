# GUIA DE TESTES - renderJValue

## 🎯 OBJETIVO
Testar se a função `renderJValue` gera JSON válido com escape correto e formatação adequada.

## 📝 INSTRUÇÕES PARA EXECUÇÃO

### 1. Execute o programa principal:
```powershell
cd C:\Users\thall\projetos\Haskell\projeto-json
stack exec projeto-json-exe
```

### 2. Analise cada saída e verifique:

## ✅ O QUE VOCÊ DEVE VER:

### TESTE 1: STRINGS COM ESCAPE
- `"hello world"` → String simples com aspas
- `"texto com \"aspas\" e barra\\invertida"` → Aspas escapadas com \" e barra com \\
- `"linha1\nlinha2\tcom_tab"` → \n para quebra de linha, \t para tab

### TESTE 2: CARACTERES DE CONTROLE  
- `"\u0001\u0002\u001f"` → Caracteres de controle convertidos para \uXXXX

### TESTE 3: NÚMEROS
- `42.0` → Número inteiro (pode aparecer com .0)
- `3.14159` → Número decimal
- `-123.45` → Número negativo

### TESTE 4: BOOLEANOS E NULL
- `true` → Boolean verdadeiro (minúsculo)
- `false` → Boolean falso (minúsculo)  
- `null` → Valor nulo (minúsculo)

### TESTE 5: ARRAYS
- `[]` → Array vazio
- `["texto", 123.0, true, null]` → Array com tipos mistos, separados por vírgula

### TESTE 6: OBJETOS
- `{}` → Objeto vazio
- `{"nome": "João", "idade": 30.0}` → Objeto com propriedades, chaves entre aspas

### TESTE 7: JSON COMPLEXO
- Estrutura aninhada com objetos dentro de objetos e arrays

## 🚨 O QUE VERIFICAR:

### ✅ ASPECTOS VÁLIDOS:
1. **Strings sempre entre aspas duplas**: `"texto"`
2. **Escape correto**: `\"` para aspas, `\\` para barras
3. **Caracteres de controle**: `\uXXXX` para códigos < 32
4. **Arrays**: `[elemento1, elemento2]` com vírgulas
5. **Objetos**: `{"chave": valor}` com dois pontos
6. **Booleanos**: `true`/`false` (minúsculo)
7. **Null**: `null` (minúsculo)
8. **Números**: sem aspas, podem ter decimais

### ❌ PROBLEMAS A DETECTAR:
- Aspas simples ao invés de duplas
- Caracteres não escapados (aspas, barras)
- Boolean/null com maiúsculas
- Objetos/arrays mal formatados
- Caracteres de controle não convertidos

## 🔍 VALIDAÇÃO ONLINE:
Copie qualquer saída JSON e cole em: https://jsonlint.com/
- Se válido: ✅ "Valid JSON"
- Se inválido: ❌ Mostrará o erro

## 🎓 EXEMPLO DE VALIDAÇÃO:
Se você ver esta saída:
```json
{"usuario": {"nome": "Maria", "ativo": true}, "pontuacoes": [95.5, 87.2]}
```

Cole no JSONLint.com e deve aparecer "Valid JSON" formatado assim:
```json
{
  "usuario": {
    "nome": "Maria",
    "ativo": true
  },
  "pontuacoes": [
    95.5,
    87.2
  ]
}
```

## ✅ RESULTADO ESPERADO:
Todas as saídas devem ser JSON válido, confirmando que `renderJValue` funciona corretamente!