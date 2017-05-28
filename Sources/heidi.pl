% Exercice 1

% Définition des ordres

ordre(deponer).
ordre(dretg).
ordre(sanester).
ordre(davent).
ordre(davos).
ordre(plaun).
ordre(returnar).
ordre(safermar).

% Test de toutes les combinaisons d'ordres possibles:
% ordre(X).

% Définition des coups de sifflets

sifflet(court).
sifflet(whee).
sifflet(who).
sifflet(wheet).
sifflet(wheeo).
sifflet(hee).
sifflet(long).

% Test de toutes les combinaisons des coups de sifflets possibles:
% sifflet(X).

% Définition de la traduction d'un ordre

traduction(deponer, [court, court]).
traduction(dretg, [whee, who]).
traduction(sanester, [wheet, wheeo]).
traduction(davent, [wheet, wheeo, wheet, wheet]).
traduction(davos, [who, hee, who]).
traduction(plaun, [hee, hee, hee, hee]).
traduction(returnar, [whee, whee, wheet]).
traduction(safermar, [long]).

% Test de toutes les combinaisons de traductions possibles:
% traduction(X, Y).

% Définition de la pause

pause(pause).

% Traduction d'une séquence d'ordres
% Cas de base
sequence([], []).

% Fonction récursive
sequence([H | T], Y):-  traduction(H, H_traduit), % Traduction du premier élément
                        sequence(T, T_traduit), % Traduction du reste de la liste
                        T_temp = [Pause | T_traduit], % Ajout de la pause entre chaque ordre (une pause est ajoutée à la fin)
                        pause(Pause),
                        append(H_traduit, T_temp, Y). % On construit la liste des coups de sifflets

% Test de toutes les séquence à un ordre possibles:
% sequence([A], X).

/* Test de toutes les combinaisons de deux ordres */
/*
 sequence([A | [B | []]], X).
*/

/* Tests à true de plusieurs séquences */
/*
 sequence([deponer, safermar], [court, court, pause, long, pause]).
 sequence([dretg, davent, returnar], [whee, who, pause, wheet, wheeo, wheet, wheet, pause, whee, whee, wheet, pause]).
*/

/* Tests à false de plusieurs séquences */
/*
 sequence([davos, plaun], [court, court, pause, long, pause]).
 sequence([sanester, davent, returnar], [whee, who, pause, wheet, wheeo, wheet, wheet, pause, whee, whee, wheet, pause]).
*/

% Exercice 2

% Définition de la traduction d'un ordre optimisé

optimisation(deponer, [wheeo, hee, wheet]).
optimisation(dretg, [hee, wheet]).
optimisation(sanester, [wheet, wheeo]).
optimisation(davent, [wheet, hee, wheet]).
optimisation(davos, [wheet, wheeo, wheet]).
optimisation(plaun, [wheet, wheeo, wheeo]).
optimisation(returnar, [wheeo, wheet]).
optimisation(safermar, [wheeo, wheeo]).

% Test de toutes les combinaisons de traductions possibles:
% optimisation(X, Y).

% Traduction d'une séquence d'ordres optimisés
% Cas de base
sequence_optimise([], []).

% Fonction récursive
sequence_optimise([H | T], Y):- optimisation(H, H_traduit), % Traduction du premier élément
                                sequence_optimise(T, T_traduit), % Traduction du reste de la liste
                                T_temp = [Pause | T_traduit], % Ajout de la pause entre chaque ordre (une pause est ajoutée à la fin)
                                pause(Pause),
                                append(H_traduit, T_temp, Y). % On construit la liste des coups de sifflets

% Test de toutes les séquence à un ordre possibles:
% sequence_optimise([A], X).

/* Test de toutes les combinaisons de deux ordres */
/*
 sequence_optimise([A | [B | []]], X).
*/

/* Tests à true de plusieurs séquences */
/*
 sequence_optimise([deponer, safermar], [wheeo, hee, wheet, pause, wheeo, wheeo, pause]).
 sequence_optimise([dretg, davent, returnar], [hee, wheet, pause, wheet, hee, wheet, pause, wheeo, wheet, pause]).
*/

/* Tests à false de plusieurs séquences */
/*
 sequence_optimise([davos, plaun], [wheeo, hee, wheet, pause, wheeo, wheeo, pause]).
 sequence_optimise([sanester, davent, returnar], [hee, wheet, pause, wheet, hee, wheet, pause, wheeo, wheet, pause]).
*/

% Exercice 3

% Traduction d'une séquence d'ordres optimisés accélérée
% Cas de base
sequence_accelere([], []).

% Un élément
sequence_accelere(X, Y):- X =   [L],
                                optimisation(L, Y). % Traduction du premier élément

% Deux éléments ou plus
sequence_accelere([H | T], Y):- optimisation(H, H_traduit), % Traduction du premier élément
                                sequence_accelere(T, T_traduit), % Traduction du reste de la liste
                                append(H_traduit, T_traduit, Y). % On construit la liste des coups de sifflets.

% Traduction inversée
% Cas de base
traduction_inverse([], []).

% Ordre à deux coups de sifflets
traduction_inverse(X, Y):-  X = [A | B], % Récupération du premier élément
                            B = [C | D], % Récupération du deuxième élément
                            traduction_inverse(D, Reste), % Fonction récursive pour le reste
                            optimisation(Sol, [A, C]), % Ordre à deux coups de sifflets
                            Y = [Sol | Reste]. % On construit la liste des ordres

% Ordre à trois coups de sifflets
traduction_inverse(X, Y):-  X = [A | B], % Récupération du premier élément
                            B = [C | D], % Récupération du deuxième élément
                            D = [E | F], % Récupération du troisième élément
                            traduction_inverse(F, Reste), % Fonction récursive pour le reste
                            optimisation(Sol, [A, C, E]), % Ordre à trois coups de sifflets
                            Y = [Sol | Reste]. % On construit la liste des ordres

/* Traduction Heidi -> Tita */
/*
 sequence_accelere([plaun, dretg, plaun, deponer, safermar], X).
*/

/* Traduction Tita -> Heidi */
/*
 traduction_inverse([wheet, wheeo, wheeo, hee, wheet, wheet, wheeo, wheeo, wheeo, hee, wheet, wheeo, wheeo], X).
*/

/* Résultat */
/*
 sequence_accelere([plaun, dretg, plaun, deponer, safermar], [wheet, wheeo, wheeo, hee, wheet, wheet, wheeo, wheeo, wheeo, hee, wheet, wheeo, wheeo]).
 traduction_inverse([wheet, wheeo, wheeo, hee, wheet, wheet, wheeo, wheeo, wheeo, hee, wheet, wheeo, wheeo], [sanester, deponer, sanester, safermar, dretg, safermar]).
 traduction_inverse([wheet, wheeo, wheeo, hee, wheet, wheet, wheeo, wheeo, wheeo, hee, wheet, wheeo, wheeo], [sanester, deponer, plaun, deponer, safermar]).
 traduction_inverse([wheet, wheeo, wheeo, hee, wheet, wheet, wheeo, wheeo, wheeo, hee, wheet, wheeo, wheeo], [plaun, dretg, sanester, safermar, dretg, safermar]).
 traduction_inverse([wheet, wheeo, wheeo, hee, wheet, wheet, wheeo, wheeo, wheeo, hee, wheet, wheeo, wheeo], [plaun, dretg, plaun, deponer, safermar]). % Ordre initial
*/
