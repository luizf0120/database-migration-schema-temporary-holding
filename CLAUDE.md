# Regras do projeto (canhão de brinquedo em `artilharia/`)

O usuário fala português e imprime em PLA (às vezes PETG), numa Creality, com o Creality Print.

## Resistência: nunca propor peças frágeis
- **Nunca** propor abas, lábios ou ganchos finos em balanço (presos de um lado só), nem encaixes que abram rasgos numa parede fina.
  Exemplo do que deu errado: a baioneta entre o cano e a culatra da v14/v15. A parede em volta do soquete tinha ~1,2 mm reais, os rasgos em J cortavam essa parede e a aba que segurava o cano quebrou.
- Antes de propor qualquer encaixe ou trava, **medir em mm reais (depois da ESCALA)** a parede mais fina e a seção que leva esforço, e dizer esses números ao usuário.
  - Mínimo: **2,5 mm** de parede em peças com esforço; **3 mm** em abas que seguram outra peça. Toda aba tem que ser apoiada dos dois lados ou ter base larga.
  - Não abrir rasgos atravessando a parede que já é a mais fina da peça.
- Preferir encaixes robustos: forma que trava sozinha (sextavado/octógono no furo de mesmo formato), pino transversal grosso, colagem com área grande.
  Baioneta só se o colar em volta for grosso (≥ 3 mm reais depois do rasgo).
- Levar em conta que FDM é fraco entre camadas: nada fino em pé que leve flexão.

## Jeito de trabalhar
- Sempre enviar os arquivos gerados (STL, zip, imagens) ao terminar, sem esperar o usuário pedir.
- Reaproveitar ao máximo as peças que o usuário já imprimiu. Dizer claramente o que precisa e o que não precisa reimprimir.
- Mudar só o que foi pedido. Se outra mudança for necessária, avisar antes e dizer por quê.
- Conferir colisões (CGAL) e a impressão (balanços, apoio na mesa, peças altas finas) antes de entregar.
