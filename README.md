# romanNumeralConverter

## Future additions
- Add a front end hosted on github pages
- host the backend as a Lambda function with a API gateway.

## Description of Files Included
- `expr.c`: Contains the implementation of ast for and evaluating it.
- `expr.h`: Header file for `expr.c`.
- `grammer.md`: Documentation file describing the grammar rules used in the parser.
- `lexer.l`: Lex file defining the symbols to accept.
- `makefile`: Build script for compiling the project.
- `parser.y`: Yacc file defining the parsing rules,and building ast as well as main function.
- `README.md`: This file !

## Compile and Run Instructions

### Compile
To compile the project, navigate to the project directory and run:
```sh
make
```
This will generate an executable named `roman`.

### Run
To run the program, use the following command:
```sh
./roman <ROMAN_NUMERAL>
```
***Example:***
```sh
./roman MMXXIII
```
This will output the integer value of the Roman numeral `MMXXIII`.