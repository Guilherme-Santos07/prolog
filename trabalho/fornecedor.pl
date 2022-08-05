% Aluno: Bernardo Hipólito Mundim Porto.
% Matricula : 12111BSI219.
% % Sistema de gestão de Estoque e Produção da Fabrica Brasileira de
% Aeronaves[2008].
% Páginas: 91,92,93.

:- module(
       fornecedor,
       [fornecedor/10]
   ).
:- use_module(library(persistency)).
:- use_module(chave,[]).
:- use_module(verifica_pessoa,[]).

:- persistent
   fornecedor(for_id : positive_integer,
             pes_id : positive_integer,
             for_cnpj : text,
             for_inscricao : nonneg,
             for_nome_contato : text,
             for_email_contato : text,
             for_situacao : text,
             for_telefone_contato : text,
             for_status : text,
             for_categoria : text).

:- initialization(db_attach('tbl_fornecedor.pl',[])).
:- initialization(at_halt(db_sync(gc(always)))).

insere(For_id,Pes_id,For_cnpj,For_inscricao,For_nome_contato,For_email_contato,For_situacao,For_telefone_contato,For_status,For_categoria):-
    chave:pk(fornecedor,For_id),
    verifica_pessoa:verifica_pessoa(Pes_id),
    with_mutex(fornecedor,assert_fornecedor(For_id,Pes_id,For_cnpj,For_inscricao,For_nome_contato,For_email_contato,For_situacao,For_telefone_contato,For_status,For_categoria)).

remove(For_id):-
    with_mutex(fornecedor,retract_fornecedor(For_id,_Pes_id,_For_cnpj,_For_inscricao,_For_nome_contato,_For_email_contato,_For_situacao,_For_telefone_contato,_For_status,_For_categoria)).

atualiza(For_id,Pes_id,For_cnpj,For_inscricao,For_nome_contato,For_email_contato,For_situacao,For_telefone_contato,For_status,For_categoria):-
    with_mutex(fornecedor,(retract_fornecedor(For_id,_Pes_id,_For_cnpj,_For_inscricao,_For_nome_contato,_For_email_contato,_For_situacao,_For_telefone_contato,_For_status,_For_categoria),assert_fornecedor(For_id,Pes_id,For_cnpj,For_inscricao,For_nome_contato,For_email_contato,For_situacao,For_telefone_contato,For_status,For_categoria)) ).
