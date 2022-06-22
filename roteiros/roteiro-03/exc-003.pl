tres_vezes([], []).
tres_vezes([H|T],[H,H,H|Lista]) :- tres_vezes(T,Lista).
