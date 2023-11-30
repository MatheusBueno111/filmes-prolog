# Sistema de Recomendação de Filmes

Este sistema de recomendação de filmes em Prolog usa preferências de usuários, filmes assistidos e similaridade entre usuários para oferecer recomendações personalizadas.

## Funcionalidades

### 1. Recomendações Baseadas em Gênero e Avaliações
- `recomendar_filme_by_genero`: Recomenda filmes para um usuário com base nas preferências de gênero e nas avaliações médias.

### 2. Recomendações Colaborativas
- `filmes_recomendados`: Oferece recomendações para um usuário com base nas preferências de usuários similares.

### 3. Informações de Usuário e Filmes
- `preferencia`: Define as preferências de um usuário para diferentes gêneros de filmes.
- `assistiu`: Registra os filmes assistidos por cada usuário.
- `filme`: Define informações sobre os filmes, incluindo título, ano e gênero.

### 4. Cálculo de Similaridade
- `similaridade_usuario`: Calcula a similaridade entre dois usuários com base nas preferências de gênero.
- `similaridade_total`: Calcula a similaridade total entre um usuário e outros usuários.

## Utilização

### Recomendação Baseada em Regras
Para recomendar filmes para um usuário com base nas regras definidas:
````prolog
recomendar_filme_by_genero(Usuario, Filme).
````


### Recomendação Colaborativa

Para obter recomendações com base em usuários similares:

```prolog
filmes_recomendados(Usuario, Recomendacoes).
```

## Observações

- A similaridade é calculada com base nas preferências de gênero e avaliações dos usuários.
- As recomendações são fornecidas com base nas preferências dos usuários similares ou nas regras de recomendação por gênero e avaliação.
