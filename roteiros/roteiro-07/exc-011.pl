%onze([a|A]-B):- onze(A-C),C = [b|B].
%onze([[]|T]-T).
onze --> [].
onze --> [a],onze,[b].
