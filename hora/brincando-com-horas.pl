data_hora(data(Dia,Mes,Ano),hora(Hora,Min),Resp):-
    date_time_value(date,date(Ano,Mes,Dia,Hora,Min,0,0,-,-),Resp).
