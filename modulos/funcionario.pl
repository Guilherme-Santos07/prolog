:- module(funcionario,[seleciona/5]).

seleciona(MatFunc, Nome, NumDepto, Sal�rio, MatGerente):-
 funcionario(MatFunc, Nome, NumDepto, Sal�rio, MatGerente),
 NumDepto = 2, Sal�rio > 2100.
