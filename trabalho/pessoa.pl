% Aluno: Bernardo Hip�lito Mundim Porto.
% Matricula : 12111BSI219.
% % Sistema de gest�o de Estoque e Produ�o da Fabrica Brasileira de
% Aeronaves[2008].
% P�ginas: 91,92,93.

:- module(
       pessoa,
       [pessoa/6]
   ).

:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_cep,[]).

:- persistent
   pessoa(pes_id : positive_integer,
          cep_id : positive_integer,
          pes_nome : text,
          pes_telefone : text,
          pes_email : text,
          pes_numero : text).

:- initialization(db_attach('tbl_pessoa.pl',[])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(Pes_id,Cep_id,Pes_nome,Pes_telefone,Pes_email,Pes_numero):-
    verifica_cep:verifica_cep(Cep_id),
    chave:pk(pessoa,Pes_id),
    with_mutex(pessoa,
               assert_pessoa(Pes_id,Cep_id,Pes_nome,Pes_telefone,Pes_email,Pes_numero)).

remove(Pes_id):-
    with_mutex(pessoa,
               retractall_pessoa(Pes_id,_Cep_id,_Pes_nome,_Pes_telefone,_Pes_email,_Pes_numero)).

atualiza(Pes_id,Cep_id,Pes_nome,Pes_telefone,Pes_email,Pes_numero):-
    verifica_cep:verifica_cep(Cep_id),
    with_mutex(pessoa,
              (retract_pessoa(Pes_id,_Cep_id,_Pes_nome,_Pes_telefone,_Pes_email,_Pes_numero),assert_pessoa(Pes_id,Cep_id,Pes_nome,Pes_telefone,Pes_email,Pes_numero)) ).

