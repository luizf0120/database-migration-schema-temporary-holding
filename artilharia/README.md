# Canhão de brinquedo v9: carro colado no centro da mesa, escala na mesa, projéteis em 2 cores, coroas e bochechas vazadas, base enxuta, pontaria 120:1 (3° por volta) e só 2 itens para comprar

![montagem](montagem.png)

Arquivo único: [`artilharia.scad`](artilharia.scad), 100% paramétrico, ASCII puro e sem bibliotecas externas.
Os STLs prontos de todas as peças estão em [`stl/`](stl/), e tudo junto em `canhao_completo.zip`.

**Para comprar, só 2 itens:**
- **~52 BBs de airsoft de 6 mm**: são as esferas do rolamento da mesa.
- **1 mola de compressão 1,0 × 12 × 100 mm**.

Todo o resto é impresso: rolamento, baionetas, pinos, eixos e travas. Não há nenhum parafuso nem rosca em plástico para espanar.

## Pontaria

| Eixo | Acionamento | Redução | 1 volta da manivela | Números do tambor | 1 marca do tambor |
|---|---|---|---|---|---|
| **Azimute** | rosca sem fim → mesa = setor de coroa (passo de 120 dentes), módulo 1,25 (Ø152) | 120 : 1 | **3°** | **1° a cada 1/3 de volta** | 0,1° |
| **Elevação** | rosca sem fim → setor de coroa (passo de 120 dentes), módulo 1 (Ø122) | 120 : 1 | **3°** | **1° a cada 1/3 de volta** | 0,1° |

| Eixo | Curso útil | Batente | Dentes que sobraram |
|---|---|---|---|
| **Azimute** | **−50° a +50°** (giro total de 100°) | os ressaltos das pontas da faixa da mesa batem no pilar do ponteiro a ±52° | arco de 120° (41 dentes) |
| **Elevação** | **−20° a +85°** (dá para atirar para baixo) | ressaltos da coroa batem no carro a −22° e +87° | arco de 220° em volta do eixo |

**Por que a coroa não "solta" no fim do curso:** o batente fica **antes** do último dente. No azimute, o setor
tem dentes até ±60°, mas o batente para a mesa em ±52°. No fim do curso, a rosca ainda está engrenada com
**8° de dentes de sobra** (cerca de 2,7 dentes) de cada lado. Na elevação, o batente para em −22°/+87°, e a
rosca continua no meio dos dentes. Se você forçar a manivela no batente, ela só para, porque a rosca não
consegue pular para fora da coroa.

**Leitura em duas etapas, como num micrômetro:**
1. **Escala grande:** número a cada 10°, traço a cada 5°, ponto a cada 2,5°. No azimute, a escala de −50 a +50
   fica **gravada na mesa** (na faixa de trás) e gira com ela. O **ponteiro é fixo na base**, num pilar atrás.
   Na elevação, a escala continua na coroa.
2. **Tambor da manivela** (Ø44): o número 0 fica no braço, e os números 1 e 2 a cada 1/3 de volta (cada um vale 1°).
   Os traços médios marcam 0,5° e os curtos 0,1° (30 marcas por volta). Está gravado **"1 VOLTA = 3°"**. A seta do mancal externo é o índice.

Exemplo: o ponteiro está entre o ponto de 32,5° e o traço de 35°, e o tambor mostra "1" mais 3 traços curtos.
A leitura é 32,5° + 1,3° = **33,8°**. Uma volta inteira da manivela soma 3°. Para ir de 0° a 45° são 15 voltas.

**Travas dos eixos:** são travas em "E" impressas (`trava_6` e `trava_8`). Você encosta a boca da trava no
canal do eixo e empurra de lado. Ela abre um pouco, estala no canal e não sai mais sozinha. Para tirar,
empurre pela aba. Cada eixo tem 2 ou 3 canais, e o punho da manivela também tem a sua trava.

**Manivelas:** cada uma tem 3 mancais (o externo afasta a manivela de tudo), um tambor graduado e um **punho em capa**.
A capa é fechada em cima e encaixa no pino com um **clique**: a ponta do pino é bipartida e tem um dente cônico,
que entra num canal interno da capa. Depois disso ela **não sai mais**, mas **gira solta**, porque o dente fica folgado no canal.

## Lançador de mola

![corte armado](corte_armado.png)

*Corte armado: o pistão (laranja) está recuado e a mola (azul) comprimida. A bolinha está carregada e a parte lisa do pinhão encara a cremalheira.*

**Mola (AliExpress):** mola de compressão de aço, **fio 1,0 mm × Ø externo 12 mm × 100 mm**.
Procure por "compression spring 1.0 x 12 x 100". Se só achar mais longa, corte. A mola trabalha dentro do pistão,
apoiada numa guia na tampa, com pré-carga de ~20 mm e ~55 mm comprimida quando armada (~25–30 N).

**Projétil:** bolinha de **12 mm** (impressa, EVA ou isopor). Ela é carregada **pela boca do cano**, como num
canhão antigo, e rola até o pistão. Com o cano na horizontal, empurre com o `soquete`.

### Como funciona

1. **Armar:** o **volante de armar** (Ø28, com uma capa de clique que gira solta, igual à das manivelas) fica atrás, na esquerda, com o eixo paralelo ao cano.
   Ele gira uma **rosca sem fim
   (16:1, autotravante)**, que gira uma coroa e um **pinhão "mutilado"**. Esse pinhão tem 8 dentes de um lado e é liso do outro,
   como o setor de um gearbox de airsoft. O pinhão puxa a **cremalheira** que fica no topo do pistão, comprimindo a mola.
2. **Clique:** quando o pistão chega a 35 mm de recuo, a **lingueta do gatilho** estala na frente dele.
3. **PRONTO:** continue girando cerca de **2 a 5 voltas**, até a faixa gravada na coroa de armar passar sob a seta.
   Nessa faixa a parte lisa do pinhão encara a cremalheira e o caminho fica livre. São 16 voltas por disparo no total.
4. **Disparar:** aperte o **botão do gatilho** (na esquerda, atrás) para dentro. O dente sai, a mola empurra o pistão
   e o pistão empurra a bolinha.

> Não gire além da faixa PRONTO. Se girar demais, o pinhão volta a pegar a cremalheira e trava contra a tampa.
> Basta voltar uma volta.

### Por que a pontaria não sai do lugar ao armar e disparar

- **A força da mola fecha dentro da culatra:** a mola fica entre o pistão e a tampa, na mesma peça.
  Ela não empurra nem o carro nem a mesa.
- **As roscas de pontaria são autotravantes.** O avanço é de 4–5°, e tan γ < μ. Nenhum esforço que chega às coroas consegue girar
  as roscas de volta. Só a sua mão, pela manivela, move a pontaria.
- **O volante de armar tem o eixo paralelo ao cano.** O torque da sua mão gira o cano em torno do próprio eixo,
  e não em elevação.
- **A rosca de armar também é autotravante.** Soltar a manivela no meio do caminho não dispara nem volta.

### Cortes

| Repouso | Armado |
|---|---|
| ![repouso](corte_repouso.png) | ![armado](corte_armado.png) |

## Projéteis

Formato de granada de morteiro: **corpo cilíndrico curto + ogiva tangente curta** (Ø12,5 × 22 mm), com a ponta
levemente achatada e base plana chanfrada. A base é onde o pistão empurra, e o chanfro ajuda a entrar no funil do cano.

- **Desliza sem vibrar:** tem **duas cintas de guia**, na frente e atrás, com 0,15 mm de folga por lado na alma de 12,8 mm.
  O meio é rebaixado 0,4 mm, então só as cintas tocam o cano. Com pouco atrito e dois apoios afastados, ele não
  "dança" no tubo e sai alinhado.
- **Caminho conferido no CGAL:** o projétil passa livre apoiado no pistão armado, sem tocar no dente do gatilho,
  depois pelo degrau, pelo funil e por todo o cano.
- **Cartucheiras na base:** a própria base guarda **10 projéteis** numa **saia baixa** (16 mm) rente ao anel.
  Eles ficam deitados a 25° e apontando para fora, espalhados por toda a lateral: 5 do lado +Y (de 40° a 140°)
  e 5 do lado −Y (de 200° a 300°, livre da manivela de azimute).
  Cada um entra 13 mm. **A ogiva fica inteira para fora**, e você pega de lado com dois dedos.
  O espaçamento é o mesmo nos dois lados: **25° entre projéteis**.
  Como estão inclinados para cima, a gravidade os mantém no lugar. A saia fica abaixo da mesa giratória.
- **Porta-munição avulso:** a peça `porta_projeteis`, bandeja com 6, continua disponível se você quiser guardar mais.
- **Em 4 partes, de 2 cores (v8):** de baixo para cima, as partes alternam as cores:

  | Parte | Cor | Altura |
  |---|---|---|
  | `projetil_corpo` | cor principal | corpo inteiro |
  | `projetil_anel` | cor 2 | 2 mm, uma faixa na base da ogiva |
  | `projetil_meio` | cor principal | 3,5 mm, o meio da ogiva |
  | `projetil_ponta` | cor 2 | ~3 mm, a ponta |

  - **Encaixes de centragem para colar:** o **pino de Ø5** do corpo atravessa o anel e entra 1,5 mm no meio.
    O meio tem um **pino de Ø3** que entra na ponta.
  - **Folga para a cola:** 0,35 mm no diâmetro, então as partes entram sem forçar e não tem como montar torto.
  - **Cola:** cianoacrilato (Super Bonder) funciona bem em PETG; lixe de leve as faces antes.
    Passe pouca cola, só no pino, para não escorrer na cinta de guia.
  - **Impressão:** cada parte imprime com a face plana para baixo e sem suporte. Os furos ficam embaixo, como pontes de 3 a 5 mm.
  - ![projétil em 2 cores](projetil_cores.png)
  - **Nada muda por fora:** o projétil inteiro tem as mesmas medidas, então desliza no cano e entra nos casulos como antes.

| Impressão do projétil | Peso | Saída (ideal) | Energia |
|---|---|---|---|
| 2 paredes, 15% | 1,2 g | ~12,6 m/s | 0,10 J |
| **3 paredes, 20% (recomendado)** | **1,7 g** | **~12,3 m/s** | **0,12 J** |
| maciço | 2,7 g | ~11,5 m/s | 0,18 J |

**Por que a velocidade quase não muda:** o pistão (~7 g) leva quase toda a massa em movimento. Um projétil
mais pesado sai só um pouco mais devagar, mas com **mais energia**, e sofre menos com o ar. Com atrito, os valores reais
ficam uns 20–30% abaixo. Os projéteis imprimem em pé, com a ponta para cima e sem suporte.
Para lixar as cintas, se ficarem justas, gire o projétil entre os dedos com uma lixa 400.

## Imprimindo em PETG: folgas, encaixes e pontos críticos

### Folgas (parâmetros no topo do `.scad`)

| Parâmetro | Valor | Onde | Se travar |
|---|---|---|---|
| `folga` | 0,25 mm | eixo sextavado em furo sextavado (rosca, coroa, cubos) | 0,30 |
| `folga_gira` | 0,40 mm (Ø) | eixo sextavado girando em furo redondo (mancais, bochechas) | 0,50 |
| `folga_desl` | 0,25 mm (Ø) | pistão no cilindro; quilha no rasgo (0,2 mm por lado) | 0,35 |
| `folga_ax` | 0,15 mm | **rosca encostada nos mancais** (sem jogo axial) | 0,25 |
| `folga_dente` | **0,20 mm** (v8; era 0,12) | entre os dentes (backlash). Cobre o "pé de elefante" e a dilatação do PETG | 0,25 |
| `folga_cola_c` | 0,2 mm por lado | encaixe colado do carro na mesa (espaço para a cola) | — |
| `folga_cola` | 0,35 mm (Ø) | pinos de centragem do projétil | — |

Teste antes de imprimir tudo: imprima `trava_6`, `eixo_el`, `rosca_el` e `manivela_el`.
Se o eixo entrar sem forçar e a trava estalar, as folgas estão boas para a sua impressora.

**Revisão geral das folgas (v8).** Furo impresso em FDM costuma sair 0,1 a 0,2 mm menor e pino um pouco maior.
Por isso conferi todos os encaixes e abri os que estavam no limite:

| Encaixe | Antes | Agora | Por quê |
|---|---|---|---|
| Espiga do cano no soquete da culatra | Ø20 em Ø20,25 | **Ø20 em Ø20,4** | 0,12 por lado virava interferência |
| Ressaltos da baioneta do cano | 0,05 mm de aperto | **justo, sem aperto** | o aperto somado ao degrau das camadas podia travar o giro |
| Espigão da tampa no cilindro | 0,12 por lado | **0,2 por lado** | a tampa precisa girar 30° com a mola empurrando |
| Pino do gatilho na orelha da culatra | Ø4 em Ø4,25 | **Ø4 em Ø4,35** | entrava forçado |
| Dentes de todas as engrenagens | 0,12 | **0,20** | as primeiras camadas alargam o dente |

Ficaram como estavam, porque já têm folga boa:
- o pistão no cilindro (0,25 por lado);
- a quilha no rasgo (0,2);
- o eixo sextavado girando nos mancais (0,2 por lado);
- os anéis de pista nos assentos (0,15);
- as capas dos punhos no pino (0,25);
- os projéteis no cano (0,15) e nos casulos (0,25);
- o pino pivô: Ø8 justo na mesa (Ø8,3), para servir de guia, e solto na base (Ø8,8).

Ative a **compensação de "pé de elefante"** no fatiador (Creality Print: ~0,15 mm). Ela importa principalmente nas engrenagens e nos furos que ficam na primeira camada.

### O que foi reforçado nesta revisão

| Ponto | Problema | Solução |
|---|---|---|
| **Roscas sem fim** | ficavam com 1 mm de jogo de cada lado e podiam escorregar no eixo. Cada 1 mm de deslize gira a coroa sem mexer na manivela: **~0,85° no azimute** | a rosca agora encosta nos mancais (0,15 mm), que funcionam como **mancal de empuxo** |
| **Batente do pistão** | o pistão (~7 g a ~13 m/s) para em menos de 1 mm, gerando **centenas de N** de pico a cada tiro. O tampão do cano preso por 1 M3 numa parede de 2,5 mm ia rachar | o batente agora é um **degrau interno da culatra**, com o **anel `amortecedor`** (TPU de preferência; em PETG serve de espaçador). O cano não leva mais a pancada |
| **Tampa traseira** | era fixa, e o pistão entrava pela frente | **tampa removível com baioneta em J** (2 ressaltos de 3 mm; ~3,6 MPa com a mola). O pistão entra por trás |
| **Pino do punho** | Ø6 impresso em pé: a mão força o pino entre as camadas (~19 MPa) e ele quebra na raiz | **Ø8** (~8 MPa); a fenda do clique fica só na ponta, onde o esforço é pequeno |
| **Elevação sem fim de curso** | insistir na manivela gera até ~4 N·m na coroa e pode esmagar a culatra ou cisalhar dentes | **batentes em −22° e 87°**: 2 ressaltos na face interna da coroa batem num bloco da bochecha |
| **Gatilho** | 4 mm de espessura sob carga constante (~22 MPa com a mola armada): o PETG flui e a lingueta entortaria com o tempo | **6 mm** e dente de 5 mm (~10 MPa). Gira num **pino impresso de Ø4** com `trava_4`, e a mola de lâmina ficou mais longa (deforma <1%, não perde a força) |
| **Cubos e eixos** | os canais das travas reduzem o sextavado para Ø4,6 | torção ~15 MPa com a mão forçando: aceitável |

### Pontos que continuam merecendo atenção

- **Rosca de armar** (impressa em pé): o filete trabalha **entre camadas**. Use 4+ paredes, 100% de preenchimento,
  240–250 °C e ventoinha em 30–50% para a camada colar bem.
- **Dentes da coroa de elevação (módulo 1):** aguentam ~160 N. Os batentes limitam o esforço, mas **não force a manivela quando ela parar**.
- **Lingueta do gatilho com o canhão armado por muito tempo:** o PETG flui sob carga constante. Não deixe armado por dias. Arme, atire e desarme.
- **Culatra:** imprima com a frente para baixo, com suportes nas placas e nos mancais externos, e 4 paredes.
- **PETG em PEI liso** pode arrancar o revestimento da placa. Use cola bastão ou PEI texturizado.
- Os outros pontos (rolamento, mesa e eixos sob carga de pontaria) trabalham com tensões baixas, abaixo de 5 MPa.

### Dica de artilheiro (para eliminar a folga dos dentes)

Toda engrenagem tem folga. Para a leitura ser repetível, **sempre chegue no ângulo girando no mesmo sentido**.
Por exemplo, sempre subindo. Se passou, volte meia volta e chegue de novo pelo mesmo lado. É assim que se aponta
artilharia de verdade. Na elevação, o próprio peso do cano já encosta os dentes sempre do mesmo lado.

## Peso em PETG (1,27 g/cm³)

"Típico" significa 3 paredes de 0,4 mm, topo e fundo de 1,2 mm e 20% de preenchimento giroide.
A estimativa usa volume e área de cada STL (±15%).

| Peça | Maciço | Típico |
|---|---|---|
| base (bandeja com janelas, 10 casulos, plataforma vazada, pilar do ponteiro) | 226 g | **~167 g** |
| mesa (assento do carro, aro dentado, copo, raios, faixa da escala) | 103 g | **~82 g** |
| carro (disco central, bochechas em treliça, mancais) | 93 g | **~66 g** |
| 2 anéis de pista | 52 g | ~44 g |
| setor de elevação raiado (−20° a +85°) | 43 g | ~33 g |
| culatra + cano | 84 g | ~61 g |
| 10 projéteis (40 partes) | 27 g | ~21 g |
| todo o resto (roscas, manivelas, volante, capas, eixos, travas…) | 122 g | ~101 g |
| **Total impresso** | **~749 g** | **~575 g** |
| + BBs e mola | | ~11 g |

Comparando com a v6: **−267 g maciço e −70 g no típico** (−11%).
- **Base, −51 g:** saia → casulos; piso com janelas; plataforma da manivela vazada; sem a aba da escala (v9).
- **Mesa e carro, −14 g:** sem placa, sem disco cheio, bochechas em treliça. Na v9, o assento central e a faixa da escala
  (que também é o contrapeso) somaram uns 16 g na mesa, mas o carro ficou sem garfos nem cunhas.
- **Coroa de elevação, −10 g:** raios no lugar do disco, finos na espessura.
- **Projéteis, +4 g:** as 4 partes pequenas saem praticamente maciças.

**Por que o "típico" cai menos que o "maciço":** na impressão FDM, o miolo já é preenchimento ralo, e quem
pesa são as paredes. Tirar volume ajuda muito no maciço. No típico, o que mais pesa é a área de superfície.
- **Para pesar menos:** imprima a base com **2 paredes e 10–15%**. Ela quase não leva esforço.
- **Mantenha 4 paredes e 100%** nas peças que trabalham: roscas, pinhão, gatilho, travas e punhos.

### Base em bandeja (v6, enxugada na v7)
- **Mais baixa:** a mesa agora fica a 20 mm da mesa da sala (antes eram ~35 mm). O punho da manivela de azimute fica ~4 mm acima do chão.
  Centro de gravidade mais baixo = canhão mais estável.
- **Bandeja:** o setor de dentes da mesa corre **dentro** da base, cercado por uma **parede**
  (2 mm de folga radial). A parede protege os dentes, endurece a base como a borda de uma assadeira, e é nela que ficam os batentes.
- **Rígida sem ser maciça:** o anel da pista (paredes de 2 mm e teto em V) se liga ao cubo central por 4 raios e à parede por 6 nervuras.
  O piso de 3 mm virou só uma moldura: entre as nervuras ele tem **janelas**, porque quem amarra a parede são as nervuras.
- **Casulos de projétil (v7):** a saia contínua saiu. Cada projétil tem o seu casulo, um bloco preso na parede com
  1,8 mm de plástico em volta do furo. **Entre um casulo e outro não há nada**, e por baixo fica tudo aberto.
- **Pilar do ponteiro (v9):** atrás, colado na parede. Leva a agulha da escala de azimute e é o batente.
- **Sem anel por cima:** a mesa continua só apoiada nas BBs. O peso do cano e do carro a mantém no lugar, e os blocos de batente seguram o giro.
- **Plataforma da manivela (v7):** agora é vazada. Os **3 mancais descem até o chão** como paredes, os dois de dentro entram na parede
  da bandeja e **2 trilhos** de 3 × 11 mm amarram os três por baixo da rosca, a 2,75 mm dela. A rosca entra na bandeja por uma janela da parede.

### Mesa e carro: carro colado no centro da mesa (v9)
A mesa giratória (a coroa de azimute) e o carro (bochechas e mancais da elevação) são **duas peças**.
O carro senta **no centro da mesa** e é **colado** ali.

**O encaixe (só para posicionar; quem prende é a cola):**
- **Assento:** o centro da mesa tem um **assento** de Ø48, com a espessura cheia da mesa.
- **Espiga:** em cima do assento há uma **espiga retangular** de 30 × 20 × 4 mm e um **pino de posição** de Ø5, fora do centro.
- **Rebaixo:** o carro tem embaixo um **disco** de Ø48 × 8 mm com o rebaixo dessas duas formas, **0,2 mm de folga por lado** para a cola.
  Por causa do pino fora do centro, o carro só entra **virado para a frente** (cano para o lado dos dentes).
- **Ranhuras:** o fundo do disco tem **2 ranhuras de cola** em anel. O excesso de cola escorre para elas, em vez de levantar o carro.
- **Área colada:** ~2000 mm², somando o anel do assento e as paredes e o topo da espiga.

**Cola recomendada:** **epóxi** de 5 ou 10 minutos (Araldite). É o melhor para PETG e preenche bem a folga de 0,2 mm.
Cianoacrilato (Super Bonder) também cola, mas fica quebradiço com as pancadas dos disparos.
- **Preparo:** lixe as faces com lixa 220 e limpe com álcool.
- **Colagem:** passe a cola, encaixe, aperte com a mão e deixe curar com o canhão em pé.
- **Antes de colar:** coloque o `pino_pivo` na mesa. A cabeça dele fica num rebaixo no topo da espiga e some debaixo do carro.

**Mesa:**
- **Grosso (12 mm):**
  - o **assento do carro**, com 6 bolsões por baixo para aliviar (teto de 3 mm);
  - o **aro dentado**, 6 mm abaixo do pé do dente;
  - a **faixa da escala** atrás.
- **Fino:**
  - o **copo** que abraça o anel de pista (9,2 mm);
  - **6 raios** de 9 × 7 mm. Engrossaram em relação à v8, porque agora levam o peso do carro do centro até o anel das esferas.
- **Faixa da escala (contrapeso):** um arco de **110°** atrás, do lado oposto aos dentes.
  - Tem os **graus gravados no topo** e 10 bolsões por baixo, com teto de 2,4 mm.
  - Faz de **contrapeso** do aro dentado.
  - Nas duas pontas tem os **ressaltos de batente**.

**Base:**
- **Pilar do ponteiro:** atrás (no ângulo 180) há um pilar colado na parede da bandeja, com a **agulha** que aponta para a escala da mesa, 0,5 mm acima dela.
- **Batente:** o pilar é também o **batente de azimute**. Em ±52°, o ressalto da ponta da faixa encosta nele, e a rosca ainda tem dentes de sobra.
- **O que saiu:** a aba da escala e os 2 blocos de batente antigos.

**Carro:**
- **Quadro:** só o disco central, 2 trilhos curtos sob as bochechas e os pés e o trilho dos mancais.
  Saíram os garfos, as travessas e os trilhos compridos.
- **Bochechas:** em treliça, como na v7.1.

**Impressão:**
- **Mesa:** fundo para baixo. A espiga e o pino de posição ficam em cima.
- **Carro:** disco para baixo e bochechas para cima. O rebaixo fica embaixo, como uma ponte de 20 mm.

### Coroa de elevação raiada (v7)
O aro dentado e o cubo continuam com 10 mm. Entre eles há **7 raios** largos (8 a 10 mm) e **finos na espessura: 4 mm** (v7.1),
rentes à face da escala, com cantos arredondados onde encontram o aro e o cubo:
- **2 nas bordas** do setor;
- **1 embaixo de cada ressalto de batente**, que leva a pancada se você forçar a manivela no fim do curso;
- **3 intermediários**.

O resto é janela. Só onde ficam os números da escala sobra uma **faixa fina de 2,4 mm**, rente à face de fora,
que imprime direto na mesa da impressora e mantém a gravação legível.
Os **ressaltos de batente** ficam sobre pastilhas com os 10 mm cheios, porque é por eles que passa a pancada do fim de curso.

### Capa de clique no volante de armar (v7.1)
É a mesma ideia da capa das manivelas, em tamanho menor:
- **Pino:** de Ø5, bipartido, com dente cônico.
- **Capa:** de Ø10 × 14 mm, com um canal interno.

Você empurra a capa, o dente estala no canal e ela **não sai mais, mas gira solta**, com 0,25 mm de folga.
A capa assenta num ressalto de 2 mm, acima do cubo do volante, e não passa da borda dele (Ø28).
Peça: `punho_armar` (imprima em pé, com a tampa para cima).

## Sem nada comprado além das BBs e da mola

### Rolamento impresso (substitui o 608)
A pista da mesa são **dois anéis impressos** (`anel_pista_base` e `anel_pista_mesa`), com um canal em V de 90°.
As **BBs de 6 mm** rolam entre eles.
- **Encaixe:** o anel de baixo tem **8 dentes para baixo**, que entram em rasgos da base. O de cima tem **8 dentes para cima**,
  que entram em rasgos da mesa. Assim os anéis não giram nem saem do centro, e a folga no assento é de 0,15 mm.
- **Por que dispensa o 608:** uma esfera presa entre dois canais em V funciona como um **rolamento de contato angular**.
  Ela segura o peso e também **centraliza** a mesa. O `pino_pivo` passa folgado (Ø8 num furo de Ø8,8) e serve só de guia
  na montagem.
- **Se gastar:** depois de muito uso, imprima só os dois anéis de novo.

**Conferido com a BB real de 5,95 mm** (corte abaixo: anel de baixo, BB e anel de cima):

![corte do rolamento](rolamento_corte.png)

- Cada anel tem um canal em V de 90°, com **3,4 mm de profundidade** e **6,8 mm de boca**.
  A BB tem 5,95 mm, então **não cabe inteira num anel só**: ela fica **3,8 mm para fora** do anel de baixo, e o anel de cima pousa por cima dela.
- **Os anéis não se tocam:** ficam separados por **1,6 mm**. A BB encosta nas **4 faces inclinadas**, 2 em cima e 2 embaixo,
  1,3 mm para dentro da face de cada anel. É isso que centraliza a mesa.
- **Na boca do canal**, a BB tem 5,73 mm de largura, contra 6,8 mm de boca. Mesmo com o "pé de elefante" estreitando a boca, ela entra solta.
- **Quantas BBs:** cabem 60 encostadas umas nas outras. **Com 52 sobra ~0,9 mm entre elas**, e assim elas rolam sem raspar uma na outra.
- **BB de 6,00 contra 5,95:** com a de 5,95 a mesa fica só 0,07 mm mais baixa. Isso não muda nenhuma folga do canhão.
- **Montagem:**
  1. Passe uma camada fina de **vaselina** no canal do anel de baixo. Ela segura as BBs no lugar enquanto você monta, e o giro fica mais macio.
  2. Distribua as 52 BBs.
  3. Pouse o **anel de cima sobre as BBs**, com o canal para baixo.
  4. Só então desça a mesa, encaixando os 8 dentes do anel nos rasgos dela.
  - Se você puser o anel na mesa e virar a mesa, ele pode cair do rebaixo.
- **Teste antes de tudo:** imprima só os dois anéis, ponha as BBs, pouse um sobre o outro e gire com a mão.
  Tem que girar liso, sem raspar face com face.

### Sem parafusos
| Onde era parafuso | Agora | Por que não espana |
|---|---|---|
| Carro → mesa (4) | **colado no centro** (v9): espiga e pino de posição, com epóxi | a cola trabalha numa área grande (~2000 mm²), sem rosca nenhuma |
| Tampa traseira (2) | **baioneta em J**: encaixe, empurre, gire 30° e solte. A mola puxa os ressaltos para o entalhe | é a própria mola que trava a tampa |
| Cano (1) | **baioneta**: encaixe até o colar e gire 30°. Fica justo no fim do curso | o cano quase não leva esforço: a pancada fica no degrau da culatra |
| Pivô do gatilho (1) | **`pino_gatilho`** de Ø4 com **`trava_4`** | o pino só leva cisalhamento (~27 N) |

## Peças (troque `PARTE` no Customizer)

Cada peça já sai na orientação de impressão.

| Grupo | Peças |
|---|---|
| Base e mesa | `base`, `mesa`, `anel_pista_base`, `anel_pista_mesa`, `pino_pivo` |
| Carro | `carro`, `roda_el`, `ponteiro_el` |
| Pontaria | `rosca_az`, `rosca_el`, `manivela_az`, `manivela_el`, `eixo_az`, `eixo_el`, `eixo_munhao` |
| Lançador | `culatra` (frente para baixo, com suportes), `tampa`, `amortecedor` (TPU), `pistao`, `cano`, `pinhao_armar`, `coroa_armar`, `rosca_armar`, `volante_armar`, `eixo_pinhao`, `eixo_armar`, `gatilho`, `pino_gatilho`, `soquete`, `porta_projeteis` |
| Projéteis (×10) | `projetil_corpo` e `projetil_meio` na cor principal; `projetil_anel` e `projetil_ponta` na cor 2 (o `projetil` inteiro continua disponível, numa cor só) |
| Pequenas | `punho` ×2 e `punho_armar` ×1 (capas de encaixe), `trava_4` ×1, `trava_6` ×11, `trava_8` ×2 (imprima algumas a mais de cada) |

**Comprar:** ~52 BBs de 6 mm e 1 mola 1,0×12×100. Mais nada.

**Imprima os anéis de pista com 4 paredes e 100%.**

## Montagem (resumo)

1. **Rolamento:** encaixe o `anel_pista_base` na base (canal para cima, dentes nos rasgos) e o `anel_pista_mesa`
   embaixo da mesa (canal para baixo). Espalhe ~52 BBs no canal e pouse a mesa. Passe o `pino_pivo` pelo centro.
2. **Rosca de azimute:** passe o eixo pelos 3 mancais, depois encaixe as travas e a manivela.
3. **Carro:** ponha o `pino_pivo` na mesa (a cabeça entra no rebaixo da espiga). Passe **epóxi** no assento e na espiga,
   encaixe o carro com o cano para o lado dos dentes (o pino de posição só deixa entrar assim), aperte e deixe curar.
   Depois passe o eixo da rosca de elevação pelos 3 mancais e encaixe as travas e a manivela.
4. **Lançador:**
   - Ponha o `amortecedor` no fundo (frente) do cilindro.
   - Encaixe o cano no soquete, empurre até o colar e gire 30°.
   - Coloque o pistão **por trás**, com a quilha no rasgo de cima, e a mola dentro dele.
   - Feche a `tampa`: encaixe os ressaltos, empurre, gire 30° e solte.
   - Monte o pinhão, a coroa e o eixo, depois a rosca de armar e o volante. Estale a `punho_armar` no pino do volante.
   - Por último, o gatilho: passe o `pino_gatilho` por cima da orelha e prenda com a `trava_4` por baixo.
5. **Cano no carro:** coloque a culatra entre as bochechas e a coroa de elevação do lado de fora. Passe o eixo do munhão e as travas.

## Verificações feitas (CGAL)

Todas as peças geram sólido válido. Também conferi:
- Pinhão e cremalheira, pistão em todo o curso, gatilho, rosca e coroa de armar: sem colisão.
  A única exceção é o contato esperado da lingueta, que o pistão empurra para fora quando está em repouso.
- O disparo passa livre pelo pinhão em toda a janela PRONTO.
- As roscas engrenam com as coroas de azimute e elevação sem se interpenetrar.
- As manivelas giram livres, e o volante de armar dá a volta completa. Ele substituiu uma manivela comprida que,
  perto de 82° de elevação, batia na manivela de elevação.
- **v6 (setores e bandeja):**
  - A mesa gira de −50° a +50° sem tocar na base, na parede nem na rosca. O ponteiro passa 0,5 mm acima da parede.
    Em ±52° o ressalto encosta no batente, e a rosca ainda tem ~8° de dentes de sobra.
  - A rosca de elevação engrena em −20°, 0° e 85°, e os batentes encostam em −22° e +87°.
  - O cano fica livre do carro de −20° a 85°. A manivela de elevação e o volante de armar não se tocam em −20° nem em 85°.
- **v8 (carro separado com cunhas, projétil em 4 partes, folgas revistas):** refiz todas as checagens com as peças da v8,
  e nenhum log acusou malha aberta.
  - **Mesa, carro e cunhas montados** só se tocam nas faces de apoio, com volume 0: garfos sobre o aro e o contrapeso, cunha sobre o garfo e contra o teto da janela.
  - **Cunha 0,3 mm mais funda** que o nominal interfere **só no teto da janela** (8,1 mm³ = 4,6 × 6 × 0,3).
    Ou seja: ao apertar, a força vai toda para onde deve.
  - **Partes do projétil** encaixam com folga para a cola.
  - **Engrenagens com a folga de dente nova (0,20 mm):** todos os pares engrenam sem interferência.
    São as roscas de azimute e de elevação nas coroas (−20°, 0° e 85°), a rosca de armar na coroa de armar,
    o pinhão na cremalheira em 3 fases, e o pistão passando livre no disparo.
  - **Tampa, cano e pistão** na culatra, com as folgas novas: só se tocam nas faces de encosto.
  - **Batentes:** azimute livre em ±49°, e em ±52° só o ponteiro encosta no batente. Elevação livre de −20° a 85°, encostando em −23° e 88°.
  - **Cano:** livre do carro de −20° a 85°.
  - **Manivelas e volante:** livres.
  - **Varredura completa:** azimute em −50°, −25°, 0°, 25° e 50°, com elevação em −20° e em 85°, contra a base: livre.
- **v7.1 (bochechas em treliça, raios finos, capa do volante):**
  - **Correção:** a STL da `mesa` da v7 estava com defeito. As vigas terminavam exatamente no raio interno do contrapeso,
    e as duas curvas só se tocavam pela aresta. A malha não fechava e a STL saía **sem a camada grossa**:
    sem contrapeso, sem pés dos mancais e com as vigas cortadas. Agora as vigas entram 0,5 mm no contrapeso,
    a malha fecha e eu repeti todas as checagens com a mesa. Se você já baixou a STL da v7, **use a nova**.
  - Todas as checagens abaixo foram refeitas com as peças da v7.1, e nenhum log acusou malha aberta.
  - **Capa do volante:** encaixa no pino sem interferência e gira solta. O volante com a capa dá a volta completa
    sem tocar no cano nem na manivela de elevação, em −20° e em 85°.
- **v7 (mesa com carro, coroa raiada, base enxuta):** refiz todas as checagens de pontaria com as peças novas.
  - A mesa com o carro gira de −49° a +49° sem tocar na base nem na rosca. Em ±52° só o ressalto-ponteiro encosta no batente;
    o contrapeso passa 1 mm por dentro dos blocos.
  - A rosca de azimute engrena no aro dentado, e a de elevação na coroa raiada (−20°, 0° e 85°). Os batentes encostam em −23° e 88°.
  - O cano fica livre da mesa com carro de −20° a 85°. As manivelas e o volante não se tocam.
  - A varredura completa (azimute de −50° a +50°, com elevação em −20° e 85°) deu livre.
  - Os anéis de pista assentam na base e no copo novo, e os 10 projéteis entram nos casulos.
