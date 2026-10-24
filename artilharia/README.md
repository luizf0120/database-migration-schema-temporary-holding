# Canhão de brinquedo v8: carro preso na mesa por cunhas, projéteis em 2 cores, coroas e bochechas vazadas, base enxuta, pontaria 120:1 (3° por volta) e só 2 itens para comprar

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
| **Azimute** | **−50° a +50°** (giro total de 100°) | ressalto da mesa bate em 2 blocos da base a ±52° | arco de 120° (41 dentes) |
| **Elevação** | **−20° a +85°** (dá para atirar para baixo) | ressaltos da coroa batem no carro a −22° e +87° | arco de 220° em volta do eixo |

**Por que a coroa não "solta" no fim do curso:** o batente fica **antes** do último dente. No azimute, o setor
tem dentes até ±60°, mas o batente para a mesa em ±52°. No fim do curso, a rosca ainda está engrenada com
**8° de dentes de sobra** (cerca de 2,7 dentes) de cada lado. Na elevação, o batente para em −22°/+87°, e a
rosca continua no meio dos dentes. Se você forçar a manivela no batente, ela só para, porque a rosca não
consegue pular para fora da coroa.

**Leitura em duas etapas, como num micrômetro:**
1. **Escala grande:** número a cada 10°, traço a cada 5°, ponto a cada 2,5°. No azimute, a escala de −50 a +50
   agora é **fixa na aba da base**, e o ponteiro é a ponta do ressalto da mesa, que passa por cima da parede.
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
| `folga_or` | 0,15 mm por lado | orelha da mesa no garfo do carro | 0,20 |
| janela da cunha | 0,2 mm por lado | cunha de 4,6 mm na janela de 5 mm | — |
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
| base (bandeja com janelas, 10 casulos de projétil, plataforma vazada) | 250 g | **~177 g** |
| mesa (aro dentado, copo, raios finos, contrapeso, 4 orelhas) | 78 g | **~70 g** |
| carro (quadro, bochechas em treliça, mancais) + 4 cunhas | 97 g | **~72 g** |
| 2 anéis de pista | 52 g | ~44 g |
| setor de elevação raiado (−20° a +85°) | 43 g | ~33 g |
| culatra + cano | 84 g | ~61 g |
| 10 projéteis (40 partes) | 27 g | ~21 g |
| todo o resto (roscas, manivelas, volante, capas, eixos, travas…) | 122 g | ~101 g |
| **Total impresso** | **~753 g** | **~578 g** |
| + BBs e mola | | ~11 g |

Comparando com a v6: **−263 g maciço e −67 g no típico** (−10%).
- **Base, −41 g:** saia → casulos; piso com janelas; plataforma da manivela vazada.
- **Mesa e carro, −20 g:** sem placa, sem disco cheio, raios finos e bochechas em treliça. A mesa e o carro separados (v8)
  pesam **3 g a menos no maciço**, mas **~6 g a mais no típico**, porque duas peças têm mais superfície (mais parede) que uma.
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
- **Aba da escala:** só do lado de trás (±62°), com apoio a 45° para imprimir sem suporte.
- **Sem anel por cima:** a mesa continua só apoiada nas BBs. O peso do cano e do carro a mantém no lugar, e os blocos de batente seguram o giro.
- **Plataforma da manivela (v7):** agora é vazada. Os **3 mancais descem até o chão** como paredes, os dois de dentro entram na parede
  da bandeja e **2 trilhos** de 3 × 11 mm amarram os três por baixo da rosca, a 2,75 mm dela. A rosca entra na bandeja por uma janela da parede.

### Mesa e carro: duas peças presas por cunhas (v8)
A mesa giratória (a coroa de azimute) e o carro (bochechas e mancais da elevação) voltaram a ser **peças separadas**.
Elas são presas por **4 orelhas com cunha**, o mesmo princípio da chaveta das máquinas antigas: **aperto total, sem folga e sem parafuso**.

**Como trava:**
1. A mesa tem **4 orelhas** em pé (9 × 6 mm): duas no **aro dentado** (frente) e duas no **contrapeso** (trás), bem embaixo das bochechas.
2. O quadro do carro tem **4 garfos**, abertos para fora, que abraçam as orelhas com **0,15 mm por lado**. Os quatro juntos prendem o carro em X e em Y.
3. Cada orelha tem uma **janela** por onde passa uma **cunha** de 22 mm, inclinada **1:12** (de 3,0 a 4,8 mm de altura).
   A cunha apoia em cima do garfo e empurra o teto da janela, que tem a mesma inclinação. Isso **puxa o carro para baixo contra a mesa**.
4. **Por que não solta com os disparos:** com inclinação de 1:12, o atrito do PETG (μ ≈ 0,3) é umas **4 vezes** maior do que o necessário
   para a cunha ficar parada sozinha (autotravante). E o disparo quase não empurra o carro: a pancada do pistão fecha dentro da culatra.
5. **Apertar:** empurre cada cunha pela ponta grossa, de fora para dentro, até firmar com o dedo, e dê um toque leve com o cabo de uma chave de fenda.
   **Soltar:** toque a ponta fina, que fica para o lado de dentro.
   Cada 1 mm a mais de cunha aperta mais 0,08 mm, então ela compensa a variação da impressão e o desgaste por muito tempo.

**Apoios:** o carro só assenta nos 4 cantos, sobre o aro dentado e o contrapeso, logo ao lado das orelhas.
O cubo central fica 0,3 mm mais baixo de propósito, para o carro não "cavalgar" no meio. Quatro apoios mais quatro cunhas
dão um conjunto que não balança.

**Economia de material:**
- **Mesa:** perdeu as vigas e os pés dos mancais. Ficou só com cubo, aro dentado, copo fino, raios finos, contrapeso e orelhas.
- **Carro:** ganhou um **quadro baixo** de 6 mm (2 trilhos sob as bochechas, 2 travessas, 4 garfos, pés e trilho dos mancais),
  bem mais leve que as vigas de 12 mm que a mesa tinha.

**Mesa:**
- **Grosso (12 mm):** cubo do pivô, aro dentado (6 mm abaixo do pé do dente), contrapeso e orelhas.
- **Fino no resto:**
  - o **copo** que abraça o anel de pista (9,2 mm de altura, 1,6 mm de parede, 3,2 mm de teto);
  - **6 raios** de 8 × **4 mm**, rasos, bem mais finos que o aro, olhando pela face dos dentes.
- **Contrapeso atrás:** um arco de **36°** (de 162° a 198°) rente à parede da base, com 1,5 mm de folga.
  Ele carrega o **ponteiro**, o ressalto dos batentes e as duas orelhas de trás.

**Carro:**
- **Bochechas em treliça:** moldura de 5 mm e diagonais de 4,5 mm a 45° (imprime em pé sem suporte).
  Maciços só o pé, o bloco do munhão, um losango sob o batente de elevação e, na bochecha da direita, as faixas onde encostam as almas dos mancais.
- **Braço do ponteiro:** tem 3 janelas inclinadas.

**Impressão:**
- **Mesa:** fundo para baixo. A janela das orelhas é uma ponte de 5 mm.
- **Carro:** quadro para baixo e bochechas para cima.
- **Cunhas:** **de lado**, para a rampa sair lisa.

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

### Sem parafusos
| Onde era parafuso | Agora | Por que não espana |
|---|---|---|
| Carro → mesa (4) | **4 orelhas + garfos + `cunha` 1:12** (v8) | a cunha trabalha à compressão e trava pelo atrito; não há rosca nenhuma |
| Tampa traseira (2) | **baioneta em J**: encaixe, empurre, gire 30° e solte. A mola puxa os ressaltos para o entalhe | é a própria mola que trava a tampa |
| Cano (1) | **baioneta**: encaixe até o colar e gire 30°. Fica justo no fim do curso | o cano quase não leva esforço: a pancada fica no degrau da culatra |
| Pivô do gatilho (1) | **`pino_gatilho`** de Ø4 com **`trava_4`** | o pino só leva cisalhamento (~27 N) |

## Peças (troque `PARTE` no Customizer)

Cada peça já sai na orientação de impressão.

| Grupo | Peças |
|---|---|
| Base e mesa | `base`, `mesa`, `anel_pista_base`, `anel_pista_mesa`, `pino_pivo` |
| Carro | `carro`, `cunha` ×4, `roda_el`, `ponteiro_el` |
| Pontaria | `rosca_az`, `rosca_el`, `manivela_az`, `manivela_el`, `eixo_az`, `eixo_el`, `eixo_munhao` |
| Lançador | `culatra` (frente para baixo, com suportes), `tampa`, `amortecedor` (TPU), `pistao`, `cano`, `pinhao_armar`, `coroa_armar`, `rosca_armar`, `volante_armar`, `eixo_pinhao`, `eixo_armar`, `gatilho`, `pino_gatilho`, `soquete`, `porta_projeteis` |
| Projéteis (×10) | `projetil_corpo` e `projetil_meio` na cor principal; `projetil_anel` e `projetil_ponta` na cor 2 (o `projetil` inteiro continua disponível, numa cor só) |
| Pequenas | `punho` ×2 e `punho_armar` ×1 (capas de encaixe), `trava_4` ×1, `trava_6` ×11, `trava_8` ×2 (imprima algumas a mais de cada) |

**Comprar:** ~52 BBs de 6 mm e 1 mola 1,0×12×100. Mais nada.

**Imprima os anéis de pista e as cunhas com 4 paredes e 100%.**

## Montagem (resumo)

1. **Rolamento:** encaixe o `anel_pista_base` na base (canal para cima, dentes nos rasgos) e o `anel_pista_mesa`
   embaixo da mesa (canal para baixo). Espalhe ~52 BBs no canal e pouse a mesa. Passe o `pino_pivo` pelo centro.
2. **Rosca de azimute:** passe o eixo pelos 3 mancais, depois encaixe as travas e a manivela.
3. **Carro:** encaixe os 4 garfos do carro nas 4 orelhas da mesa. Passe as 4 `cunha` pelas janelas, com a ponta fina para dentro,
   e empurre até firmar. Depois passe o eixo da rosca de elevação pelos 3 mancais e encaixe as travas e a manivela.
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
