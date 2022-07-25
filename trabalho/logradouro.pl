% Guilherme dos Santos Silva
% 12111BSI214
% Sistema de Atividades e Eventos [2012] Christo e Milliati
% P�ginas 91, 92 e 93

:- use_module(library(persistency)).

:- persistent
    logradouro(
        log_id: nonneg,
        log_nome: string,
        log_tipo: string).

:- initialization(db_attach('tbl_logradouro.pl', [])).

sincroniza :- db_sync(gc(always)).
