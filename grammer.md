## Grammar Rules

### Calculation
- `calculation` → `roman`

### Roman Numerals
- `roman` → `thousand` `hundred` `ten` `digit`

### Thousands
- `thousand` → `M` | `MM` | `MMM` | `ε`

### Hundreds
- `hundred` → `iHundred` | `C` `D` | `D` `iHundred` | `C` `M`

### Intermediate Hundreds
- `iHundred` → `C` | `CC` | `CCC` | `ε`

### Tens
- `ten` → `iTen` | `X` `L` | `L` `iTen` | `X` `C`

### Intermediate Tens
- `iTen` → `X` | `XX` | `XXX` | `ε`

### Digits
- `digit` → `iDigit` | `I` `V` | `V` `iDigit` | `I` `X`

### Intermediate Digits
- `iDigit` → `I` | `II` | `III` | `ε`