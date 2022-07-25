% Guilherme dos Santos Silva
% 12111BSI214
% Sistema de Atividades e Eventos [2012] Christo e Milliati
% Páginas 91, 92 e 93

:- use_module(library(persistency)).

:- persistent
cidade(cid_id: nonneg,
      cid_nome: string,
      cid_uf: string,
      cid_ddd: nonneg).

:- initialization(db_attach('tbl_cidade.pl', [])).

sincroniza :- db_sync(gc(always)).
