/*
classe1(Numero, positivo):- Numero > 0.
classe1(0, zero).
classe1(Numero, negativo):- Numero < 0.
O predicado acima � composto por dois par�metros e retorna "positivo"
caso o n�mero seja maior do que zero, "negativo" caso o n�mero seja
menor do que zero ou "zero" caso ele seja igual a zero.
*/

classe(0, zero):-!.
classe(Numero, positivo):- Numero > 0,!.
classe(Numero, negativo):- Numero < 0.
