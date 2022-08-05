s(Conta) --> as(Conta), bs(Conta), cs(Conta).
as(0) --> [].
as(NovoCnt) --> [a], as(Cnt), {NovoCnt is Cnt + 1}.
bs(0) --> [].
bs(NovoCnt) --> [b], bs(Cnt), {NovoCnt is Cnt + 1}.
cs(0) --> [].
cs(NovoCnt) --> [c], cs(Cnt), {NovoCnt is Cnt + 1}.

%comando que não é DCG usa-se chaves '{}'
