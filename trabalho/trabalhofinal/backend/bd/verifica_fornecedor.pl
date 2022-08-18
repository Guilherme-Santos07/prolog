:- module(verifica_fornecedor,[verifica_fornecedor/1]).

:- use_module(fornecedor,[]).

verifica_fornecedor(Id):-
    fornecedor:fornecedor(Id,_,_,_,_,_,_,_,_,_).
