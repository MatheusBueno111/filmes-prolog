% Definição dos filmes, ano e gênero
filme('Matrix', 1999, 'Ação').
filme('O Senhor dos Anéis', 2001, 'Fantasia').
filme('Interestelar', 2014, 'Ficção Científica').
filme('Cidade de Deus', 2002, 'Drama').
filme('Pantera Negra', 2018, 'Ação').
filme('A Origem', 2010, 'Ficção Científica').
filme('O Poderoso Chefão', 1972, 'Crime').
filme('Clube da Luta', 1999, 'Drama').
filme('O Labirinto do Fauno', 2006, 'Fantasia').
filme('Os Infiltrados', 2006, 'Crime').
filme('Vingadores: Ultimato', 2019, 'Ação').
filme('Harry Potter e a Pedra Filosofal', 2001, 'Fantasia').
filme('Gravidade', 2013, 'Ficção Científica').
filme('Pulp Fiction', 1994, 'Crime').
filme('O Rei Leão', 1994, 'Animação').
filme('Efeito Borboleta', 2004, 'Ficção Científica').
filme('Forrest Gump', 1994, 'Drama').
filme('Star Wars: Episódio IV - Uma Nova Esperança', 1977, 'Ficção Científica').
filme('O Silêncio dos Inocentes', 1991, 'Crime').
filme('Avatar', 2009, 'Aventura').

% Preferências dos usuários, gênero e classificação
preferencia(joao, 'Ação', 4).
preferencia(joao, 'Crime', 3).
preferencia(joao, 'Drama', 3).
preferencia(joao, 'Ficção Científica', 5).
preferencia(joao, 'Fantasia', 4).

preferencia(maria, 'Ação', 3).
preferencia(maria, 'Crime', 3).
preferencia(maria, 'Drama', 4).
preferencia(maria, 'Fantasia', 4).
preferencia(maria, 'Ficção Científica', 4).

preferencia(pedro, 'Ação', 5).
preferencia(pedro, 'Crime', 5).
preferencia(pedro, 'Drama', 4).
preferencia(pedro, 'Fantasia', 3).
preferencia(pedro, 'Ficção Científica', 4).

% Filmes assistidos por cada usuário
assistiu(joao, 'Matrix').
assistiu(joao, 'Interestelar').
assistiu(joao, 'Cidade de Deus').
assistiu(joao, 'O Poderoso Chefão').
assistiu(joao, 'Clube da Luta').

assistiu(maria, 'O Senhor dos Anéis').
assistiu(maria, 'O Poderoso Chefão').
assistiu(maria, 'Clube da Luta').
assistiu(maria, 'Harry Potter e a Pedra Filosofal').
assistiu(maria, 'Gravidade').

assistiu(pedro, 'Pantera Negra').
assistiu(pedro, 'A Origem').
assistiu(pedro, 'Os Infiltrados').
assistiu(pedro, 'Vingadores: Ultimato').
assistiu(pedro, 'Efeito Borboleta').

% Regra para recomendar filmes com base nos gêneros preferidos do usuário e avaliações
recomendar_filme_by_genero(Usuario, Filme) :-
    preferencia(Usuario, Genero, Classificacao),   % Encontra os gêneros preferidos e suas classificações do usuário
    filme(Filme, _, Genero),                      % Encontra filmes desse gênero
    \+ assistiu(Usuario, Filme),                  % Verifica se o usuário não assistiu a esse filme ainda
    avaliacao_media(Usuario, Genero, Media),      % Calcula a avaliação média do usuário para esse gênero
    Classificacao >= Media.                       % Verifica se a classificação do filme é maior ou igual à média do usuário para esse gênero

% Regra para calcular a avaliação média do usuário para um determinado gênero
avaliacao_media(Usuario, Genero, Media) :-
    findall(Classificacao, (preferencia(Usuario, Genero, Classificacao), assistiu(Usuario, _)), Classificacoes), % Encontra todas as classificações do usuário para esse gênero
    length(Classificacoes, N),                    % Obtém o número de classificações
    sumlist(Classificacoes, Soma),                % Soma todas as classificações
    (N > 0 -> Media is Soma / N ; Media is 0).   % Calcula a média (evita divisão por zero)

% Similaridade entre usuários com base nas preferências de gênero
similaridade_usuario(User1, User2, Similaridade) :-
    preferencia(User1, Genre, Rating1),       % Obtém a preferência de User1 para um gênero específico
    preferencia(User2, Genre, Rating2),       % Obtém a preferência de User2 para o mesmo gênero
    Similaridade is Rating1 * Rating2.        % Calcula a similaridade multiplicando as avaliações

% Similaridade total entre dois usuários
similaridade_total(_, [], 0).                % Caso base: quando não há mais usuários para comparar
similaridade_total(User, [OtherUser | Rest], TotalSimilarity) :-
    similaridade_total(User, Rest, SimilarityRest),          % Calcula a similaridade com outros usuários recursivamente
    similaridade_usuario(User, OtherUser, Similarity),       % Obtém a similaridade entre o usuário e outro usuário
    TotalSimilarity is Similarity + SimilarityRest.          % Calcula a similaridade total somando as similaridades

% Encontrar filmes assistidos por um usuário
filmes_assistidos(User, Watched) :-
    setof(Movie, assistiu(User, Movie), Watched).           % Obtém a lista de filmes assistidos por um usuário

% Encontrar filmes recomendados para um usuário
filmes_recomendados(User, Recommended) :-
    setof(Similarity-OtherUser, (preferencia(OtherUser, _, _), User \= OtherUser), SimilarUsers),  % Obtém outros usuários
    filmes_assistidos(User, Watched),                      % Obtém os filmes assistidos pelo usuário
    findall(Movie, (
        member(Similarity-OtherUser, SimilarUsers),        % Para cada usuário similar
        similaridade_total(User, [OtherUser], TotalSimilarity),  % Calcula a similaridade com o usuário similar
        assistiu(OtherUser, Movie),                       % Verifica os filmes assistidos pelo usuário similar
        not(member(Movie, Watched)),                      % Verifica se o filme não foi assistido pelo usuário atual
        TotalSimilarity > 15                              % Limita a recomendação para usuários com similaridade alta
    ), Recommended). 


% ? - filmes_recomendados(joao, Recomendacoes).
% Isso retornará uma lista de filmes recomendados para "joao", com base nas preferências dos usuários similares a ele.

% ?- recomendar_filme_by_genero(pedro, Filme).
% Isso retornará um filme recomendado para "pedro" com base em suas preferências e nas regras definidas no sistema.







