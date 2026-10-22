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

1. **Armar:** a manivela de armar fica atrás, na esquerda, com o eixo paralelo ao cano. Ela gira uma **rosca sem fim
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
- **A manivela de armar tem o eixo paralelo ao cano.** O torque da sua mão gira o cano em torno do próprio eixo,
  e não em elevação.
- **A rosca de armar também é autotravante.** Soltar a manivela no meio do caminho não dispara nem volta.

### Cortes

| Repouso | Armado |
|---|---|
| ![repouso](corte_repouso.png) | ![armado](corte_armado.png) |

## Peças (troque `PARTE` no Customizer)

Cada peça já sai na orientação de impressão.

| Grupo | Peças |
|---|---|
| Base e mesa | `base`, `mesa`, `pino_pivo` (ou M8), `ponteiro_az` |
| Carro | `carro`, `ponteiro_el`, `roda_el` |
| Pontaria | `rosca_az`, `rosca_el`, `manivela_az`, `manivela_el`, `eixo_az`, `eixo_el`, `eixo_munhao` |
| Lançador | `culatra` (com suportes), `pistao`, `cano`, `pinhao_armar`, `coroa_armar`, `rosca_armar`, `manivela_armar`, `eixo_pinhao`, `eixo_armar`, `gatilho`, `soquete` |
| Pequenas | `punho` ×3, `trava_6` ×13, `trava_8` ×2 (imprima algumas a mais) |

**Comprar:** 1 rolamento 608, ~52 BBs de 6 mm, 1 mola 1,0×12×100, 6 parafusos M3×10–16
(4 do carro, 1 do pivô do gatilho, 1 que prende o cano).
Os eixos sextavados também podem ser chaves Allen de 6 e 8 mm. Nesse caso é preciso lixar os canais das travas.

## Montagem (resumo)

1. Base: prense o 608 e coloque as BBs. Pouse a mesa e passe o pino pivô.
2. Rosca de azimute: passe o eixo pelos 3 mancais e encaixe as travas e a manivela.
3. Parafuse o carro na mesa e monte a rosca de elevação.
4. Lançador: coloque a mola sobre a guia da tampa e o pistão pela frente do cilindro, com a quilha no rasgo de cima.
   Encaixe o cano e prenda com M3. Monte o pinhão, a coroa e o eixo, depois a rosca de armar e a manivela.
   O gatilho vai no M3 vertical da orelha.
5. Coloque a culatra entre as bochechas, a coroa de elevação do lado de fora, o eixo do munhão e as travas.

## Verificações feitas (CGAL)

Todas as peças geram sólido válido. Também conferi:
- Pinhão e cremalheira, pistão em todo o curso, gatilho, rosca e coroa de armar: sem colisão.
  A única exceção é o contato esperado da lingueta, que o pistão empurra para fora quando está em repouso.
- O disparo passa livre pelo pinhão em toda a janela PRONTO.
- As roscas engrenam com as coroas de azimute e elevação sem se interpenetrar.
- As manivelas giram livres, e a manivela de armar dá a volta completa.
