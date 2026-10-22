# Canhão de brinquedo: reparo com coroa e rosca sem fim

![montagem](montagem.png)

Arquivo único: [`artilharia.scad`](artilharia.scad), 100% paramétrico e sem bibliotecas externas.
O perfil de evolvente, a rosca sem fim e as escalas são gerados no próprio arquivo.

## Como funciona

| Eixo | Acionamento | Redução | 1 volta da manivela | Marca no tambor |
|---|---|---|---|---|
| **Azimute** (horizontal) | rosca sem fim na base fixa → coroa de 72 dentes, que é a própria **mesa giratória** | **72 : 1** | 5° | 0,5° |
| **Elevação** (vertical) | rosca sem fim no carro → coroa de 60 dentes no munhão | **60 : 1** | 6° | 0,5° |

- **Mesa giratória:** a coroa grande de azimute é a mesa. Ela roda sobre um **rolamento axial
  caseiro** (canal em V de 90° em cima e embaixo com ~50 BBs de airsoft de 6 mm) e fica centrada por um
  **rolamento 608** (de skate) com um pino de 8 mm. O carro, as bochechas, a elevação e o cano ficam todos em cima dela.
- **Elevação:** o berço do cano gira num eixo sextavado de 8 mm. A coroa de elevação fica do lado de fora
  da bochecha direita, travada no mesmo eixo sextavado.
- **Leitura dos ângulos:**
  - *Azimute:* escala de 0 a 355° gravada no anel da mesa (traço a cada 5°, número a cada 30°). O ponteiro vermelho fica preso na base.
  - *Elevação:* escala tipo transferidor de −10° a 80°, gravada na face da coroa. O ponteiro vermelho fica preso no braço da bochecha.
  - *Ajuste fino:* cada manivela tem um **tambor micrométrico** com entalhes. Os longos marcam 1° e os curtos 0,5°.
    Uma seta gravada no mancal serve de índice. É o mesmo princípio do tambor de um micrômetro ou de uma luneta de artilharia.

### Um pouco de teoria

**Por que rosca sem fim e não um par de engrenagens normais?**
Uma rosca de 1 entrada avança **um dente da coroa por volta**. A redução é então simplesmente
`i = Z_coroa / n_entradas`, ou seja, 72:1 numa peça de 40 mm. Para chegar a 72:1 com engrenagens retas
seriam precisos uns três estágios.

**Autotravamento.** O ângulo de avanço da rosca é `γ = atan(m / d)`. Aqui dá 6,3° no azimute e 5,4° na elevação.
Se `tan γ < μ`, a coroa **não consegue girar a rosca de volta**. Com μ ≈ 0,2–0,3 (PLA com PLA), a pontaria
fica travada sozinha, sem freio, e o cano não "cai" com o próprio peso. É o mesmo truque dos reparos de artilharia reais
e das tarraxas de violão. O OpenSCAD imprime essa conta no console.

**Coroa helicoidal.** As coroas são engrenagens helicoidais com ângulo de hélice igual ao avanço da rosca
(mesma mão), num cruzamento de eixos a 90°. O contato é pontual (não é uma coroa "envolvente" fresada),
o que é ótimo para impressão 3D e suficiente para um brinquedo. Conferi no CGAL que rosca e coroa
**não se interpenetram** no plano médio nem girando juntas.

**Rolamento em V.** Uma esfera de raio r num V de 90° tem o centro a `r·√2` do vértice. Com o canal de
3,4 mm de profundidade, sobra ~1,7 mm de vão entre a base e a mesa, e as esferas se autocentralizam.

## Peças (troque `PARTE` no Customizer)

Cada peça já sai na orientação de impressão.

| `PARTE` | Qtd | Observação |
|---|---|---|
| `base` | 1 | maior peça (~179 × 164 mm) |
| `mesa` | 1 | coroa Ø148, canal em V para baixo (45°, imprime sem suporte) |
| `carro` | 1 | placa + bochechas + mancais da elevação |
| `berco` | 1 | deitado de lado |
| `cano` | 1 | em pé (provisório, só um tubo) |
| `roda_el` | 1 | escala gravada para cima |
| `rosca_az`, `rosca_el` | 1 cada | em pé, pontas chanfradas a 45° |
| `manivela_az`, `manivela_el` | 1 cada | |
| `eixo_az`, `eixo_el`, `eixo_munhao` | 1 cada | deitados numa face do sextavado (ou use chave Allen, abaixo) |
| `ponteiro_az`, `ponteiro_el` | 1 cada | |
| `pino_pivo` | 1 | ou um parafuso M8 |

### Material extra
- 1 rolamento **608** (22 × 8 × 7)
- ~50 **BBs de airsoft 6 mm** (o console informa o máximo que cabe)
- 4 parafusos **M3 × 10** (ou auto-atarraxantes) para prender o carro na mesa
- pedaços de **filamento 1,75 mm** como pinos-trava dos eixos
- *Gambiarra boa:* os eixos sextavados têm exatamente a medida de **chaves Allen**. Uma de 6 mm pode
  ser o eixo das roscas e uma de 8 mm o munhão. Os furos já têm a folga certa.

## Montagem

1. Prense o 608 no centro da base e encha o canal com as BBs. Um pouco de vaselina ajuda a segurá-las.
2. Pouse a mesa por cima e passe o pino pivô (ou M8) pelo furo central até o rolamento.
3. Coloque a rosca de azimute entre os mancais da base, passe o eixo sextavado, encaixe a manivela no lado
   da seta e trave as duas pontas com filamento.
4. Parafuse o carro na mesa **antes** de montar a rosca de elevação, porque ela fica por cima de dois parafusos.
5. Monte a rosca de elevação, o eixo e a manivela (atrás, lado −X).
6. Ponha o berço entre as bochechas e a coroa de elevação do lado de fora. Passe o eixo do munhão por tudo e trave com filamento.
7. Encaixe os ponteiros: o de azimute no furo quadrado da base e o de elevação no furo do braço da bochecha.
   Para calibrar, gire a coroa de elevação no eixo até o "0" bater com o cano na horizontal.

## Parâmetros úteis

- `z_az`, `z_el`: mais dentes dão mais redução (e coroa maior).
- `m_az`, `m_el`: módulo, ou seja, o tamanho do dente. Abaixo de 1,5 começa a ficar delicado para FDM.
- `folga`, `folga_dente`: ajuste fino para a sua impressora.
- `AZIMUTE`, `ELEVACAO`: posição mostrada na montagem. `ANIMAR = true` usa `$t` (View → Animate):
  as roscas e manivelas giram na proporção certa (72 e 60 voltas por volta da coroa).

## Próximo passo

O mecanismo de disparo ainda não existe. O `cano()` é um tubo de Ø18 encaixado num soquete do berço
(Ø18,4 × 12 mm). Dá para trocar só o módulo `cano()` e o soquete sem mexer em nada do reparo.

![detalhe elevação](detalhe_elevacao.png)
