:- module(funcionario,[seleciona/5]).

seleciona(MatFunc, Nome, NumDepto, Salário, MatGerente):-
 funcionario(MatFunc, Nome, NumDepto, Salário, MatGerente),
 NumDepto = 2, Salário > 2100.
