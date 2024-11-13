# Features a serem desenvolvidas no projeto

Epic 1: Onboarding e Tutorial do App

- User Story 1.1: Tutorial para novos usuários
  - “Como novo usuário, quero ser guiado por um tutorial para entender as principais funcionalidades do app, para usá-lo de maneira eficiente.”

- User Story 1.2: Opção de pular o tutorial
  - “Como usuário, quero a opção de pular o tutorial caso já conheça o app, para economizar tempo.”

Epic 2: Treinos

- User Story 2.1: Visualizar treinos em progresso
  - "Como usuário, quero visualizar meus treinos em progresso, para acompanhar meu desenvolvimento."
 
- User Story 2.2: Procurar novos treinos
  - "Como usuário, quero poder procurar novos treinos para diversificar minha rotina de exercícios."
 
- User Story 2.3: Acessar vídeos dos treinos
  - “Como usuário, quero acessar vídeos dos treinos a partir da página de treinos, para realizar os exercícios corretamente.”
 
Epic 3: Perfil e Configurações

- User Story 3.1: Editar perfil
  - "Como usuário, quero editar minha foto, email, nome e senha para manter minhas informações pessoais atualizadas."

- User Story 3.2: Visualizar calendário de treino e descanso
  - "Como usuário, quero visualizar um calendário com meus dias de treino e descanso, para planejar minha rotina de exercícios."

- User Story 3.3: Receber lembretes para a hora do treino
  - "Como usuário, quero receber lembretes para a hora do treino, para não perder minha rotina."

- User Story 3.4: Links para avaliação do app e redes sociais
  - "Como usuário, quero acessar links para avaliar o app e seguir suas redes sociais, para apoiar e interagir com a comunidade do app."

- User Story 3.5: Logout
  - "Como usuário, quero poder sair da minha conta, para garantir a privacidade dos meus dados."

User Story 3.6: Termos e condições
  - "Como usuário, quero poder ler os termos e condições do app, para entender melhor meus direitos e responsabilidades."


# Registro da execução da técnica de elicitação de requisitos
## Técnica escolhida: BENCHMARKING

### [Selfit Fitness App](https://play.google.com/store/apps/details?id=com.yazio.android&hl=en&pli=1)

![Selfit Fitness App](images/selfit/apresentacao.png)

Este é um projeto open-source em Flutter que inclui vídeos e tutoriais sobre a aplicação, com foco em treinos rápidos e práticos.

#### Documentação de Features e Funcionalidades
Nesta etapa, analisamos o design e as funcionalidades gerais do produto, destacando suas principais ideias.

As features mais interessantes são:

- Onboarding 

![Onboarding](images/selfit/onboarding.png)

A introdução do aplicativo, que orienta o usuário na primeira utilização, explica os principais benefícios e funcionalidades do app.

- Tela principal

![Tela Principal](images/selfit/home_screen.png)

A tela inicial possui um design claro e funcional, que inclui um hub de motivação. Nela, o usuário encontra dados sobre treinos completados, em andamento e o tempo total exercitado. Além disso, há uma lista de novos treinos sugeridos.

- Workouts

![Workouts](images/selfit/workouts.png)

Esta é a funcionalidade principal do aplicativo, onde o usuário pode visualizar treinos concluídos e em andamento, bem como explorar novos treinos. Cada exercício conta com vídeos explicativos para orientar o usuário.

- Perfil e Configurações
  
![Perfil e Configurações](images/selfit/settings_profile.png)

Uma função básica que permite ao usuário atualizar informações de perfil, como foto e nome.

- Reminder

Uma função de lembrete que envia notificações no horário selecionado pelo usuário para lembrar dos treinos.

#### Pontos positivos e negativos

- Positivos
  - Projeto open-source que serve como base sólida para o desenvolvimento do nosso app.
  - Design claro e objetivo.
  - Onboarding eficaz para introduzir o app ao usuário.
  - Função de lembrete para organização e motivação do usuário.
  - Treinos rápidos e objetivos.
  - Vídeos explicativos para todos os exercícios.
  
- Negativos
  - Não foi possível executar a aplicação, então a análise ficou restrita ao design.
  
Em resumo, o projeto é uma base valiosa para nosso app, que será personalizado e expandido com novas funcionalidades.

 
### [Yazio App](https://www.yazio.com/pt)

<img src="images/yazio/home_page.jpeg" alt="Página principal" width="250" height="auto">

Aplicativo de acompanhamento nutricional

#### Documentação de Features e Funcionalidades
- Anamnese nutricional

  <img src="images/yazio/anamnese.jpeg" alt="Anamnese" width="250" height="auto">
  <img src="images/yazio/anamnese2.jpeg" alt="Anamnese" width="250" height="auto">

  Um formulário para coletar dados sobre o usuário, que permite ao aplicativo sugerir a quantidade ideal de calorias e macronutrientes para o perfil de cada pessoa.

- Contador de macros e calorias

  <img src="images/yazio/meals.jpeg" alt="Meals" width="250" height="auto">
  <img src="images/yazio/calories_tracker.jpeg" alt="Tracker calories" width="250" height="auto">

  O usuário pode registrar alimentos e refeições nas categorias de café da manhã, almoço, jantar e lanches. O app calcula e exibe os macros e calorias tanto de cada refeição quanto do total diário.

- Review das refeições

  <img src="images/yazio/review.jpeg" alt="Review" width="250" height="auto">

  Sempre que o usuário insere uma refeição, o app destaca as principais características nutricionais dos alimentos, como ser alto em calorias, gordura, ou baixo em calorias, entre outros.

- Sistema de Streaks

  O aplicativo incentiva o usuário a registrar suas refeições diariamente por meio de um sistema de streaks, motivando a constância.

- Reaproveitamento de alimentos e refeições

  <img src="images/yazio/add_foods.jpeg" alt="food and meals" width="250" height="auto">
  <img src="images/yazio/add_meals.jpeg" alt="food and meals" width="250" height="auto">

  O usuário pode duplicar uma refeição para outros dias, sem precisar adicionar alimentos individualmente novamente. Além disso, alimentos recentemente usados ficam acessíveis em um menu rápido para seleção.

- Integração com apps de tracking de atividade física

  <img src="images/yazio/integration_measurements.jpeg" alt="Sports tracker" width="250" height="auto">

  Com a integração, o app mostra as calorias gastas em atividades físicas e ajusta a meta diária de calorias a serem consumidas.

- Tracker de medidas e ingestão de água
  
  <img src="images/yazio/water_measurements.jpeg" alt="Water and measurements tracker" width="250" height="auto">

  O aplicativo permite registrar medidas e peso corporal (Olhar na imagem anterior) e inclui um tracker para ingestão de água, com notificações para lembrar o usuário de se hidratar ao longo do dia.

#### Pontos positivos e negativos

- Positivos
  - Recomendações personalizadas e ajustadas via anamnese.
  - Gamificação que estimula o usuário a manter a consistência.
  - Metas e objetivos adaptáveis às necessidades do usuário.
  - Facilidade de inserir refeições e alimentos ao plano alimentar.
  - Avaliação detalhada das refeições registradas.

- Negativos
  - Excesso de propagandas.
  - Perguntas redundantes na anamnese.
  - Muitas funcionalidades agrupadas na página principal, o que pode confundir novos usuários.
  - Processo trabalhoso para adicionar uma refeição/alimento pela primeira vez.
  

### [Samsung Health](https://www.samsung.com/br/apps/samsung-health/)



Aplicativo para acompanhamento de atividades físicas e hábitos diários

#### Documentação de Features e Funcionalidades

- Progresso do usuário
  
  <img src="images/samsung_health/home1.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/samsung_health/home2.jpeg" alt="Página principal" width="250" height="auto">

  O usuário pode disponibilizar suas informações, tais como peso, horas de sono e alimentos ingeridos, para acompanhar seu progresso e bem-estar. 
  Também é disponibilizado o seu progresso em calorias perdidas, passos dados, horas de sono e tempo gasto em atividades.
  

- Foco e exercícios favoritos
  
  <img src="images/samsung_health/focus.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/samsung_health/my_exercises.jpeg" alt="Página principal" width="250" height="auto">

  Usuário pode escolher qual seu foco principal com o uso do aplicativo (Exercícios, Sono, Peso ou Saúde em geral). Além disso, pode favoritar os tipos de exercício de maior interesse.


- Perfil do usuário
  
  <img src="images/samsung_health/profile.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/samsung_health/profile2.jpeg" alt="Página principal" width="250" height="auto">

  Perfil apresenta um sístema de níveis e títulos de progresso. Usuário pode acompanhar seu reseumo semanal, badges conquistadas e desafios dos quais faz parte.

  Há também um QR code disponível para compartilhamento do perfil, além das amizades já feitas.
  

- "Fitness" - Exercícios e atividades disponíveis

  <img src="images/samsung_health/fitness.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/samsung_health/fitness2.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/samsung_health/filters.jpeg" alt="Página principal" width="250" height="auto">

  Representa um conjunto de programas disponíveis ao usuário, compostos por vídeos e rotinas.
  Para cada conteúdo, separados por categoria, há um nível de dificuldade, e o app calcula o tempo de duração.
  O usuário pode adicionar o programa ao seu perfil, onde ficam registrados os exercícios completos, incompletos e perdidos.
  
  Há um sistema de filtros, divididos em categoria, dificuldade, duração, parte do corpo e necessidade de equipamentos.
  
  
- "Together" - Rankings e desafios
  
   <img src="images/samsung_health/together.jpeg" alt="Página principal" width="250" height="auto">
   <img src="images/samsung_health/challenge.jpeg" alt="Página principal" width="250" height="auto">

   Permite compartilhar exercícios e desafios com amigos e outras pessoas. Há um sistema de rankings por desafio e um sistema de visualização de progresso.

#### Pontos positivos e negativos

- Positivos
  - Na aba Fitness, há uma variedade muito grande de programas, contendo rotinas de corrida, ciclismo, dança e até exercícios de respiração.
  - Ainda na aba Fitness, há conteúdos que são disponibilizados por outros serviços, e não pelo próprio app. Isso possibilita um maior número de abordagens e métodos para exercícios.
  - O sistema de rotinas permite que o usuário se organize de acordo com suas agendas e programas.
  - A determinação de metas e o sistema de níveis estimulam o usuário a continuar se exercitando.
  - Os desafios de bater as próprias marcas pessoais estimulam o usuário a ultrapassar seus limites.
  - Ao possibilitar que o usuário escolha o seu foco, permite-se um desenvolvimento mais eficiente.
  - Visualização de progresso possibilita um melhor acompanhamento do usuário e permite que ele avalie o que pode ser melhorado.
  


- Negativos
  - O sistema de níveis é bem interessante,  mas as recompensas por avançar de nível não são muito claras.
  - Seria útil se fosse possível pesquisar o perfil de outros usuários.
  - Apesar de ter um ótimo sistema de filtros, não é possível pesquisar programas e atividade por nome na aba "Fitness".

  
### [STRAVA](https://www.strava.com/?hl=pt-BR)

Aplicativo de registro e acompanhamento de exercícios físicos.

### Documentação de Features e Funcionalidades

- Acompanhamento do progresso nas atividades

  <img src="images/strava/progresso.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/strava/progresso2.jpeg" alt="Página principal" width="250" height="auto">

  Permite ao usuário acompanhar o número de atividades, dias, quilômetros, ou outras medidas de exercícios físicos realizados ao longo de um certo período de tempo, e em comparação com períodos anteriores.


- Interação com outros usuários
  
  <img src="images/strava/atividade_conhecido.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/strava/perfil_conhecido.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/strava/interacao.jpeg" alt="Página principal" width="250" height="auto">

  As atividades das pessoas seguidas por um usuário são exibidas na tela inicial, e é possível acessar os perfis para acompanhar também seu progresso. Ademais, o aplicativo permite interações básicas com essas atividades, como a realização de comentários, e "dar kudos", a versão do aplicativo de um "like".


- Medalhas e "Stickers" de incentivo
  
  <img src="images/strava/medalhas.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/strava/progresso_medalhas.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/strava/trofeus.jpeg" alt="Página principal" width="250" height="auto">

  Ao realizar uma atividade, é possível receber medalhas, de ouro, prata, ou bronze, com base em como ela se compara às suas atividades realizadas anteriormente. É possível participar, também, de desafios específicos, para cumprir certas metas, sendo recompensado com "Stickers" no aplicativo.


- Grupos de pessoas que praticam atividades

  <img src="images/strava/grupos.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/strava/grupos2.jpeg" alt="Página principal" width="250" height="auto">

  O aplicativo permite a participação de grupos de realização de atividades, nos quais pode-se registrar os exercícios realizados em conjunto, além de acompanhar estatísticas do grupo, postar fotos, e interagir com os outros membros.


- Integração com outros aplicativos

  <img src="images/strava/spotify.jpeg" alt="Página principal" width="250" height="auto">
  <img src="images/strava/spotify2.jpeg" alt="Página principal" width="250" height="auto">

  É possível integrar outros aplicativos ao Strava, permitindo escutar músicas, migrar seus dados de outros aplicativos utilizados anteriormente, e postar suas atividades nas redes sociais.


#### Pontos positivos e negativos

- Positivos
  - Fácil de iniciar a realização de uma atividade, diminuindo possíveis distrações e “desculpas”.
  - O acompanhamento do progresso, em conjunto com as medalhas, são uma fonte de motivação efetiva.
  - O “kudos” e os comentários servem como uma maneira simples e divertida de interagir, incentivando o uso frequente do aplicativo, e, consequentemente, a prática frequente de atividades físicas.


- Negativos
  - Certas funções de acompanhamento de progresso estão barradas por uma inscrição paga.
  - Apesar de ser um aplicativo para atividades físicas em geral, há bem mais funções para corrida e pedalada se comparado a outras atividades.
  - Navegação confusa entre a aba “Você” e o perfil do usuário, nem sempre fica claro o que está onde.
  - O sistema de “Stickers” é rígido, não permitindo a definição de metas pessoais, e desafios menores ou maiores do que os já estabelecidos pelo aplicativo.



## Técnica escolhida: Entrevista com uso de cenários

A técnica escolhida para a coleta de dados foi entrevistar possíveis usuários com o uso de um cenário para guiar a entrevista. A motivação por trás do uso de um cenário foi a possibilidade de tornar a entrevista mais focada, já que, com ele, é possível centralizar a discussão em torno de funcionalidades de um aplicativo, em vez de assuntos mais gerais quanto à prática de atividade física.

Com isso em mente, as entrevistas foram feitas pessoalmente, um a um, com conhecidos dos membros do grupo. Nelas, o membro fez o papel de entrevistador, seguindo um roteiro de perguntas previamente preparado e registrando as respostas dadas por escrito ou por áudio. 

Cada entrevista foi separada em 2 fases. Na primeira, foram feitas perguntas para definir o tipo de usuário sendo entrevistado quanto a dois critérios: sua experiência em praticar atividade física, e sua experiência em a usar apps de acompanhamento para atividade física. As perguntas foram as seguintes:

- Perguntas da 1° fase:
  - Com que frequência você pratica atividade física?
  - Já utilizou algum aplicativo para monitorar sua atividade física?
  - Como você classificaria seu nível de experiência com atividade física (iniciante, intermediário ou avançado)?
  - Você se sente confortável em usar aplicativos para monitorar sua atividade física?

Com a primeira fase da entrevista concluída, o entrevistador então, classifica o entrevistado em 1 de 4 tipos. De acordo com o tipo, é apresentado um determinado cenário e, a partir dele, são feitas perguntas referentes ao funcionamento do aplicativo no cenário apresentado. Os tipos de usuário, junto de seus respectivos cenários e perguntas, foram os seguintes:


- Tipo 1: Usuário Experiente em Atividades Físicas e Experiente com Apps de Atividade Física
  - Classificação dada a um usuário que pratica atividade física regurlarmente com o acompanhamento de um aplicativo.

  - Cenário:
    - O usuário completa uma corrida de 10 km e quer registrar a atividade, visualizar estatísticas e compará-las com corridas anteriores.

  - Perguntas:
    - Quais métricas são mais importantes para você ao registrar uma corrida? (tempo, distância, frequência cardíaca, etc.)
    - Que tipo de relatórios ou análises você gostaria de visualizar após suas atividades?
    - Você prefere uma interface minimalista ou com informações detalhadas?


- Tipo 2: Usuário Experiente em Atividades Físicas e Inexperiente com Apps de Atividade Física
  - Classificação dada a um usuário que pratica atividade física regularmente, mas sem usar algum aplicativo.

  - Cenário:
    - O usuário usa o app pela primeira vez para registrar uma sessão de musculação e busca tutoriais ou orientações.

  - Perguntas:
    - O que você considera mais desafiador ao usar um novo app de fitness?
    - Que tipo de suporte ou orientação você gostaria ao usar o app pela primeira vez?
    - Você se sentiria motivado com feedback do app sobre suas atividades?


- Tipo 3: Usuário Inexperiente em Atividades Físicas e Experiente com Apps de Atividade Física
  - Classificação dada um usuário que, mesmo sem praticar atividade física regularmente, tem conhecimento profundo de aplicativos de atividade física.
  
  - Cenário:
    -O usuário quer iniciar um programa de exercícios e procura opções que se ajustem à sua rotina, utilizando o app para acompanhar seu progresso.

  - Perguntas:
    - Quais atividades você tem interesse em experimentar? (ex: yoga, corrida, musculação)
    - O app deve sugerir atividades com base no seu nível de condicionamento físico?
    - Como você gostaria de acompanhar seu progresso? (gráficos, relatórios, etc.)


- Tipo 4: Usuário Inexperiente em Atividades Físicas e Inexperiente com Apps de Atividade Física
  - Classificação dada a um usuário que não pratica atividade física regularmente e não tem conhecimento profundo de aplicativos de atividade física.

  - Cenário:
    - O usuário quer se inscrever em um programa de caminhada e precisa de um guia passo a passo para começar a usar o app.

  - Perguntas:
    - Quais funcionalidades você considera essenciais para iniciantes? (ex: vídeos explicativos, dicas de segurança)
    - Gostaria de receber lembretes para se manter ativo?
    - Como você imagina a interface ideal, considerando sua falta de experiência?

Ao término do processo, todo o material recolhido das entrevistas foi colocado em um Drive compartilhado do grupo, para então ser analisado pela equipe.

As entrevistas transcritas em arquivos .md podem ser encontradas na pasta Requirements -> Entrevistas.

### Pontos de atenção encontrados

A partir das entrevistas, foram separadas as funções sugeridas, direta ou indiretamente, pelos entrevistados, de acordo com o que foi por eles considerado essencial para um aplicativo de acompanhamento de atividade física. Essa seleção foi feita manualmente pelos membros do grupo, a partir das gravações ou transcrições feitas.

No processo sugestões referentes a funções iguais ou parecidas foram unificadas em ideias menos específicas, as quais, posteriormente, foram classificadas quanto à sua popularidade (isto é, o quanto foram citadas pelos entrevistados) e quanto à sua dificuldade de desenvolvimento (definida por discussões entre os membros).

Dessa forma, foi definida uma lista de prioridades que destacou as funções mais essenciais (enquanto ainda viáveis) para um aplicativo de acompanhamento de atividade física. Estas foram as seguintes:

- Funções propostas escolhidas:
  - Videos de explicação e tutoriais (sobre musculação, nutrição e corrida). Com uma pesquisa mais fácil e direta.
  - Treinos (uma página que o usuário pode ver os treinos em progresso ou procurar novos treinos). A partir daí podem navegar para a página de videos dos treinos.  
  - Calendário contendo os dias de treino e descanso.
  - Reminder para a hora do treino.
  - Registros de melhores marcas pessoais.
  - Sistema de níveis.
  - Ranking entre amigos.

Além disso, foram separadas algumas funções gerais essenciais para o funcionamento de qualquer aplicativo. Estas foram:

- Funções essenciais:
  - Login e cadastro.
  - Perfil e configurações.
  - Editar perfil (foto, email, nome, senha).
  - Sign Out.
  - Termos e condições do app.

Então, para cada função foram atribuídos Story Points depois de uma discussão em grupo, e cada membro ficou encarregado de desenvolver determinadas funções.