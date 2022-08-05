% Aluno: Bernardo Hipólito Mundim Porto.
% Matricula : 12111BSI219.
% Sistema de gestão de Estoque e Produção da Fabrica Brasileira de
% Aeronaves[2008].
% Páginas: 91,92,93.

:- module(
       funcionario,
       [funcionario/8]
   ).

:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_pessoa,[]).

:- persistent
   funcionario(fun_id : positive_integer,
          pes_id : positive_integer,
          fun_cargo : text,
          fun_cpf : text,
          fun_nro : text,
          fun_login : text,
          fun_senha : text,
          fun_matricula  :text).

:- initialization(db_attach('tbl_funcionario.pl',[])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(Fun_id,Pes_id,Fun_cargo,Fun_cpf,Fun_nro,Fun_login,Fun_senha,Fun_matricula):-
    chave:pk(funcionario,Fun_id),
    verifica_pessoa:verifica_pessoa(Pes_id),
    with_mutex(funcionario,assert_funcionario(Fun_id,Pes_id,Fun_cargo,Fun_cpf,Fun_nro,Fun_login,Fun_senha,Fun_matricula)).

remove(Fun_id):-
    with_mutex(funcionario,retract_funcionario(Fun_id,_Pes_id,_Fun_cargo,_Fun_cpf,_Fun_nro,_Fun_login,_Fun_senha,_Fun_matricula)).

atualiza(Fun_id,Pes_id,Fun_cargo,Fun_cpf,Fun_nro,Fun_login,Fun_senha,Fun_matricula):-
    with_mutex(funcionario,(retract_funcionario(Fun_id,_Pes_id,_Fun_cargo,_Fun_cpf,_Fun_nro,_Fun_login,_Fun_senha,_Fun_matricula),assert_funcionario(Fun_id,Pes_id,Fun_cargo,Fun_cpf,Fun_nro,Fun_login,Fun_senha,Fun_matricula)) ).


