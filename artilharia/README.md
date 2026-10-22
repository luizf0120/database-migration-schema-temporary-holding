# Canhão de brinquedo v3: pontaria 90:1 e lançador de mola

![montagem](montagem.png)

Arquivo único: [`artilharia.scad`](artilharia.scad), 100% paramétrico, ASCII puro e sem bibliotecas externas.
Os STLs prontos de todas as peças estão em [`stl/`](stl/), e tudo junto em `canhao_completo.zip`.

## Pontaria

| Eixo | Acionamento | Redução | 1 volta da manivela | 1/4 de volta | 1 marca do tambor |
|---|---|---|---|---|---|
| **Azimute** | rosca sem fim → mesa = coroa de 90 dentes (Ø138) | 90 : 1 | **4°** | **1°** | 0,1° |
| **Elevação** | rosca sem fim → coroa de 90 dentes (Ø92) | 90 : 1 | **4°** | **1°** | 0,1° |

**Leitura em duas etapas, como num micrômetro:**
1. **Escala grande** (na mesa e na coroa de elevação): número a cada 10°, traço a cada 5°, ponto a cada 2,5°.
2. **Tambor da manivela** (Ø44): o número 0 fica no braço, e os números 1, 2 e 3 a cada 1/4 de volta.
   Os traços médios marcam 0,5° e os curtos 0,1°. Está gravado "1 VOLTA = 4°". A seta do mancal externo é o índice.

Exemplo: o ponteiro está entre o ponto de 32,5° e o traço de 35°, e o tambor mostra "1" mais 3 traços curtos.
A leitura é 32,5° + 1,3° = **33,8°**.

**Travas dos eixos:** são travas em "E" impressas (`trava_6` e `trava_8`). Você encosta a boca da trava no
canal do eixo e empurra de lado. Ela abre um pouco, estala no canal e não sai mais sozinha. Para tirar,
empurre pela aba. Cada eixo tem 2 ou 3 canais, e o punho da manivela também tem a sua trava.

**Manivelas:** cada uma tem 3 mancais (o externo afasta a manivela de tudo), um tambor graduado e um punho que gira solto.

## Lançador de mola

![corte armado](corte_armado.png)

*Corte armado: o pistão (laranja) está recuado e a mola (azul) comprimida. A bolinha está carregada e a parte lisa do pinhão encara a cremalheira.*

**Mola (AliExpress):** mola de compressão de aço, **fio 1,0 mm × Ø externo 12 mm × 100 mm**.
Procure por "compression spring 1.0 x 12 x 100". Se só achar mais longa, corte. A mola trabalha dentro do pistão,
apoiada numa guia na tampa, com pré-carga de ~20 mm e ~55 mm comprimida quando armada (~25–30 N).

**Projétil:** bolinha de **12 mm** (impressa, EVA ou isopor). Ela é carregada **pela boca do cano**, como num
canhão antigo, e rola até o pistão. Com o cano na horizontal, empurre com o `soquete`.

### Como funciona

1. **Armar:** o **volante de armar** (Ø28, com pino para girar com o dedo) fica atrás, na esquerda, com o eixo paralelo ao cano.
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
- **Cartucheiras na base:** a própria base guarda **10 projéteis**, 5 de cada lado (nas pernas laterais), em tubos
  **inclinados a 45° para fora**. Cada projétil entra 15 dos seus 22 mm e fica só a ponta da ogiva para fora.
  Um entalhe em cada tubo ajuda a tirar com a unha. Os tubos ficam abaixo da mesa giratória e longe das manivelas.
- **Porta-munição avulso:** a peça `porta_projeteis`, bandeja com 6, continua disponível se você quiser guardar mais.

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
| `folga_dente` | 0,12 mm | entre os dentes (backlash) | 0,18 |

Teste antes de imprimir tudo: imprima `trava_6`, `eixo_el`, `rosca_el` e `manivela_el`.
Se o eixo entrar sem forçar e a trava estalar, as folgas estão boas para a sua impressora.

### O que foi reforçado nesta revisão

| Ponto | Problema | Solução |
|---|---|---|
| **Roscas sem fim** | ficavam com 1 mm de jogo de cada lado e podiam escorregar no eixo. Cada 1 mm de deslize gira a coroa sem mexer na manivela: **~0,85° no azimute** | a rosca agora encosta nos mancais (0,15 mm), que funcionam como **mancal de empuxo** |
| **Batente do pistão** | o pistão (~7 g a ~13 m/s) para em menos de 1 mm, gerando **centenas de N** de pico a cada tiro. O tampão do cano preso por 1 M3 numa parede de 2,5 mm ia rachar | o batente agora é um **degrau interno da culatra**, com o **anel `amortecedor`** (TPU de preferência; em PETG serve de espaçador). O cano não leva mais a pancada |
| **Tampa traseira** | era fixa, e o pistão entrava pela frente | **tampa removível** presa por 2 M3 radiais (carga estática ~27 N), com um ressalto no rasgo que impede o giro. O pistão entra por trás |
| **Pino do punho** | Ø6 impresso em pé: a mão força o pino entre as camadas (~19 MPa) e ele quebra na raiz | **Ø8** (~8 MPa) e **oco para um parafuso M3** como alma de aço. Usa a `trava_8` |
| **Elevação sem fim de curso** | com 90:1, insistir na manivela gera até ~4 N·m na coroa e pode esmagar a culatra ou cisalhar dentes | **batentes em −12° e 82°**: 2 ressaltos na face interna da coroa batem num bloco da bochecha |
| **Gatilho** | 4 mm de espessura sob carga constante (~22 MPa com a mola armada): o PETG flui e a lingueta entortaria com o tempo | **6 mm** e dente de 5 mm (~10 MPa). A orelha tem 6 mm de rosca para o M3, e a mola de lâmina ficou mais longa (deforma <1%, não perde a força) |
| **Cubos e eixos** | os canais das travas reduzem o sextavado para Ø4,6 | torção ~15 MPa com a mão forçando: aceitável. Chaves Allen de aço eliminam isso |

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
| base (em cruz, anel oco, cartucheiras para 10 projéteis) | 426 g | **~225 g** |
| mesa (coroa com janelas) | 150 g | **~82 g** |
| carro | 118 g | ~71 g |
| coroa de elevação | 74 g | ~39 g |
| culatra | 55 g | ~38 g |
| cano | 30 g | ~23 g |
| todo o resto (roscas, manivelas, eixos, travas…) | 103 g | ~87 g |
| **Total impresso** (+10 projéteis ≈ 17 g) | **~960 g** | **~580 g** |
| + rolamento, BBs, mola e parafusos | | ~30 g |

Antes desta revisão, a base e a mesa eram maciças: 651 g + 209 g (~313 g no típico).

**Por que o "típico" cai menos que o "maciço":** na impressão FDM, o miolo já é preenchimento ralo, e quem
pesa são as paredes. Tirar volume ajuda muito no maciço. No típico, o que mais pesa é a área de superfície.
- **Para pesar menos:** imprima a base e o carro com **2 paredes e 10–15%** (dá uns 130 g a menos).
- **Mantenha 4 paredes e 100%** nas peças que trabalham: roscas, pinhão, gatilho, travas e punhos.

### Base em cruz
A base agora tem **4 pernas em cruz** com sapatas e rebaixo para **pé de borracha adesivo de 10 mm**.
Uma das pernas é a plataforma da rosca e da manivela de azimute. Elas alcançam 105 mm do centro e a base
cabe numa mesa de impressão de 220 mm.
- **Pernas:** são nervuras de 10 mm que baixam depois do anel. Quem dá a rigidez é a altura.
- **Anel da pista:** é oco, com paredes de 2 mm e teto em V a 45°, e deixa **8 mm maciços sob o canal das esferas**.
- **Plataforma da manivela:** tem um vão em V por baixo, que fica 9 mm abaixo da calha da rosca.
- **Rotação acidental:** os pés de borracha e a base larga seguram o conjunto. O torque de girar a manivela
  de azimute não faz a base patinar na mesa.

## Peças (troque `PARTE` no Customizer)

Cada peça já sai na orientação de impressão.

| Grupo | Peças |
|---|---|
| Base e mesa | `base`, `mesa`, `pino_pivo` (ou M8), `ponteiro_az` |
| Carro | `carro`, `ponteiro_el`, `roda_el` |
| Pontaria | `rosca_az`, `rosca_el`, `manivela_az`, `manivela_el`, `eixo_az`, `eixo_el`, `eixo_munhao` |
| Lançador | `culatra` (frente para baixo, com suportes), `tampa`, `amortecedor` (TPU), `pistao`, `cano`, `pinhao_armar`, `coroa_armar`, `rosca_armar`, `volante_armar`, `eixo_pinhao`, `eixo_armar`, `gatilho`, `soquete`, `projetil` (×10 para encher as cartucheiras), `porta_projeteis` |
| Pequenas | `punho` ×2, `trava_6` ×11, `trava_8` ×4 (2 do munhão + 2 dos punhos; imprima algumas a mais) |

**Comprar:** 1 rolamento 608, ~52 BBs de 6 mm, 1 mola 1,0×12×100, 6 pés de borracha adesivos de 10 mm e **8 parafusos M3**: 4 × M3×10 (carro),
2 × M3×8 (tampa), 1 × M3×8 (cano) e 1 × M3×16 (pivô do gatilho). Opcional: 2 × M3×30 como alma de aço dos pinos dos punhos.
Os eixos sextavados também podem ser chaves Allen de 6 e 8 mm. Nesse caso é preciso lixar os canais das travas.

## Montagem (resumo)

1. Base: prense o 608 e coloque as BBs. Pouse a mesa e passe o pino pivô.
2. Rosca de azimute: passe o eixo pelos 3 mancais e encaixe as travas e a manivela.
3. Parafuse o carro na mesa e monte a rosca de elevação.
4. Lançador: ponha o `amortecedor` no fundo (frente) do cilindro e encaixe o cano no soquete, preso com M3.
   Coloque o pistão **por trás**, com a quilha no rasgo de cima, e a mola dentro dele. Feche com a `tampa`
   (o ressalto entra no rasgo) e os 2 M3. Monte o pinhão, a coroa e o eixo, depois a rosca de armar e a manivela.
   O gatilho vai no M3 vertical da orelha.
5. Coloque a culatra entre as bochechas, a coroa de elevação do lado de fora, o eixo do munhão e as travas.

## Verificações feitas (CGAL)

Todas as peças geram sólido válido. Também conferi:
- Pinhão e cremalheira, pistão em todo o curso, gatilho, rosca e coroa de armar: sem colisão.
  A única exceção é o contato esperado da lingueta, que o pistão empurra para fora quando está em repouso.
- O disparo passa livre pelo pinhão em toda a janela PRONTO.
- As roscas engrenam com as coroas de azimute e elevação sem se interpenetrar.
- As manivelas giram livres, e o volante de armar dá a volta completa. Ele substituiu uma manivela comprida que,
  perto de 82° de elevação, batia na manivela de elevação.
