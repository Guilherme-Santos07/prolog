% Guilherme dos Santos Silva
% 12111BSI214
% Sistema de Atividades e Eventos [2012] Christo e Milliati
% P�ginas 91, 92 e 93

:- use_module(library(persistency)).

:- persistent
    bairro(
        bai_id: nonneg,
        bai_nome: string).

:- initialization(db_attach('tbl_bairro.pl', [])).

sincroniza :- db_sync(gc(always)).

