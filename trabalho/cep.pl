% Guilherme dos Santos Silva
% 12111BSI214
% Sistema de Atividades e Eventos [2012] Christo e Milliati
% Páginas 91, 92 e 93

:- use_module(library(persistency)).

:- persistent
    cep(
        cep_id: nonneg,
        cid_id: nonneg,
        bai_id: nonneg,
        log_id: nonneg).

:- initialization(db_attach('tbl_bairro.pl', [])).

sincroniza :- db_sync(gc(always)).
