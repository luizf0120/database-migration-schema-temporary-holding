// =====================================================================
//  CANHAO DE BRINQUEDO  -  reparo com coroa e rosca sem fim  (v2)
// ---------------------------------------------------------------------
//  Dois eixos de pontaria, cada um com manivela e reducao 100:1 por
//  rosca sem fim (1 entrada) + coroa helicoidal de 100 dentes:
//
//    AZIMUTE  (horizontal): rosca na base fixa  -> coroa grande que e a
//                           propria MESA giratoria, apoiada num
//                           rolamento de esferas (BBs 6 mm) + 608 central.
//    ELEVACAO (vertical)  : rosca no carro      -> coroa no munhao do cano.
//
//  1 volta de manivela = 3,6 graus.
//
//  Escalas em graus (nas duas coroas):
//    numero a cada 10 graus, traco a cada 5 graus, ponto no meio (2,5 graus)
//    + tambor micrometrico na manivela: 36 marcas = 0,1 graus cada
//
//  Cada eixo de manivela tem 3 mancais: dois junto a rosca e um mancal
//  externo que afasta a manivela de tudo (giro conferido sem colisao).
//
//  O mecanismo de disparo ainda NAO existe: o cano e um tubo simples
//  encaixado no berco (troque o modulo cano() depois).
//
//  Unidades: mm.  Testado no OpenSCAD 2021.01.
// =====================================================================

/* [Visualizacao] */
// O que gerar: "montagem" ou o nome de uma peca para imprimir
PARTE = "montagem"; // [montagem, base, mesa, carro, culatra, tampa, amortecedor, pistao, cano, pinhao_armar, coroa_armar, rosca_armar, volante_armar, gatilho, soquete, projetil, projetil_corpo, projetil_anel, projetil_meio, projetil_ponta, porta_projeteis, eixo_pinhao, eixo_armar, roda_el, rosca_az, rosca_el, manivela_az, manivela_el, punho, trava_6, trava_8, eixo_az, eixo_el, eixo_munhao, ponteiro_el, ponteiro_az, punho_armar, pino_pivo, anel_interno, anel_externo_baixo, anel_externo_cima, pino_gatilho, trava_4]
// Angulo horizontal mostrado na montagem (graus)
AZIMUTE  = 30;
// Angulo vertical mostrado na montagem (graus)
ELEVACAO = 25;
// Giro das manivelas na montagem (graus, so visual)
GIRO_MANIVELA_AZ = 0;
GIRO_MANIVELA_EL = 0;
// Anima com $t (View > Animate)
ANIMAR = false;
MOSTRAR_ESFERAS = true;

/* [Geral] */
// Folgas ajustadas para PETG (bico 0,4, impressora calibrada). Se travar, suba 0,05.
folga       = 0.25;  // encaixes sextavados (eixo dentro de furo sextavado)
folga_gira  = 0.4;   // furos redondos onde eixo sextavado GIRA (diametral)
folga_desl  = 0.25;  // pecas que DESLIZAM (pistao, quilha) - por lado = metade
folga_ax    = 0.15;  // folga axial de cada rosca contra seus mancais (empuxo)
folga_dente = 0.2;   // folga (backlash) nos dentes: 0,2 cobre o "pe de elefante" e a dilatacao do PETG
pa          = 20;    // angulo de pressao dos dentes (graus)
fonte       = "Liberation Sans:style=Bold";
prof_grav   = 0.6;   // profundidade da gravacao das escalas
$fn = 48;

/* [Eixos sextavados] */
// Chave Allen 6 mm serve como eixo das roscas!
f_eixo   = 6;    // eixos das roscas/manivelas (medida entre faces)
f_munhao = 8;    // eixo do munhao (chave Allen 8 mm serve)
// travas em "E" impressas: encaixam num canal do eixo deformando de leve
g_canal  = 1.6;  // largura do canal no eixo
e_trava  = 1.4;  // espessura da trava
dc_6     = 4.6;  // diametro no fundo do canal (eixo 6 e pino do punho)
dc_8     = 6.2;  // diametro no fundo do canal (eixo 8)

/* [Azimute] */
m_az        = 1.25; // modulo
z_az        = 120;  // dentes da coroa/mesa  -> reducao 120:1 (3 graus/volta)
h_mesa      = 12;   // espessura da mesa (largura do dente)
d_rosca_az  = 18;   // diametro primitivo da rosca
L_rosca_az  = 40;   // comprimento da rosca
R_manivela_az = 15; // raio da manivela (centro do punho)
y_ext_az    = 52;   // distancia da face interna do mancal externo ao centro da rosca

/* [Elevacao] */
m_el        = 1;
z_el        = 120;  // dentes da coroa de elevacao -> reducao 120:1 (3 graus/volta)
h_roda_el   = 10;
d_rosca_el  = 14;
L_rosca_el  = 34;
R_manivela_el = 15;
x_ext_el    = 38;   // distancia da face interna do mancal externo ao centro da rosca
el_min      = -20;  // faixa da escala gravada (atira para baixo ate -20)
el_max      = 85;
el_batente  = [-22, 87];  // batentes mecanicos (protegem dentes e culatra)
setor_el    = [50, 270];  // a coroa de elevacao so existe neste setor (graus locais)

/* [Manivela] */
r_tambor  = 22;   // raio do tambor micrometrico
n_tambor  = round(10*360/z_az);  // marcas no tambor: 1 marca = 0,1 grau (30 com 3 graus/volta)
L_punho   = 20;   // comprimento do punho giratorio
d_punho   = 14;
d_pino_p  = 8;    // pino do punho

/* [Base e rolamento] */
// ROLAMENTO DE ESFERAS impresso, de CONTATO EM 4 PONTOS (o tipo das mesas giratorias de
// guindaste): o anel INTERNO (preso na mesa, por cima) fica DENTRO do anel EXTERNO (preso na
// base, por baixo), e as BBs rolam no canal em V que fica entre os dois, PRESAS ali.
// O anel externo e feito em 2 metades (de baixo e de cima) para as BBs entrarem; depois se colam.
R_pista   = 57;    // raio da pista (centro das esferas)
d_esfera  = 6;     // BB de airsoft de 6 mm (as de 5,95 rodam com ~0,1 mm de jogo)
folga_esf = 0.15;  // folga no diametro da esfera dentro do canal
folga_pista = 1.6; // vao radial entre os dois aneis (a BB nao passa por ele: fica presa)
h_rol     = 10;    // altura dos aneis na regiao da pista (5 mm acima e abaixo do centro das BBs)
parede_rol = 3.5;  // parede atras do vertice do V
emb_mesa  = 4;     // quanto o anel interno entra na mesa
folga_mb  = 1;     // vao entre a mesa (coroa) e o topo da base / do anel externo
n_dentes_anel = 8;
h_chaveta = 1.8;   // chavetas na lateral da metade de baixo do anel externo (entram na parede da sede da base)
h_dente_sup = 1.8; // dentes do anel interno (encaixam na mesa)
// base em BANDEJA: a mesa fica so 20 mm acima da mesa de apoio (o minimo para a
// manivela de azimute passar ~4 mm acima dela)
z_mesa_alvo = 20;
h_base    = z_mesa_alvo - folga_mb;   // topo da base sob a mesa (= topo do anel externo)
h_piso    = 3;    // piso da bandeja
// azimute em SETOR: dentes so em +-setor_az; curso limitado a +-az_curso por batentes
setor_az  = 60;
az_curso  = 50;

/* [Carro] */
larg_berco   = 24;
esp_bochecha = 6;
h_placa      = 5;
// altura do eixo da rosca de elevacao acima da mesa: alta o bastante para a
// manivela de elevacao passar POR CIMA da manivela de azimute ao girar a mesa
z_rosca_el   = 46;
esp_mancal_az = 8;
esp_mancal_el = 6;
esp_mancal_ext = 6;

/* [Lancador de mola] */
// Mola de compressao (AliExpress: "mola de compressao 1.0 x 12 x 100 mm")
mola_d    = 12;    // diametro externo da mola
mola_L    = 100;   // comprimento livre
d_proj    = 12;    // projetil: bolinha de 12 mm (impressa, EVA ou isopor)
L_cano    = 110;   // cano a frente do cilindro
z_b       = 18;    // eixo do cano acima do eixo do munhao
// pinhao "mutilado" + cremalheira no pistao
m_arm     = 1.5;
z_pinhao  = 16;    // dentes totais do pinhao
n_dentes_arm = 8;  // dentes presentes (a outra metade e lisa: libera o pistao)
// rosca de armar (autotravante: soltar a manivela no meio nao dispara)
m_ra      = 1.25;
z_ra      = 16;    // coroa de armar -> 16 voltas de manivela por volta do pinhao
d_rosca_ra = 14;
L_rosca_ra = 24;
esp_mancal_ra = 5;
// estado mostrado na montagem: 0 = descansado, 1 = armado e PRONTO
ARMADO = 1;

/* [Projeteis] */
L_corpo_proj = 13;   // corpo cilindrico
L_ogiva_proj = 9;    // ogiva tangente curta
folga_proj   = 0.3;  // folga diametral no cano (0,15 por lado nas cintas)
n_proj       = 6;    // capacidade do porta-municao avulso (peca opcional)
// cartucheiras integradas na base: saia baixa em volta do anel, projeteis deitados
// a 25 graus apontando para fora; a ogiva fica inteira para fora (pega-se de lado)
passo_ang_sup = 25;   // mesmo espacamento angular dos dois lados
angs_sup  = concat([for (i = [-2:2]) 90 + i*passo_ang_sup], [for (i = [-2:2]) 250 + i*passo_ang_sup]);
faixas_sup = [[90 - 2*passo_ang_sup - 12, 90 + 2*passo_ang_sup + 12],
              [250 - 2*passo_ang_sup - 12, 250 + 2*passo_ang_sup + 12]];  // livres da manivela de azimute
r_saia    = [80.5, 97];   // por fora da parede da bandeja
h_saia    = 13;
ang_sup   = 20;   // inclinacao do projetil acima da horizontal
emb_sup   = 13;   // quanto do projetil (22 mm) fica dentro da saia
z_saida   = 12;   // altura do eixo do projetil na face externa da saia

// =====================================================================
//  GRANDEZAS DERIVADAS (nao mexer)
// =====================================================================
rp_az    = m_az*z_az/2;
ra_az    = rp_az + m_az;
rf_az    = rp_az - 1.25*m_az;
ra_raz   = d_rosca_az/2 + m_az;            // raio externo da rosca az
x_raz    = rp_az + d_rosca_az/2;           // distancia entre eixos (az)
z_esf    = h_base - h_rol/2;               // centro das esferas
z_mesa   = h_base + folga_mb;              // fundo da mesa
// rolamento (raios): a esfera encosta nos 2 flancos a 45 graus de cada V
r_esf_v  = (d_esfera + folga_esf)/2;
a_v      = r_esf_v*sqrt(2);                // do centro da esfera ate o vertice do V
R_i_land = R_pista - folga_pista/2;        // face externa do anel interno
R_o_land = R_pista + folga_pista/2;        // face interna do anel externo
R_i_v    = R_pista - a_v;                  // vertice do V do anel interno
R_o_v    = R_pista + a_v;                  // vertice do V do anel externo
dv_i     = R_i_land - R_i_v;               // meia-boca do V (flancos a 45 graus)
dv_o     = R_o_v - R_o_land;
R_i_in   = R_i_v - parede_rol;             // furo do anel interno
R_o_out  = R_o_v + parede_rol;             // fora do anel externo
h_int    = h_rol + folga_mb + emb_mesa;    // altura do anel interno (atravessa o vao e entra na mesa)
r_sede   = [R_o_land - 0.8, R_o_out + 0.15 + 4];   // sede do anel externo na base (piso + parede de 4 mm, com os rasgos das chavetas)
z_deck   = z_mesa + h_mesa;                // topo da mesa
z_raz    = z_mesa + h_mesa/2;              // eixo da rosca az
y_mancal_az = L_rosca_az/2 + folga_ax;     // face interna dos mancais az (a rosca encosta: sem jogo axial)

rp_el    = m_el*z_el/2;
ra_el    = rp_el + m_el;
rf_el    = rp_el - 1.25*m_el;
ra_rel   = d_rosca_el/2 + m_el;
a_el     = rp_el + d_rosca_el/2;           // distancia entre eixos (el)
H_t      = z_rosca_el + a_el;              // altura do munhao sobre a mesa
y_boch_in  = larg_berco/2 + 0.5;
y_boch_out = y_boch_in + esp_bochecha;
y_roda   = y_boch_out + ra_rel + 1.5;      // plano medio da coroa de elevacao
x_mancal_el = L_rosca_el/2 + folga_ax;

gama_az  = atan(m_az/d_rosca_az);          // angulo de avanco das roscas
gama_el  = atan(m_el/d_rosca_el);

n_esferas = floor(2*PI*R_pista/(d_esfera + 0.85));   // ~0,9 mm entre as BBs: rolam sem raspar

// manivela: face do tambor encosta a 1 mm do mancal externo
h_cubo     = 10;
// Eixos: coordenada ao longo do eixo da rosca (Z local). Canais das travas "E":
// g1 = fora do mancal da ponta, g2 = fora do mancal externo, g3 = fora do cubo da manivela.
// Azimute (Z local -> -Y do mundo; manivela no lado +Z local)
az_g1    = -(y_mancal_az + esp_mancal_az + 0.2 + g_canal);
az_g2    = y_ext_az + esp_mancal_ext + 0.2;
y_man_az = az_g2 + g_canal + 0.4;            // face do tambor
az_g3    = y_man_az + h_cubo + 0.2;
az_z0    = az_g1 - 2;   az_z1 = az_g3 + g_canal + 2;
// Elevacao (Z local -> +X do mundo; manivela no lado -Z local)
el_g1    = x_mancal_el + esp_mancal_el + 0.2;
x_man_el = x_ext_el + esp_mancal_ext + 0.2 + g_canal + 0.4;
el_g2    = -(x_ext_el + esp_mancal_ext + 0.2 + g_canal);
el_g3    = -(x_man_el + h_cubo + 0.2 + g_canal);
el_z0    = el_g3 - 2;   el_z1 = el_g1 + g_canal + 2;

// escalas
r_esc_az  = rf_az - 1.1;   // borda externa das marcas de azimute
r_esc_el  = rf_el - 1.7;   // borda externa das marcas de elevacao

// bandeja da base e mesa em setor
r_parede  = [ra_az + 1.75, ra_az + 4.75];   // parede em volta da mesa
z_topo_parede = z_deck - 1.5;
r_aba     = r_parede[1] + 12;               // aba com a escala de azimute (so atras)
// ponteiros
x_pont_el = -(ra_el + 4);                  // furo do ponteiro na bochecha
h_pont_el = y_roda + h_roda_el/2 + 0.5 + 1.5 - y_boch_out; // agulha 0,5 mm da face da coroa
c_pont_el = -x_pont_el - (r_esc_el + 0.5);


// comprimentos dos eixos (o pino de trava da manivela passa pelo cubo)
// Munhao (Z local = +Y do mundo)
mu_g1 = -(y_boch_out + 0.2 + g_canal);
mu_g2 = y_roda + h_roda_el/2 + 0.2;
mu_z0 = mu_g1 - 2;   mu_z1 = mu_g2 + g_canal + 2;
L_eixo_az = az_z1 - az_z0;
L_eixo_el = el_z1 - el_z0;
L_munhao  = mu_z1 - mu_z0;

// ---- lancador (coordenadas do cano: origem no munhao, X para a boca)
d_pist    = mola_d + 5;             // pistao (a mola trabalha dentro dele)
d_cil_i   = d_pist + 2*folga_desl;  // furo do cilindro
d_cil_e   = d_cil_i + 5;            // externo do cilindro
d_alma    = d_proj + 0.8;           // alma do cano
L_pist    = 46;
rp_pin    = m_arm*z_pinhao/2;
p_arm     = PI*m_arm;
x_g       = -7;                     // eixo do pinhao
x_s       = x_g - 4 + L_pist;       // frente do pistao em repouso (= batente do cano)
p_trava   = 35;                     // recuo do pistao quando o gatilho estala
p_max     = 37.5;                   // recuo maximo (tampa traseira)
x_tampa   = x_g - 4 - p_max;        // face interna da tampa
z_rk      = z_b + d_cil_e/2 + 2.2;  // linha primitiva da cremalheira (no topo)
z_g       = z_rk + rp_pin;          // eixo do pinhao
rp_ra     = m_ra*z_ra/2;
y_ra      = -10.5;                  // plano da coroa/rosca de armar (lado esquerdo)
z_ra_eixo = z_g + rp_ra + d_rosca_ra/2;
x_mancal_ra = L_rosca_ra/2 + folga_ax;
gama_ra   = atan(m_ra/d_rosca_ra);
// janela "PRONTO": giro do pinhao em que a parte lisa encara a cremalheira
th_pronto = [212, 305];
th_arm    = ARMADO == 1 ? 255 : 0;
p_arm_vis = ARMADO == 1 ? p_trava : 0;
// eixo do pinhao (Z local = +Y): canais fora da placa direita e fora da coroa
pi_g1 = 6.5 + 0.2;
pi_g2 = y_ra - 3 - 0.2 - g_canal;
pi_z0 = pi_g2 - 2;  pi_z1 = pi_g1 + g_canal + 2;
// eixo da rosca de armar (Z local = +X do cano, manivela atras)
ra_g1    = x_mancal_ra + esp_mancal_ra + 0.2;
x_man_ra = x_mancal_ra + esp_mancal_ra + 0.2 + g_canal + 0.4;
ra_g2    = -(x_mancal_ra + esp_mancal_ra + 0.2 + g_canal);
ra_g3    = -(x_man_ra + h_cubo + 0.2 + g_canal);
ra_z0    = ra_g3 - 2;  ra_z1 = ra_g1 + g_canal + 2;
// gatilho (lingueta lateral esquerda)
x_piv_gat = -14;  y_piv_gat = -14;

echo(str("=== AZIMUTE : reducao ", z_az, ":1  ->  ", 360/z_az, " graus por volta da manivela, ",
         360/z_az/n_tambor, " graus por marca do tambor"));
echo(str("=== ELEVACAO: reducao ", z_el, ":1  ->  ", 360/z_el, " graus por volta da manivela, ",
         360/z_el/n_tambor, " graus por marca do tambor"));
echo(str("=== coroa az D", 2*ra_az, " mm, coroa el D", 2*ra_el, " mm, munhao a ", H_t, " mm da mesa"));
echo(str("=== angulo de avanco az = ", gama_az, " graus, el = ", gama_el,
         " graus  (autotravante se tan(gama) < mu~0,3 -> ", tan(max(gama_az,gama_el)) < 0.3 ? "SIM" : "NAO", ")"));
echo(str("=== rolamento de 4 pontos: ", n_esferas, " BBs de ", d_esfera, " mm no raio ", R_pista, "; aneis de ", R_i_in, " a ", R_o_out, " mm"));
echo(str("=== LANCADOR: curso do pistao ", p_trava, " mm, mola ", mola_d, "x", mola_L,
         " mm comprimida de ", mola_L - (x_s - 3 - x_tampa), " a ", mola_L - (x_s - 3 - p_trava - x_tampa),
         " mm; ", z_ra, " voltas de manivela por disparo"));
echo(str("=== PROJETIL: D", d_proj_e, " x ", L_corpo_proj + L_ogiva_proj, " mm (cano D", d_alma, ")"));
echo(str("=== eixo az = ", L_eixo_az, " mm, eixo el = ", L_eixo_el, " mm, munhao = ", L_munhao, " mm"));

// =====================================================================
//  ENGRENAGENS
// =====================================================================
function polar(r, a) = [r*cos(a), r*sin(a)];
function inv_graus(a) = (tan(a) - a*PI/180)*180/PI;   // funcao involuta

// Perfil 2D de engrenagem de evolvente (transversal)
// dentes = lista de indices presentes (padrao: todos); r_corpo = raio do corpo
module engrenagem2d(m, z, dentes = undef, r_corpo = undef) {
    rp = m*z/2;
    rb = rp*cos(pa);
    ra = rp + m;
    rf = rp - 1.25*m;
    hb = 90/z + inv_graus(pa) - (folga_dente/2)/rp*180/PI; // meia-espessura angular na base
    tmax = sqrt(pow(ra/rb, 2) - 1);
    n = 8;
    flanco = [for (i = [0:n]) let(t = tmax*i/n)
                [rb*sqrt(1 + t*t), t*180/PI - atan(t)]];      // [raio, angulo polar]
    r_in = min(rf, rb) - 0.5;
    dente = concat(
        [polar(r_in, -hb)],
        [for (f = flanco) polar(f[0], -hb + f[1])],
        [for (i = [n:-1:0]) polar(flanco[i][0], hb - flanco[i][1])],
        [polar(r_in, hb)]);
    union() {
        circle(r = r_corpo == undef ? rf : r_corpo, $fn = z*4);
        for (k = (dentes == undef ? [0:z-1] : dentes)) rotate(k*360/z) polygon(dente);
    }
}

// Coroa helicoidal (casa com a rosca sem fim: helice = angulo de avanco)
module engrenagem_helicoidal(m, z, h, beta, dentes = undef, r_corpo = undef, setor = undef) {
    tw = h*tan(beta)/(m*z/2)*180/PI;
    rotate(tw/2)   // dente em 0 graus no plano medio (onde a rosca toca)
        linear_extrude(height = h, twist = tw, slices = max(4, ceil(abs(tw)*2)), convexity = 10) union() {
            engrenagem2d(m, z, dentes, r_corpo);
            // engrenagem em setor: preenche do corpo ate o pe dos dentes so no setor dentado
            if (setor != undef) arco(r_corpo - 1, m*z/2 - 1.25*m + 0.05, setor[0], setor[1]);
        }
}

// Secao transversal da rosca sem fim (1 entrada, flanco reto de 2*pa)
module rosca2d(m, d) {
    p  = PI*m;
    rp = d/2;  ra = rp + m;  rf = rp - 1.25*m;
    N  = 180;
    polygon([for (i = [0:N-1]) let(
        th = 360*i/N,
        u0 = p*th/360,
        u  = u0 - p*floor(u0/p + 0.5),                 // posicao axial em [-p/2, p/2]
        r  = max(rf, min(ra, rp + (p/4 - folga_dente/2 - abs(u))/tan(pa))))
        polar(r, th)]);
}

// Rosca sem fim centrada na origem, eixo Z, com furo sextavado
module rosca(m, d, L) {
    p  = PI*m;
    ra = d/2 + m;  rf = d/2 - 1.25*m;
    T  = 360*L/p;
    difference() {
        intersection() {
            rotate(T/2)   // secao em z=0 alinhada com o perfil base
                linear_extrude(height = L, center = true, twist = T,
                               slices = ceil(L/p*30), convexity = 6)
                    rosca2d(m, d);
            // chanfro de 45 graus nas pontas (imprime melhor em pe)
            rotate_extrude($fn = 64)
                polygon([[0, -L/2], [rf, -L/2], [ra + 0.5, -L/2 + (ra + 0.5 - rf)],
                         [ra + 0.5, L/2 - (ra + 0.5 - rf)], [rf, L/2], [0, L/2]]);
        }
        hex_furo(f_eixo, L + 2);
    }
}

// =====================================================================
//  PECAS AUXILIARES
// =====================================================================
module hex_furo(f, h) {   // furo sextavado com folga, centrado
    cylinder(d = (f + folga)/cos(30), h = h, center = true, $fn = 6);
}
module furo_redondo_p_hex(f, h) {  // furo redondo onde o eixo sextavado gira
    cylinder(d = f/cos(30) + folga_gira, h = h, center = true);
}

// Eixo sextavado de z0 a z1 (Z local) com canais para as travas "E"
module eixo_hex(f, z0, z1, canais, dc) {
    difference() {
        translate([0, 0, z0]) cylinder(d = f/cos(30), h = z1 - z0, $fn = 6);
        for (zc = canais) translate([0, 0, zc]) canal(dc);
    }
}
module canal(dc) {   // anel removido do eixo, de z=0 a z=g_canal
    difference() {
        translate([0, 0, 0]) cylinder(d = 30, h = g_canal);
        translate([0, 0, -1]) cylinder(d = dc, h = g_canal + 2);
    }
}

// Trava em "E": abre um pouco ao ser empurrada de lado no canal e prende
module trava(dc) {
    ro = dc/2 + 2.8;
    w  = dc*0.8;                       // boca menor que o canal -> estala
    linear_extrude(e_trava, convexity = 4) difference() {
        union() {
            circle(r = ro, $fn = 40);
            translate([-ro - 2.5, -3]) square([4, 6]);     // aba para empurrar/tirar
        }
        circle(d = dc - 0.1, $fn = 40);
        translate([0, -w/2]) square([ro + 1, w]);
        polygon([[dc/2 - 0.2, w/2], [ro + 1, w/2 + 1.4], [ro + 1, -w/2 - 1.4], [dc/2 - 0.2, -w/2]]);
    }
}

// Mancal: perfil no plano XY (eixo na origem), extrudado em Z.
// h_ax = distancia do eixo ate a superficie de apoio.
// ang_ind = direcao da seta indice do tambor micrometrico (so se seta=true).
module mancal(h_ax, esp, ang_ind = 90, seta = false, larg = 16) {
    difference() {
        linear_extrude(esp) hull() {
            translate([-larg/2, -h_ax]) square([larg, h_ax]);
            circle(r = larg/2);
            if (seta) rotate(ang_ind) translate([0, -4]) square([r_tambor + 6.5, 8]);
        }
        translate([0, 0, esp/2]) furo_redondo_p_hex(f_eixo, esp + 2);
        if (seta) translate([0, 0, esp - 0.8]) linear_extrude(1, convexity = 10) rotate(ang_ind)
            polygon([[r_tambor + 1.3, 0], [r_tambor + 5.5, -2.4], [r_tambor + 5.5, 2.4]]);
    }
}

// Manivela (local: face do tambor em z=0, voltada para o mancal externo)
//  Tambor graduado: 1 volta = 360/z graus no canhao (4 graus com z=90):
//    numero a cada 1/4 de volta = 1 grau  (0 no braco, 1, 2, 3)
//    traco medio a cada 0,5 grau, traco curto a cada 0,1 grau
//  Cubo sextavado preso por trava "E" no canal do eixo; punho giratorio
//  preso por outra trava "E" no canal do pino.
module manivela(R, zc, n = n_tambor) {
    rt = r_tambor;
    z_p = 8;                                   // topo do braco / base do pino
    difference() {
        union() {
            cylinder(r = rt, h = 3, $fn = 120);
            cylinder(r = 7, h = h_cubo);
            hull() {                           // braco por cima do tambor
                translate([0, 0, 3]) cylinder(r = 7, h = z_p - 3);
                translate([R, 0, 3]) cylinder(r = 6.5, h = z_p - 3);
            }
            translate([R, 0, 0]) pino_punho(z_p);
        }
        translate([0, 0, h_cubo/2]) hex_furo(f_eixo, h_cubo + 2);
        translate([R, 0, 0]) fenda_pino_punho(z_p);
        // escala gravada na face externa do tambor
        translate([0, 0, 3 - prof_grav]) linear_extrude(1, convexity = 10) {
            for (i = [0:n-1]) let(a = i*360/n)
                rotate(a) translate([i % 10 == 0 ? rt - 5.5 : (i % 5 == 0 ? rt - 3.6 : rt - 2.2), -0.3])
                    square([6, 0.6]);
            for (k = [1:round(360/zc)-1]) rotate(k*zc) translate([rt - 8, 0]) rotate(-90)
                text(str(k), size = 3, font = fonte, halign = "center", valign = "center", $fn = 32);
            rotate(zc*floor(round(360/zc)/2) + zc/2) {   // "1 VOLTA / = N graus" em duas linhas
                translate([12.6, 0]) rotate(-90) text("1 VOLTA", size = 1.9, font = fonte,
                    halign = "center", valign = "center", $fn = 24);
                translate([9.6, 0]) rotate(-90) {
                    text(str("= ", round(360/zc)), size = 1.9, font = fonte,
                         halign = "center", valign = "center", $fn = 24);
                    translate([3.4, 1]) difference() { circle(d = 1.3, $fn = 16); circle(d = 0.6, $fn = 12); }
                }
            }
        }
        // entalhes no aro a cada 0,5 grau (visiveis de lado, junto da seta)
        for (i = [0:5:n-1]) rotate(i*360/n)
            translate([rt - (i % 10 == 0 ? 1.4 : 0.8), -0.4, -1]) cube([3, 0.8, 5]);
        // "0" e traco de referencia no braco
        translate([R - 9.5, 0, z_p - prof_grav]) linear_extrude(1, convexity = 10) {
            translate([-3.5, -0.3]) square([4.5, 0.6]);
            translate([-6.5, 0]) rotate(-90) text("0", size = 3, font = fonte,
                                                  halign = "center", valign = "center", $fn = 32);
        }
    }
}

// Punho giratorio (desliza no pino da manivela)
// Punho em CAPA fechada: encaixa no pino com um clique e nunca mais sai, mas gira solto.
// O pino tem a ponta bipartida com um dente conico; a capa tem um canal interno.
// Ao empurrar, as duas metades da ponta se fecham, o dente entra no canal e abre de novo.
// A face de tras do dente e reta: nao volta. Dente folgado no canal (0,4 mm): gira livre.
h_capa   = L_punho + 3;              // capa (2 mm de tampa em cima)
z_dente  = L_punho - 2.2;            // face de tras do dente, medida da base da capa
// Os mesmos modulos fazem a capa pequena do volante de armar: d = diametro do pino,
// L = comprimento util; o dente, o canal e a fenda escalam com k = d/d_pino_p.
d_pino_ra = 5;  d_punho_ra = 10;  L_punho_ra = 12;
module pino_punho(z0, d = d_pino_p, L = L_punho) {   // pino com dente (a fenda e cortada a parte)
    k = d/d_pino_p;  zd = L - 2.2*k;
    cylinder(d = d, h = z0 + 0.2 + zd);
    translate([0, 0, z0 + 0.2 + zd]) cylinder(d1 = d + 1.4*k, d2 = d - 0.6*k, h = 3*k);
}
module fenda_pino_punho(z0, d = d_pino_p, L = L_punho) {
    k = d/d_pino_p;  zd = L - 2.2*k;
    translate([-0.9*k, -6, z0 + 0.2 + zd - 7*k]) cube([1.8*k, 12, 12]);
}
module punho(d = d_pino_p, D = d_punho, L = L_punho) {   // capa: origem na base (que fica 0,2 mm acima do braco)
    k = d/d_pino_p;  hc = L + 3*k;  zd = L - 2.2*k;
    difference() {
        union() {
            cylinder(d = D, h = hc - 1.5*k);
            translate([0, 0, hc - 1.5*k]) cylinder(d1 = D, d2 = D - 3*k, h = 1.5*k);   // topo arredondado
        }
        translate([0, 0, -1]) cylinder(d = d + 0.5, h = zd + 3.5*k + 1);
        // canal interno onde o dente estala (face de baixo reta, teto a 45 graus)
        translate([0, 0, zd - 0.3]) cylinder(d = d + 2.2*k, h = 3.3*k);
        translate([0, 0, zd + 3*k]) cylinder(d1 = d + 2.2*k, d2 = 2*k, h = (d + 0.2)/2);
        translate([0, 0, -0.01]) cylinder(d1 = d + 2.5*k, d2 = d + 0.2, h = 1.2*k);    // chanfro de entrada
    }
}

// Ponteiro em "L": pino quadrado (-Z) + haste (+Z) + agulha (+X) no topo
module ponteiro(h, c) {
    translate([-1.5, -1.5, -7]) cube([3, 3, 7 + h]);
    hull() {
        translate([-1.5, -2, h - 1.5]) cube([3, 4, 1.5]);
        translate([c, 0, h - 1.5]) cylinder(r = 0.3, h = 1.5, $fn = 8);
    }
}
module furo_ponteiro(prof) {
    translate([-1.625, -1.625, -prof]) cube([3.25, 3.25, prof + 1]);
}

// =====================================================================
//  ESCALAS GRAVADAS
//  numero a cada 10 graus, traco a cada 5 graus, ponto no meio de cada 5 graus (2,5 graus)
// =====================================================================
module arco(r1, r2, a1, a2) {
    n = max(8, ceil(abs(a2 - a1)));
    polygon(concat([for (i = [0:n]) polar(r2, a1 + (a2 - a1)*i/n)],
                   [for (i = [n:-1:0]) polar(r1, a1 + (a2 - a1)*i/n)]));
}

// Azimute: escala gravada na MESA (no topo da faixa de tras); o ponteiro e fixo na base, no
// angulo 180 do mundo. Com a mesa em az, o ponto local 180 - az fica sob o ponteiro:
// o valor v vai gravado no angulo local 180 - v.
module escala_az_2d() {
    re = r_faixa_az[1] - 0.4;                      // borda externa das marcas (sob a ponta do ponteiro)
    arco(re - 0.6, re, 180 - az_curso, 180 + az_curso);
    for (v = [-az_curso:5:az_curso]) rotate(180 - v)
        translate([re - (v % 10 == 0 ? 5 : 3.5), -0.4]) square([v % 10 == 0 ? 5 : 3.5, 0.8]);
    for (v = [-az_curso + 2.5:5:az_curso]) rotate(180 - v) translate([re - 1.8, 0]) circle(d = 1.1, $fn = 16);
    for (v = [-az_curso:10:az_curso]) let(a = 180 - v)
        translate(polar(re - 7.6, a)) rotate(a + 90)
            text(str(v), size = 2.8, font = fonte, halign = "center", valign = "center", $fn = 40);
}

// Elevacao: valor v no angulo local v - 180 (vira 180 - v depois de montada)
module escala_el_2d() {
    re = r_esc_el;
    arco(re - 0.6, re, el_min - 180, el_max - 180);
    for (v = [el_min:5:el_max]) rotate(v - 180) {
        r0 = v % 10 == 0 ? re - 7 : re - 4.5;
        translate([r0, -0.4]) square([re - r0, 0.8]);
    }
    for (v = [el_min + 2.5:5:el_max]) rotate(v - 180)
        translate([re - 2, 0]) circle(d = 1.2, $fn = 16);
    for (v = [el_min:10:el_max]) rotate(v - 180)
        translate([re - 8.2, 0]) text(str(v), size = 3.2, font = fonte,
                                      halign = "right", valign = "center", $fn = 40);
}

// =====================================================================
//  PECAS PRINCIPAIS
// =====================================================================

// ---- ROLAMENTO de 4 pontos (perfis em r,z; z = 0 no centro das esferas)
//      anel_interno: preso na mesa (dentes para cima); anel_externo em 2 metades,
//      a de baixo presa na base (chavetas na lateral) e a de cima colada sobre ela.
//      Os fundos do anel interno e da metade de baixo ficam no MESMO plano: em cima de uma
//      mesa lisa, os dois ja ficam na altura certa para as BBs entrarem (monta-se na bancada).
module dentes_anel(r1, r2, z0, h) {
    for (i = [0:n_dentes_anel-1]) rotate(i*360/n_dentes_anel + 360/n_dentes_anel/2)
        translate([0, 0, z0]) rotate(-3.5) rotate_extrude(angle = 7, $fn = 180)
            translate([r1 + 1, 0]) square([r2 - r1 - 2, h]);
}
module rasgos_anel(r1, r2, z0, h, ang = 8) {   // rasgos dos dentes na peca (dente de 7 graus; 0,2 mm de folga na altura)
    for (i = [0:n_dentes_anel-1]) rotate(i*360/n_dentes_anel + 360/n_dentes_anel/2)
        translate([0, 0, z0]) rotate(-ang/2) rotate_extrude(angle = ang, $fn = 180)
            translate([r1 + 0.7, 0]) square([r2 - r1 - 1.4, h]);
}
module anel_interno() {
    rotate_extrude($fn = 180) polygon([[R_i_in, -h_rol/2], [R_i_land, -h_rol/2], [R_i_land, -dv_i], [R_i_v, 0],
                                       [R_i_land, dv_i], [R_i_land, h_int - h_rol/2], [R_i_in, h_int - h_rol/2]]);
    dentes_anel(R_i_in, R_i_land, h_int - h_rol/2 - 0.01, h_dente_sup + 0.01);
}
module anel_externo_baixo() {
    rotate_extrude($fn = 180) polygon([[R_o_land, -h_rol/2], [R_o_out, -h_rol/2], [R_o_out, 0], [R_o_v, 0], [R_o_land, -dv_o]]);
    for (i = [0:n_dentes_anel-1]) rotate(i*360/n_dentes_anel + 360/n_dentes_anel/2)   // chavetas laterais
        rotate(-3.5) rotate_extrude(angle = 7, $fn = 180)
            translate([R_o_out - 0.01, -h_rol/2]) square([h_chaveta + 0.01, h_rol/2 - 0.5]);
}
module anel_externo_cima() {
    rotate_extrude($fn = 180) polygon([[R_o_v, 0], [R_o_out, 0], [R_o_out, h_rol/2], [R_o_land, h_rol/2], [R_o_land, dv_o]]);
}
module esferas() for (i = [0:n_esferas-1]) rotate(i*360/n_esferas) translate([R_pista, 0, 0]) sphere(d = d_esfera, $fn = 24);

// ---- BASE fixa: sede do anel externo do rolamento, bandeja, 3 mancais da rosca az
// posicao de cada projetil guardado: origem no centro da base dele, Z local = eixo
module pos_sup(a) {
    rotate(a) translate([r_saia[1] - emb_sup*cos(ang_sup), 0, z_saida - emb_sup*sin(ang_sup)])
        rotate([0, 90 - ang_sup, 0]) children();
}
// um CASULO por projetil, preso na parede da bandeja (paredes de 1,8 mm em volta do furo);
// entre os casulos nao ha nada: o vao e aberto de baixo ate em cima
module cartucheira() {
    w_casulo = d_alma - folga_proj + 0.5 + 2*1.8;
    for (a = angs_sup) rotate(a) translate([r_saia[0] - 0.5, -w_casulo/2, 0])
        cube([r_saia[1] - r_saia[0] + 0.5, w_casulo, h_saia]);
}
module furos_cartucheira() {
    for (a = angs_sup) pos_sup(a) translate([0, 0, -0.4]) cylinder(d = d_proj_e + 0.5, h = 40);
}
h_trilho_az = 11;   // trilhos da plataforma: passam 2,75 mm abaixo da rosca
module base() {
    difference() {
        union() {
            difference() {                                                           // piso (so entre o anel e a parede)
                cylinder(r = r_parede[1], h = h_piso, $fn = 180);
                translate([0, 0, -1]) cylinder(r = r_sede[0], h = h_piso + 2, $fn = 180);
            }
            difference() {                                                           // parede da bandeja
                cylinder(r = r_parede[1], h = z_topo_parede, $fn = 180);
                translate([0, 0, -1]) cylinder(r = r_parede[0], h = 100, $fn = 180);
            }
            // PILAR DO PONTEIRO (atras, angulo 180): coluna colada na parede, do chao ate um pouco
            // acima da mesa, com a agulha que aponta para a escala gravada na mesa. E tambem o
            // BATENTE de azimute: os ressaltos das pontas da faixa da mesa encostam nele em +-52 graus.
            // (a agulha e a peca ponteiro_az, que encaixa num furo no topo do pilar DEPOIS que a
            //  mesa esta no lugar: se fosse inteirica com a base, a faixa da mesa nao passaria por ela)
            rotate(180 - a_pilar) rotate_extrude(angle = 2*a_pilar, $fn = 180)
                translate([r_pilar, 0]) square([r_parede[0] + 0.5 - r_pilar, z_topo_pilar]);
            cylinder(r = 15, h = h_base);                                            // cubo do pino pivo
            // SEDE do anel externo: piso sob ele e parede em volta, ate o topo do anel.
            // Por dentro (r < r_sede[0]) fica livre: e por ali que o anel interno desce.
            difference() {
                cylinder(r = r_sede[1], h = h_base, $fn = 180);
                translate([0, 0, -1]) cylinder(r = r_sede[0], h = h_base + 2, $fn = 180);
                translate([0, 0, z_esf - h_rol/2]) cylinder(r = R_o_out + 0.15, h = h_rol + 1, $fn = 180);
            }
            // raios do cubo ate a sede: baixos, passam 1 mm abaixo do anel interno
            for (ang = [45:90:315]) rotate(ang) translate([0, -4, 0]) cube([r_sede[0] + 1, 8, z_esf - h_rol/2 - 1]);
            for (ang = [30:60:330]) rotate(ang) translate([r_sede[1] - 1, -1.5, 0])                          // nervuras
                cube([r_parede[0] - r_sede[1] + 1.5, 3, 10]);
            cartucheira();
            // plataforma da rosca e da manivela de azimute, VAZADA: os 3 mancais descem ate o
            // chao, os 2 de dentro entram na parede da bandeja e 2 trilhos amarram os tres
            translate([x_raz, -y_mancal_az, z_raz]) rotate([90, 0, 0]) mancal(z_raz, esp_mancal_az);
            translate([x_raz, y_mancal_az + esp_mancal_az, z_raz]) rotate([90, 0, 0]) mancal(z_raz, esp_mancal_az);
            translate([x_raz, -y_ext_az, z_raz]) rotate([90, 0, 0]) mancal(z_raz, esp_mancal_ext, 0, true);
            for (y0 = [-y_mancal_az - esp_mancal_az, y_mancal_az])
                translate([x_raz - 18, y0, 0]) cube([10.01, esp_mancal_az, h_base]);
            for (x0 = [x_raz - 8, x_raz + 5])
                translate([x0, -(y_ext_az + esp_mancal_ext), 0]) cube([3, y_ext_az + esp_mancal_ext + y_mancal_az + esp_mancal_az, h_trilho_az]);
        }
        // rasgos das chavetas do anel externo na parede da sede (abertos em cima: o rolamento desce pronto)
        for (i = [0:n_dentes_anel-1]) rotate(i*360/n_dentes_anel + 360/n_dentes_anel/2)
            translate([0, 0, z_esf - h_rol/2 - 0.01]) rotate(-4) rotate_extrude(angle = 8, $fn = 180)
                translate([R_o_out, 0]) square([h_chaveta + 0.2, h_rol + 1]);
        translate([-r_furo_pont, 0, z_topo_pilar]) furo_ponteiro(7);              // furo do ponteiro_az
        furos_cartucheira();
        // janelas no piso da bandeja, entre as nervuras (a parede fica presa pelas nervuras)
        translate([0, 0, -1]) linear_extrude(h_piso + 1.01, convexity = 8) offset(r = 2) offset(delta = -2)
            for (ang = [30:60:330]) arco(r_sede[1] + 2, r_parede[0] - 2, ang + 4, ang + 56);
        translate([0, 0, h_base - 10]) cylinder(d = 8.8, h = 11);                  // pino pivo (folgado)
        // piso da sede oco por baixo (teto a 45 graus, 2 mm de piso em cima)
        rotate_extrude($fn = 120) let(r1 = r_sede[0] + 2, r2 = R_o_out, rm = (r1 + r2)/2, zt = z_esf - h_rol/2 - 2)
            polygon([[r1, -0.01], [r2, -0.01], [r2, zt - (r2 - r1)/2], [rm, zt], [r1, zt - (r2 - r1)/2]]);
        // calha e janela da rosca na parede
        translate([x_raz, 0, z_raz]) rotate([90, 0, 0]) cylinder(r = ra_raz + 1, h = 2*y_mancal_az, center = true);
        translate([r_parede[0] - 3, -(y_mancal_az - 0.05), z_raz - ra_raz - 1]) cube([12, 2*y_mancal_az - 0.1, 40]);
    }
}

// ---- MESA giratoria = setor da coroa de azimute (origem no fundo).
//      Com espessura cheia (h_mesa) so o que trabalha:
//        - o ASSENTO DO CARRO no centro (disco de r_assento com espiga e chaveta de posicao):
//          o carro encaixa em cima e e COLADO ali;
//        - o aro dentado (frente);
//        - a FAIXA DA ESCALA atras (110 graus, do lado oposto aos dentes): leva os graus
//          gravados, faz de contrapeso e tem nas pontas os ressaltos que batem no pilar
//          do ponteiro da base (batente de azimute).
//      O resto e fino: o copo que segura o anel de pista e os 6 raios.
h_copo   = 9.2;                 // anel interno entra 4 mm + rasgos dos dentes (2 mm) + 3,2 mm de teto
r_copo   = [R_i_in - 0.15 - 1.6, R_i_land + 0.15 + 1.6];   // copo que segura o topo do anel interno
r_aro_az = rf_az - 6;           // aro dentado: 6 mm abaixo do pe do dente
raios_az = [45, 90, 135, 225, 270, 315];
h_raio_az = 7;  larg_raio_az = 9;   // raios: agora levam o peso do carro do centro ate o anel das esferas
// assento do carro (centro) e encaixe para colar
r_assento = 24;
espiga  = [30, 20, 4];          // espiga retangular em cima do assento (X, Y, altura)
d_chave = 5;  x_chave = 19.5;   // pino de posicao fora do centro: o carro so entra virado para a frente
folga_cola_c = 0.2;             // por lado, no encaixe do carro (espaco para a cola)
h_disco_c = 8;                  // disco do carro que senta no assento
// faixa da escala (atras) e batente
a_faixa  = az_curso + 5;        // a faixa vai de 180 - a_faixa a 180 + a_faixa (graus locais)
r_faixa_az = [r_copo[1] - 0.5, r_aro_az + 5.6];   // fica por dentro do pilar do ponteiro
r_pilar  = r_faixa_az[1] + 1;   // face interna do pilar do ponteiro (base)
a_pilar  = 4/(r_pilar + 2)*180/PI;   // pilar de ~8 mm de largura
r_ponta_az = r_faixa_az[1] - 3.5;    // ponta da agulha
a_ress   = 6;                   // largura angular de cada ressalto de batente
z_topo_pilar = z_mesa + h_mesa + 0.5;   // topo do pilar: a agulha do ponteiro_az fica 0,5 mm acima da faixa
r_furo_pont  = (r_pilar + r_parede[0])/2;   // furo quadrado do ponteiro_az no topo do pilar
c_pont_az    = r_furo_pont - r_ponta_az;    // alcance da agulha
module mesa() {
    passo = 360/z_az;
    dentes = [for (k = [-round(setor_az/passo):round(setor_az/passo)]) (k + z_az) % z_az];
    difference() {
        union() {
            difference() {   // aro dentado: so de r_aro_az ate os dentes
                engrenagem_helicoidal(m_az, z_az, h_mesa, gama_az, dentes, r_aro_az, [-setor_az - 1.5, setor_az + 1.5]);
                translate([0, 0, -1]) cylinder(r = r_aro_az, h = h_mesa + 2, $fn = 240);
            }
            linear_extrude(h_copo, convexity = 6) {
                difference() { circle(r = r_copo[1], $fn = 180); circle(r = r_copo[0], $fn = 180); }   // copo do anel
                arco(r_copo[1] - 0.5, r_aro_az + 0.5, -setor_az - 1.5, setor_az + 1.5);          // liga o aro ao copo
            }
            // raios do assento ao copo, com cantos arredondados
            linear_extrude(h_raio_az, convexity = 6) intersection() {
                circle(r = r_copo[1] - 0.5, $fn = 180);
                offset(r = -2) offset(delta = 2) union() {
                    for (a = raios_az) rotate(a) translate([0, -larg_raio_az/2]) square([r_copo[0] + 1, larg_raio_az]);
                    circle(r = r_assento);
                    difference() { circle(r = r_copo[1], $fn = 180); circle(r = r_copo[0], $fn = 180); }
                }
            }
            cylinder(r = r_assento, h = h_mesa, $fn = 96);                                   // assento do carro
            translate([-espiga[0]/2, -espiga[1]/2, h_mesa - 0.01]) cube([espiga[0], espiga[1], espiga[2] + 0.01]);
            translate([x_chave, 0, h_mesa - 0.01]) cylinder(d = d_chave, h = espiga[2] + 0.01, $fn = 24);
            // faixa da escala (contrapeso) e ressaltos de batente nas pontas
            linear_extrude(h_mesa, convexity = 6) {
                arco(r_faixa_az[0], r_faixa_az[1], 180 - a_faixa, 180 + a_faixa);
                for (sg = [-1, 1]) let(a0 = 180 + sg*a_faixa)
                    arco(r_faixa_az[0] + 0.5, r_pilar + 2.5, min(a0 - sg, a0 + sg*a_ress), max(a0 - sg, a0 + sg*a_ress));   // entra 1 grau na faixa (sem aresta coincidente)
            }
        }
        // assento do anel interno do rolamento (com os rasgos dos dentes)
        translate([0, 0, -1]) difference() {
            cylinder(r = R_i_land + 0.15, h = emb_mesa + 1, $fn = 180);
            translate([0, 0, -1]) cylinder(r = R_i_in - 0.15, h = emb_mesa + 3, $fn = 180);
        }
        // rasgos LARGOS (20 graus): a mesa desce sobre o anel interno, que gira solto nas BBs, e os
        // dentes acham os rasgos sem precisar alinhar exato. Eles so fazem o anel acompanhar a mesa.
        rasgos_anel(R_i_in, R_i_land, emb_mesa - 0.01, h_dente_sup + 0.2, 20);
        translate([0, 0, -1]) cylinder(d = 8.3, h = h_mesa + espiga[2] + 2);
        translate([0, 0, h_mesa + espiga[2] - 3.3]) cylinder(d = 14.5, h = 4);       // cabeca do pino pivo (na espiga)
        // alivios por baixo do assento: 6 bolsoes entre os raios, teto de 3 mm (ponte de 8 mm)
        for (a = raios_az) rotate(a + 30) translate([0, 0, -1])
            linear_extrude(h_mesa - 3 + 1, convexity = 4) offset(r = 1.5) offset(delta = -1.5)
                arco(13, r_assento - 2.5, -30 + 180/PI*(larg_raio_az/2 + 1.5)/17, 30 - 180/PI*(larg_raio_az/2 + 1.5)/17);
        // alivios por baixo da faixa: bolsoes de 10 graus, teto de 2,4 mm, nervuras de 2 mm
        for (k = [0:9]) let(a1 = 180 - a_faixa + 2 + k*(2*a_faixa - 4)/10)
            translate([0, 0, -1]) linear_extrude(h_mesa - 2.4 + 1, convexity = 4)
                arco(r_faixa_az[0] + 2.2, r_faixa_az[1] - 1.6, a1 + 1.1, a1 + (2*a_faixa - 4)/10 - 1.1);
        // escala gravada no topo da faixa
        translate([0, 0, h_mesa - prof_grav]) linear_extrude(1, convexity = 10) escala_az_2d();
    }
}

// ---- CARRO: bochechas + 3 mancais da rosca de elevacao (origem no topo da mesa).
//      Peca separada da mesa: as bochechas e os mancais nascem do quadro do carro,
//      que senta no assento do centro da mesa e e colado nele.
module contorno_bochecha() hull() {
    translate([-20, 0]) square([50, h_placa]);
    translate([0, H_t]) circle(r = 16);
}
// Bochecha em TRELICA: moldura de 5 mm + diagonais de 4,5 mm a 45 graus. Todas as bordas
// das janelas ficam a 45 graus ou em pe, entao imprime sem suporte.
// Macicos: o pe (8 mm), o cubo do munhao (raio ~22 mm em volta do eixo) e, na bochecha
// da direita, um losango sob o batente de elevacao e as faixas onde encostam as almas
// dos mancais de elevacao.
z_teto_boch = H_t - 22;
braco_ponteiro = [[-17, H_t - 52], [x_pont_el + 3, H_t - 5], [x_pont_el - 4, H_t - 5],
                  [x_pont_el - 4, H_t + 5], [-6, H_t + 14]];
module janelas_bochecha(com_braco) {
    p = 24;  w = 4.5;
    offset(r = 1.5) offset(delta = -1.5) difference() {
        intersection() {
            offset(delta = -5) contorno_bochecha();
            polygon([[-80, 8], [80, 8], [80, z_teto_boch - 80], [0, z_teto_boch], [-80, z_teto_boch - 80]]);
        }
        for (sg = [-1, 1], k = [-6:6]) translate([5, 8]) rotate(45*sg) translate([-200, k*p - w/2]) square([400, w]);
        if (com_braco) {
            for (x0 = [-x_mancal_el - esp_mancal_el, x_mancal_el])
                translate([x0 - 1, 0]) square([esp_mancal_el + 2, z_rosca_el - 4]);
            translate([0, H_t - 30]) rotate(45) square(17, center = true);   // sob o batente (r 26..34, embaixo)
        }
    }
}
// janelas do braco do ponteiro: faixas paralelas a borda de baixo dele (46 graus)
module janelas_braco() {
    d = braco_ponteiro[1] - braco_ponteiro[0];
    offset(r = 1.5) offset(delta = -1.5) intersection() {
        offset(delta = -4.5) polygon(braco_ponteiro);
        translate([x_pont_el + 8, 0]) square([-21 - (x_pont_el + 8), 200]);
        translate(braco_ponteiro[0]) rotate(atan2(d[1], d[0]))
            for (f = [[6, 14], [19, 27], [32, 40]]) translate([-200, -f[1]]) square([400, f[1] - f[0]]);
    }
}
module perfil_bochecha(com_braco) {
    difference() {
        union() {
            contorno_bochecha();
            if (com_braco) polygon(braco_ponteiro);   // braco inclinado que segura o ponteiro
        }
        janelas_bochecha(com_braco);
        if (com_braco) janelas_braco();
    }
}

// Quadro do carro (origem no topo da mesa): um DISCO no centro, que senta no assento da
// mesa e e colado nele (a espiga e a chaveta da mesa entram num rebaixo por baixo do disco),
// 2 trilhos curtos sob as bochechas e os pes e o trilho dos mancais de elevacao.
h_quadro = 6;
module quadro_carro() {
    difference() {
        union() {
            cylinder(r = r_assento, h = h_disco_c, $fn = 96);                                 // disco central
            for (y0 = [y_boch_in, -y_boch_out]) translate([-x_mancal_el - esp_mancal_el - 1, y0, 0])
                cube([x_mancal_el + esp_mancal_el + 1 + 32, esp_bochecha, h_quadro]);      // trilhos sob as bochechas
            // pes dos mancais da rosca de elevacao + trilho que os amarra (mantem a rosca alinhada)
            for (xs = [[-x_mancal_el - esp_mancal_el, esp_mancal_el], [x_mancal_el, esp_mancal_el],
                       [-x_ext_el - esp_mancal_ext, esp_mancal_ext]])
                translate([xs[0], y_boch_out - 0.5, 0]) cube([xs[1], y_roda + 7 - y_boch_out + 0.5, h_quadro]);
            translate([-x_ext_el - esp_mancal_ext, y_roda + 4, 0])
                cube([x_ext_el + esp_mancal_ext + x_mancal_el + esp_mancal_el, 3, h_quadro]);
        }
        // rebaixo do encaixe (espiga + chaveta da mesa), com folga para a cola
        translate([-espiga[0]/2 - folga_cola_c, -espiga[1]/2 - folga_cola_c, -1])
            cube([espiga[0] + 2*folga_cola_c, espiga[1] + 2*folga_cola_c, espiga[2] + 0.3 + 1]);
        translate([x_chave, 0, -1]) cylinder(d = d_chave + 2*folga_cola_c, h = espiga[2] + 0.3 + 1, $fn = 24);
        // ranhuras de cola no fundo do disco (o excesso de cola escorre para elas)
        for (r = [r_assento - 3, 18.5]) difference() {
            translate([0, 0, -1]) cylinder(r = r + 0.6, h = 1.5, $fn = 96);
            translate([0, 0, -2]) cylinder(r = r - 0.6, h = 3, $fn = 96);
        }
    }
}

module carro() {
    difference() {
        union() {
            quadro_carro();
            // bochecha direita (+Y, com braco do ponteiro) e esquerda
            translate([0, y_boch_out, 0]) rotate([90, 0, 0])
                linear_extrude(esp_bochecha) perfil_bochecha(true);
            translate([0, -y_boch_in, 0]) rotate([90, 0, 0])
                linear_extrude(esp_bochecha) perfil_bochecha(false);
            // batente de elevacao (bloco entre a bochecha e a coroa)
            translate([0, y_boch_out + 3, 0]) rotate([90, 0, 0]) linear_extrude(3)
                translate([0, H_t]) arco(26, 34, 264, 276);
            // espacador entre a bochecha e a coroa
            translate([0, y_boch_out - 0.01, H_t]) rotate([-90, 0, 0])
                cylinder(d = 18, h = y_roda - h_roda_el/2 - 0.3 - y_boch_out);
            // mancais junto a rosca de elevacao, ligados a bochecha por uma alma
            for (xm = [-x_mancal_el, x_mancal_el + esp_mancal_el]) {
                translate([xm, y_roda, z_rosca_el]) rotate([90, 0, -90])
                    mancal(z_rosca_el, esp_mancal_el, larg = 14);
                translate([xm - esp_mancal_el, y_boch_out - 0.5, 0])
                    cube([esp_mancal_el, y_roda - y_boch_out, z_rosca_el - 4]);
            }
            // mancal externo (manivela atras, -X) com seta indice para baixo
            translate([-x_ext_el, y_roda, z_rosca_el]) rotate([90, 0, -90])
                mancal(z_rosca_el, esp_mancal_ext, -90, true, larg = 14);
        }
        translate([0, 0, H_t]) rotate([90, 0, 0]) furo_redondo_p_hex(f_munhao, 120);
        // furo do ponteiro de elevacao (atravessa a bochecha)
        translate([x_pont_el, y_boch_out, H_t]) rotate([-90, 0, 0]) furo_ponteiro(esp_bochecha + 1);
    }
}

// =====================================================================
//  LANCADOR DE MOLA  (coordenadas do cano: origem no munhao, X para a boca)
//  manivela -> rosca de armar (autotravante) -> coroa -> pinhao mutilado
//  -> cremalheira no pistao -> comprime a mola -> gatilho lateral estala.
//  Toda a forca da mola fecha DENTRO da culatra (pistao <-> tampa), e as
//  roscas de pontaria sao irreversiveis: armar e disparar nao mexem na mira.
// =====================================================================
function lista_dentes_arm() = [for (k = [0:n_dentes_arm-1]) (round(270/(360/z_pinhao)) + k) % z_pinhao];

// cremalheira (perfil no plano XZ do cano, dentes para cima)
module cremalheira2d() {
    h0 = p_arm/4 - folga_dente/2;
    t  = tan(pa);
    for (j = [0:n_dentes_arm-1]) let(xc = x_g - p_arm/2 + j*p_arm)
        polygon([[xc - h0 - 1.25*m_arm*t, z_rk - 1.25*m_arm - 0.01], [xc - h0 + m_arm*t, z_rk + m_arm],
                 [xc + h0 - m_arm*t, z_rk + m_arm], [xc + h0 + 1.25*m_arm*t, z_rk - 1.25*m_arm - 0.01]]);
}
x_fim_crem = x_g - p_arm/2 + (n_dentes_arm - 1)*p_arm + 2;

// ---- PISTAO (desenhado em repouso; recua em -X ao armar)
module pistao() {
    x0 = x_g - 4;
    difference() {
        union() {
            translate([x0, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_pist, h = L_pist);
            // quilha que sai pelo rasgo do topo + cremalheira
            translate([x0 + 1, -2.5, z_b + d_pist/2 - 1])
                cube([x_fim_crem - x0 - 1, 5, z_rk - 1.25*m_arm - (z_b + d_pist/2 - 1) + 0.02]);
            rotate([90, 0, 0]) linear_extrude(5, center = true) cremalheira2d();
        }
        translate([x0 - 1, 0, z_b]) rotate([0, 90, 0]) cylinder(d = mola_d + 1, h = L_pist - 3 + 1);
        translate([x0 + L_pist + d_proj/2 - 1.5, 0, z_b]) sphere(d = d_proj + 0.5);   // concha
    }
}

// ---- CULATRA: berco do munhao + cilindro da mola + caixa do pinhao + mancais da rosca de armar
module placa_pinhao() {   // placa no plano XZ, de y=0 a y=3
    rotate([90, 0, 0]) translate([0, 0, -3]) linear_extrude(3) difference() {
        hull() {
            translate([x_g - 14, z_b]) square([28, d_cil_e/2]);
            translate([x_g, z_g]) circle(r = 7);
        }
        translate([x_g, z_g]) circle(d = f_eixo/cos(30) + 0.6);
    }
}
module mancal_ra(seta = false) {   // parede no plano YZ, espessura esp_mancal_ra em +X
    difference() {
        rotate([90, 0, 90]) linear_extrude(esp_mancal_ra) hull() {
            translate([-18, z_b + 6]) square([18 - 3.5, 1]);
            translate([-6.5, z_b + 6]) square([3, z_g - z_b - 6]);
            translate([y_ra, z_ra_eixo]) circle(r = 7);
        }
        translate([esp_mancal_ra/2, y_ra, z_ra_eixo]) rotate([0, 90, 0]) furo_redondo_p_hex(f_eixo, esp_mancal_ra + 2);
        // seta indice da janela PRONTO (aponta para a coroa de armar)
        if (seta) translate([esp_mancal_ra + 0.01, -18 + 0.7, z_g]) rotate([90, 0, 0])
            linear_extrude(1, convexity = 4) polygon([[0, 0], [-3.5, -2], [-3.5, 2]]);
    }
}
// Culatra: o pistao entra POR TRAS (tampa removivel); na frente ha um degrau interno
// que e o batente do pistao (a pancada do disparo fica na propria culatra, nao no cano),
// com um anel amortecedor de 2 mm (TPU de preferencia; em PETG serve de espacador).
x_tr      = x_tampa - 6;     // boca traseira do cilindro (entra o espigao da tampa)
d_degrau  = d_proj + 2;      // furo do degrau (a bolinha passa folgada)
x_degrau  = x_s + 2;         // face do degrau (o amortecedor fica entre x_s e x_degrau)
x_soq     = x_degrau + 4;    // inicio do soquete do cano
module culatra() {
    r_e = d_cil_e/2;
    difference() {
        union() {
            hull() {
                rotate([90, 0, 0]) cylinder(r = 12, h = larg_berco, center = true);
                translate([-16, 0, 0]) rotate([90, 0, 0]) cylinder(r = 8, h = larg_berco, center = true);
                translate([-20, -larg_berco/2, z_b - 4]) cube([40, larg_berco, 4]);
            }
            translate([x_tr, 0, z_b]) rotate([0, 90, 0]) cylinder(r = r_e, h = x_soq - x_tr);
            // reforco da frente (degrau + soquete do cano)
            translate([x_s - 4, 0, z_b]) rotate([0, 90, 0]) cylinder(d = 28, h = x_soq + 10 - (x_s - 4));
            translate([0, 3.5, 0]) placa_pinhao();     // placa ocupa [y, y+3]
            translate([0, -6.5, 0]) placa_pinhao();
            translate([x_g - x_mancal_ra - esp_mancal_ra, 0, 0]) mancal_ra(true);
            translate([x_g + x_mancal_ra, 0, 0]) mancal_ra();
            // orelha do gatilho (so por cima; o pino impresso de 4 mm passa por ela)
            translate([0, 0, z_b + 7.3]) linear_extrude(6) hull() {
                translate([x_piv_gat, y_piv_gat]) circle(r = 4.5);
                translate([x_piv_gat - 6, -5]) square([12, 1]);
            }
        }
        rotate([90, 0, 0]) hex_furo(f_munhao, larg_berco + 2);
        // furo do cilindro (aberto atras) + degrau + soquete do cano
        translate([x_tr - 1, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_cil_i, h = x_degrau - x_tr + 1);
        translate([x_degrau - 1, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_degrau, h = 10);
        translate([x_soq, 0, z_b]) rotate([0, 90, 0]) cylinder(d = 20.4, h = 11);   // espiga de 20: 0,2 mm por lado
        // rasgo da quilha: aberto atras (o pistao entra por tras), fechado na frente
        translate([x_tr - 1, -2.7, z_b]) cube([x_fim_crem + 1.5 - x_tr + 1, 5.4, r_e + 1]);   // quilha 5 + 0,2/lado
        // janela do dente do gatilho (lado esquerdo, um pouco acima do centro)
        translate([x_s - p_trava - 0.5, -r_e - 1, z_b + 0.5]) cube([6, r_e + 1 - d_cil_i/2 + 1, 7]);
        translate([x_piv_gat, y_piv_gat, z_b + 7.3 - 0.01]) cylinder(d = 4.35, h = 7);    // pino do gatilho (furo impresso sai ~0,1 menor)
        // baioneta da tampa (J: empurra, gira 30 graus, a mola puxa para o entalhe e trava)
        em_eixo() rasgo_j(d_cil_i/2 - 0.5, r_e + 1, x_tr, -1, ang_baioneta, giro_baioneta, 1.4, 2.8, 6.3, 6.3);
        // baioneta do cano (L com aperto no fim do curso)
        em_eixo() rasgo_j(10 + folga/2 - 0.5, 14 + 1, x_soq + 10, 1, ang_baioneta, giro_baioneta, 0, 3.8, 7.2, 7.2, false);
    }
}

// ---- TAMPA traseira: espigao + guia da mola, presa por BAIONETA (2 ressaltos).
//      Montagem: encaixe os ressaltos nos rasgos, empurre (comprime a mola), gire 30 graus
//      e solte: a mola puxa os ressaltos para o entalhe e a tampa nao gira mais sozinha.
module tampa() {
    rm = d_cil_i/2; d = 1.5/rm*180/PI;
    union() {
        translate([x_tr - 1.5 - 3, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_cil_e, h = 3);
        translate([x_tr - 1.5 - 0.01, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_cil_i - 0.4, h = x_tampa - x_tr + 1.5 + 0.01);   // gira 30 graus: 0,2 por lado
        translate([x_tampa - 0.01, 0, z_b]) rotate([0, 90, 0]) cylinder(d1 = mola_d - 2.5, d2 = mola_d - 3.5, h = 25);
        em_eixo() for (a = ang_baioneta) setor(rm - 1, d_cil_e/2 - 0.4, a + giro_baioneta - d, a + giro_baioneta + d, x_tr + 1.5, x_tr + 4.5);
    }
}

// ---- AMORTECEDOR (anel entre o pistao e o degrau; ideal em TPU)
module amortecedor() {
    translate([x_s, 0, z_b]) rotate([0, 90, 0]) difference() {
        cylinder(d = d_cil_i - 0.3, h = x_degrau - x_s);
        translate([0, 0, -1]) cylinder(d = d_degrau + 0.4, h = 10);
    }
}

// ---- CANO (espiga de 20 mm no soquete da culatra, preso por baioneta; nao leva a pancada do pistao)
module cano() {
    x0 = x_soq;
    difference() {
        union() {
            translate([x0, 0, z_b]) rotate([0, 90, 0]) cylinder(d = 20, h = 10 + L_cano);
            translate([x0 + 10, 0, z_b]) rotate([0, 90, 0]) cylinder(d1 = 28, d2 = 20, h = 4);   // colar (chanfrado: sem suporte)
            translate([x0 + 10 + L_cano - 6, 0, z_b]) rotate([0, 90, 0]) cylinder(d = 24, h = 6);
        }
        translate([x0 - 1, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_alma, h = L_cano + 12);
        translate([x0 - 0.01, 0, z_b]) rotate([0, 90, 0]) cylinder(d1 = d_degrau, d2 = d_alma, h = 2);
    }
    // ressaltos da baioneta (encaixe: alinhe, empurre ate o colar e gire 30 graus; aperta no fim)
    em_eixo() for (a = ang_baioneta) let(d = 1.5/11*180/PI)
        setor(9.9, 13.6, a + giro_baioneta - d, a + giro_baioneta + d, x0 + 2.95, x0 + 6.2);    // justo no fim do curso (sem aperto: PETG nao espana)
}

// ---- PINHAO mutilado (Z local = -Y do cano quando montado)
module pinhao_armar() {
    difference() {
        linear_extrude(6, center = true, convexity = 6)
            engrenagem2d(m_arm, z_pinhao, lista_dentes_arm(), rp_pin - 1.25*m_arm - 0.6);
        hex_furo(f_eixo, 10);
    }
}
// ---- COROA de armar com a faixa "PRONTO" gravada na face externa
module coroa_armar() {
    difference() {
        translate([0, 0, -3]) engrenagem_helicoidal(m_ra, z_ra, 6, gama_ra);
        hex_furo(f_eixo, 10);
        translate([0, 0, 3 - prof_grav]) linear_extrude(1, convexity = 6) {
            arco(5.6, 7.6, 180 + th_pronto[0], 180 + th_pronto[1]);
            rotate(180 + th_pronto[0]) translate([5.6, -0.4]) square([2.6, 0.8]);
        }
    }
}

// ---- VOLANTE de armar (16 voltas por disparo): disco recartilhado + pino de giro.
//      Alcance de 14 mm do eixo: fica fora do caminho da manivela de elevacao em
//      qualquer elevacao (uma manivela comprida batia nela perto de 82 graus).
r_volante = 14;
module volante_armar() {
    difference() {
        union() {
            cylinder(r = r_volante - 0.8, h = 8, $fn = 60);
            for (i = [0:17]) rotate(i*20) translate([r_volante - 1.2, 0, 0]) cylinder(r = 1.2, h = 8, $fn = 12);
            cylinder(r = 7, h = h_cubo);
            translate([8.5, 0, 0]) cylinder(d = d_punho_ra, h = h_cubo);     // assento da capa (acima do cubo)
            translate([8.5, 0, 0]) pino_punho(h_cubo, d_pino_ra, L_punho_ra); // pino da capa giratoria
        }
        translate([0, 0, h_cubo/2]) hex_furo(f_eixo, h_cubo + 2);
        translate([8.5, 0, 0]) fenda_pino_punho(h_cubo, d_pino_ra, L_punho_ra);
        translate([0, 0, 8 - prof_grav]) linear_extrude(1, convexity = 6)  // seta do sentido de armar
            rotate(200) translate([-1.5, -9.5]) polygon([[0, 0], [3, 0], [3, 4], [5, 4], [1.5, 7], [-2, 4], [0, 4]]);
    }
}

// ---- GATILHO: lingueta que gira num pino impresso de 4 mm (desenhada armada)
//      apertar o botao (para dentro) tira o dente da frente do pistao.
//      6 mm de espessura e dente de 5 mm: tensao ~10 MPa com a mola armada
//      (o PETG flui sob carga constante; abaixo de ~15 MPa fica seguro).
module gatilho() {
    P  = [x_piv_gat, y_piv_gat];
    xt = x_s - p_trava + 0.2;
    difference() {
        translate([0, 0, z_b + 1]) linear_extrude(6, convexity = 6) {
            hull() { translate(P) circle(r = 4); translate([xt + 2.5, -14.5]) circle(r = 2.5); }
            translate([xt, -15]) square([5, 15 - 6.6]);                   // dente
            hull() { translate(P) circle(r = 3.5); translate([-36, -19]) circle(r = 2.8); }
            translate([-39, -19]) circle(r = 5.5);                        // botao
            hull() {                                                      // mola de lamina longa (deforma < 1%)
                translate([-18, -18.6]) circle(r = 0.65, $fn = 12);
                translate([-42, -d_cil_e/2 + 0.3]) circle(r = 0.65, $fn = 12);
            }
        }
        translate([P[0], P[1], 0]) cylinder(d = 4.4, h = 100);
    }
}

// ---- PROJETIL (estilo granada de morteiro): cilindro curto + ogiva tangente.
//      Duas cintas de guia (frente e tras) com 0,15 mm de folga por lado; o meio e
//      rebaixado 0,4 mm, so as cintas tocam o cano: desliza leve e nao balanca.
//      Base plana (o pistao empurra) com chanfro para entrar no funil do cano.
d_proj_e = d_alma - folga_proj;
function perfil_projetil() = let(
    R   = d_proj_e/2,  Lc = L_corpo_proj,  Ln = L_ogiva_proj,
    rho = (R*R + Ln*Ln)/(2*R),                    // raio da ogiva tangente
    r_m = 1.0,                                    // ponta achatada (meplat)
    x_m = sqrt(rho*rho - pow(rho - R + r_m, 2)),  // onde a ogiva chega ao meplat
    ogiva = [for (i = [0:24]) let(x = x_m*i/24) [sqrt(rho*rho - x*x) + R - rho, Lc + x]])
    concat([[0, 0], [R - 0.7, 0], [R, 0.7],                 // base + chanfro
            [R, 3.5], [R - 0.4, 3.9],                       // cinta traseira -> rebaixo
            [R - 0.4, Lc - 3.9], [R, Lc - 3.5]],            // rebaixo -> cinta dianteira
           ogiva, [[0, Lc + x_m]]);
module projetil() rotate_extrude($fn = 72) polygon(perfil_projetil());

// Projetil em 4 PARTES para imprimir em 2 cores e colar (de baixo para cima):
//   corpo (cor principal) | anel na base da ogiva (cor 2) | meio da ogiva (cor principal) | ponta (cor 2)
// Encaixes de centragem para a cola: o pino do corpo atravessa o anel e entra no meio;
// o meio tem um pino menor que entra na ponta. Folga de 0,35 mm no diametro (cabe a cola).
z_anel_p  = L_corpo_proj;            // base da ogiva
z_meio_p  = L_corpo_proj + 2;        // anel de 2 mm
z_ponta_p = L_corpo_proj + 5.5;      // meio de 3,5 mm; a ponta vai ate o fim (~3 mm)
d_pino_p1 = 5;   d_pino_p2 = 3;   folga_cola = 0.35;
module fatia_projetil(z0, z1) rotate_extrude($fn = 72) intersection() {
    polygon(perfil_projetil());
    translate([0, z0]) square([10, z1 - z0]);
}
module projetil_corpo() {
    fatia_projetil(0, z_anel_p);
    translate([0, 0, z_anel_p - 0.01]) cylinder(d = d_pino_p1, h = z_meio_p - z_anel_p + 1.5, $fn = 32);
}
module projetil_anel() difference() {
    fatia_projetil(z_anel_p, z_meio_p);
    translate([0, 0, z_anel_p - 1]) cylinder(d = d_pino_p1 + folga_cola, h = 5, $fn = 32);
}
module projetil_meio() difference() {
    union() {
        fatia_projetil(z_meio_p, z_ponta_p);
        translate([0, 0, z_ponta_p - 0.01]) cylinder(d = d_pino_p2, h = 1.2, $fn = 24);
    }
    translate([0, 0, z_meio_p - 1]) cylinder(d = d_pino_p1 + folga_cola, h = 1 + 1.6, $fn = 32);
}
module projetil_ponta() difference() {
    fatia_projetil(z_ponta_p, 40);
    translate([0, 0, z_ponta_p - 1]) cylinder(d = d_pino_p2 + folga_cola, h = 1 + 1.3, $fn = 24);
}
module projetil_colorido(c1 = "Goldenrod", c2 = "Firebrick") {
    color(c1) projetil_corpo();
    color(c2) projetil_anel();
    color(c1) projetil_meio();
    color(c2) projetil_ponta();
}
L_proj = L_corpo_proj + L_ogiva_proj;

// ---- PORTA-MUNICAO: bandeja com n_proj projeteis em pe (fica ao lado do canhao)
module porta_projeteis() {
    nx = ceil(n_proj/2); passo = d_proj_e + 5;
    difference() {
        translate([-passo/2, -passo/2, 0]) cube([nx*passo, 2*passo, 10]);
        for (i = [0:n_proj-1]) translate([(i % nx)*passo, floor(i/nx)*passo, 3])
            cylinder(d = d_proj_e + 0.6, h = 10);
        translate([nx*passo/2 - passo/2, -passo/2 + 0.6, 5]) rotate([90, 0, 0]) linear_extrude(1, convexity = 6)
            text("MUNICAO", size = 4, font = fonte, halign = "center", valign = "center", $fn = 24);
    }
}
module porta_montado() {
    nx = ceil(n_proj/2); passo = d_proj_e + 5;
    color("DarkOliveGreen") porta_projeteis();
    for (i = [0:n_proj-1]) translate([(i % nx)*passo, floor(i/nx)*passo, 3]) projetil_colorido();
}

// ---- PINO do gatilho (Ø4, com trava "E" por baixo da lingueta)
dc_4 = 3.0;
module pino_gatilho() {
    translate([x_piv_gat, y_piv_gat, 0]) difference() {
        union() {
            translate([0, 0, z_b + 13.3]) cylinder(d = 8, h = 1.6);
            translate([0, 0, z_b + 1 - 0.2 - g_canal - 2]) cylinder(d = 4, h = 13.3 - 1 + 0.2 + g_canal + 2 + 0.01);
        }
        translate([0, 0, z_b + 1 - 0.2 - g_canal]) canal(dc_4);
    }
}

// ---- BAIONETA (sem parafuso). Helpers no referencial do eixo do cano (Z local = X do cano).
module em_eixo() translate([0, 0, z_b]) rotate([0, 90, 0]) children();
module setor(r1, r2, a1, a2, z1, z2) rotate(a1) rotate_extrude(angle = a2 - a1, $fn = 120)
    translate([r1, z1]) square([r2 - r1, z2 - z1]);
// rasgo em "J" na parede (r1..r2), boca em z_boca, abrindo para o sentido sb (-1: boca atras)
module rasgo_j(r1, r2, z_boca, sb, ang0, giro, a_ent, a_trv1, a_trv2, a_ent_fim, entalhe = true) {
    rm = (r1 + r2)/2; d = 1.9/rm*180/PI;
    for (a = ang0) {
        setor(r1, r2, a - d, a + d, min(z_boca, z_boca - sb*a_ent_fim), max(z_boca, z_boca - sb*a_ent_fim));
        setor(r1, r2, a - d, a + giro + d, min(z_boca - sb*a_trv1, z_boca - sb*a_trv2), max(z_boca - sb*a_trv1, z_boca - sb*a_trv2));
        if (entalhe) setor(r1, r2, a + giro - d, a + giro + d, min(z_boca - sb*a_ent, z_boca - sb*a_trv2), max(z_boca - sb*a_ent, z_boca - sb*a_trv2));
    }
}
ang_baioneta = [90, 270];   // entradas nas laterais (o rasgo da quilha fica em cima)
giro_baioneta = 30;

// ---- SOQUETE (vareta para empurrar a bolinha cano abaixo, como nos canhoes antigos)
module soquete() {
    cylinder(d = d_alma - 2, h = 150);
    cylinder(d = 14, h = 3);
}

// ---- COROA de elevacao com escala gravada na face externa (origem na face interna)
//      Vazada: aro dentado e cubo com a espessura cheia, ligados por raios grossos
//      (dois deles nas bordas do setor e um sob cada ressalto de batente).
//      Entre eles fica so uma faixa fina, na face de fora, para os numeros da escala.
r_aro_el   = rf_el - 6.5;   // aro de 6,5 mm abaixo do pe do dente
r_cubo_el  = 14;
r_faixa_el = 39;            // faixa dos numeros: de r_faixa_el ate o aro
esp_faixa_el = 2.4;
esp_raio_el  = 4;   // espessura dos raios (o aro e o cubo ficam com h_roda_el)
raios_el   = [105, 147, 229];   // raios intermediarios (graus locais)
module contorno_roda_el() offset(r = 3) offset(delta = -3) union() {
    arco(0, rp_el + 5, setor_el[0], setor_el[1]);
    circle(r = r_cubo_el);
}
module raios_el_2d() {
    rotate(setor_el[0]) translate([0, -1]) square([r_aro_el + 1, 10]);   // bordas do setor
    rotate(setor_el[1]) translate([0, -9]) square([r_aro_el + 1, 10]);
    for (f = fases_batente()) rotate(f) translate([0, -4.5]) square([r_aro_el + 1, 9]);
    for (a = raios_el) rotate(a) translate([0, -4]) square([r_aro_el + 1, 8]);
}
module roda_el() {
    difference() {
        union() {
            difference() {
                intersection() {
                    // fase: um dente em 90 graus locais (aponta para a rosca quando el = 0)
                    rotate(90 - (360/z_el)*floor(90/(360/z_el))) engrenagem_helicoidal(m_el, z_el, h_roda_el, gama_el);
                    translate([0, 0, -1]) linear_extrude(h_roda_el + 2, convexity = 4) contorno_roda_el();
                }
                // tudo entre o cubo e o aro sai; ficam com espessura cheia so os apoios dos ressaltos
                translate([0, 0, -1]) linear_extrude(h_roda_el + 2, convexity = 10) difference() {
                    circle(r = r_aro_el, $fn = 180);
                    circle(r = r_cubo_el);
                    for (f = fases_batente()) arco(23, 37, f - 8, f + 8);
                }
            }
            // raios FINOS (esp_raio_el), rente a face externa, com cantos arredondados no aro e no cubo
            translate([0, 0, h_roda_el - esp_raio_el]) linear_extrude(esp_raio_el, convexity = 10)
                intersection() {
                    contorno_roda_el();
                    offset(r = -2) offset(delta = 2) union() {
                        raios_el_2d();
                        circle(r = r_cubo_el);
                        difference() { circle(r = rf_el - 0.5, $fn = 180); circle(r = r_aro_el, $fn = 180); }   // so para arredondar a raiz dos raios
                    }
                }
            // faixa fina dos numeros, rente a face externa (imprime direto na mesa)
            translate([0, 0, h_roda_el - esp_faixa_el]) linear_extrude(esp_faixa_el, convexity = 4)
                intersection() {
                    contorno_roda_el();
                    arco(r_faixa_el, r_aro_el + 0.5, raios_el[1], setor_el[1]);   // escala: de el_min+180 a el_max+180
                }
        }
        hex_furo(f_munhao, 3*h_roda_el);
        translate([0, 0, h_roda_el - prof_grav]) linear_extrude(1, convexity = 10) escala_el_2d();
    }
    // ressaltos de batente na face interna (encostam no batente da bochecha)
    for (phi = fases_batente()) translate([0, 0, -3.5]) linear_extrude(3.51) arco(26, 34, phi - 5, phi + 5);
}
// angulo local de cada ressalto: bate no bloco (centro 270, +-6 graus) em el_batente
function fases_batente() = [el_batente[1] + 5 - 264, el_batente[0] - 5 - 276];

// ---- Pino pivo (ou use parafuso M8)
module pino_pivo() {
    cylinder(d = 8, h = (h_mesa + espiga[2] - 3.3 - 0.5) + folga_mb + 13);   // a ponta fica 0,5 mm acima do fundo do furo da base
    cylinder(d = 14, h = 3);
}

// =====================================================================
//  MONTAGEM
// =====================================================================
az = ANIMAR ? 60*sin(360*$t) : AZIMUTE;
el = ANIMAR ? 35 + 35*sin(720*$t) : ELEVACAO;
rot_raz = -az*z_az + GIRO_MANIVELA_AZ;   // giro da rosca de azimute (graus)
rot_rel =  el*z_el + GIRO_MANIVELA_EL;   // giro da rosca de elevacao

// manivela + punho + travas ja posicionados (eixo da manivela = Z local)
module manivela_montada(R, zc) {
    color("Firebrick") manivela(R, zc);
    color("Black") translate([R, 0, 8.2]) punho();
}
module travas_eixo(zs) for (zc = zs) color("DeepSkyBlue") translate([0, 0, zc + 0.1]) trava(dc_6);

module acion_az(giro) {   // rosca, eixo e manivela de azimute (coords da base)
    translate([x_raz, 0, z_raz]) rotate([90, 0, 0]) {
        color("Goldenrod") rotate(giro) rosca(m_az, d_rosca_az, L_rosca_az);
        color("Silver") eixo_hex(f_eixo, az_z0, az_z1, [az_g1, az_g2, az_g3], dc_6);
        travas_eixo([az_g1, az_g2, az_g3]);
        translate([0, 0, y_man_az]) rotate(giro) manivela_montada(R_manivela_az, z_az);
    }
}

module acion_el(giro) {   // rosca, eixo e manivela de elevacao (coords do carro)
    translate([0, y_roda, z_rosca_el]) rotate([0, 90, 0]) {
        color("Goldenrod") rotate(giro) rosca(m_el, d_rosca_el, L_rosca_el);
        color("Silver") eixo_hex(f_eixo, el_z0, el_z1, [el_g1, el_g2, el_g3], dc_6);
        travas_eixo([el_g1, el_g2, el_g3]);
    }
    translate([-x_man_el, y_roda, z_rosca_el]) rotate([0, -90, 0]) rotate(-giro)
        manivela_montada(R_manivela_el, z_el);
}

module conjunto_elevacao() {  // tudo que gira com o cano (origem no munhao)
    rotate([0, -el, 0]) {
        color("SaddleBrown") culatra();
        color("Peru") translate([-p_arm_vis, 0, 0]) pistao();
        color("DimGray") cano();
        color("SaddleBrown") tampa();
        color("Black") amortecedor();
        color("Firebrick") gatilho();
        color("Silver") pino_gatilho();
        color("DeepSkyBlue") translate([x_piv_gat, y_piv_gat, z_b + 1 - 0.2 - g_canal + 0.1]) trava(dc_4);
        // pinhao + coroa de armar (giram juntos no mesmo eixo)
        translate([x_g, 0, z_g]) rotate([0, th_arm, 0]) rotate([90, 0, 0]) {
            color("Goldenrod") pinhao_armar();
            color("Gold") translate([0, 0, -y_ra]) coroa_armar();
        }
        translate([x_g, 0, z_g]) rotate([-90, 0, 0]) {
            color("Silver") eixo_hex(f_eixo, pi_z0, pi_z1, [pi_g2, pi_g1], dc_6);
            travas_eixo([pi_g2, pi_g1]);
        }
        // rosca de armar + manivela (atras, eixo paralelo ao cano)
        translate([x_g, y_ra, z_ra_eixo]) rotate([0, 90, 0]) {
            color("Goldenrod") rotate(180 + th_arm*z_ra) rosca(m_ra, d_rosca_ra, L_rosca_ra);
            color("Silver") eixo_hex(f_eixo, ra_z0, ra_z1, [ra_g1, ra_g2, ra_g3], dc_6);
            travas_eixo([ra_g1, ra_g2, ra_g3]);
        }
        translate([x_g - x_man_ra, y_ra, z_ra_eixo]) rotate([0, -90, 0]) rotate(-th_arm*z_ra)
            { color("Firebrick") volante_armar(); color("Black") translate([8.5, 0, h_cubo + 0.2]) punho(d_pino_ra, d_punho_ra, L_punho_ra); }
        // coroa de elevacao + munhao
        color("Goldenrod") translate([0, y_roda - h_roda_el/2, 0]) rotate([-90, 0, 0]) roda_el();
        rotate([-90, 0, 0]) {
            color("Silver") eixo_hex(f_munhao, mu_z0, mu_z1, [mu_g1, mu_g2], dc_8);
            for (zc = [mu_g1, mu_g2]) color("DeepSkyBlue") translate([0, 0, zc + 0.1]) trava(dc_8);
        }
    }
}

module montagem() {
    color("DarkOliveGreen") base();
    // 10 projeteis guardados nas cartucheiras da base
    for (a = angs_sup) pos_sup(a) projetil_colorido();
    color("Peru") translate([0, 0, z_esf]) { anel_externo_baixo(); anel_externo_cima(); }
    if (MOSTRAR_ESFERAS) color("Gold")
        translate([0, 0, z_esf]) esferas();

    acion_az(rot_raz);
    color("Red") translate([-r_furo_pont, 0, z_topo_pilar]) ponteiro(1.5, c_pont_az);   // ponteiro de azimute (encaixa no pilar)

    // tudo que gira com a mesa
    rotate([0, 0, az]) {
        color("OliveDrab") translate([0, 0, z_mesa]) mesa();
        color("DarkKhaki") translate([0, 0, z_deck]) carro();
        color("SandyBrown") translate([0, 0, z_esf]) anel_interno();
        color("Silver") translate([0, 0, z_deck + espiga[2]]) rotate([180, 0, 0]) pino_pivo();
        translate([0, 0, z_deck]) {
            acion_el(rot_rel);
            color("Red") translate([x_pont_el, y_boch_out, H_t]) rotate([-90, 0, 0])
                ponteiro(h_pont_el, c_pont_el);
            translate([0, 0, H_t]) conjunto_elevacao();
        }
    }
}

// =====================================================================
//  SAIDA (pecas ja na orientacao de impressao)
// =====================================================================
if      (PARTE == "montagem")    montagem();
else if (PARTE == "base")        base();
else if (PARTE == "mesa")        mesa();
else if (PARTE == "culatra")     translate([0, 0, x_soq + 10]) rotate([0, 90, 0]) culatra();   // frente para baixo
else if (PARTE == "pistao")      translate([0, 0, -(x_g - 4)]) rotate([0, -90, 0]) pistao();
else if (PARTE == "pinhao_armar") translate([0, 0, 3]) pinhao_armar();
else if (PARTE == "coroa_armar") translate([0, 0, 3]) coroa_armar();
else if (PARTE == "rosca_armar") translate([0, 0, L_rosca_ra/2]) rosca(m_ra, d_rosca_ra, L_rosca_ra);
else if (PARTE == "volante_armar") volante_armar();
else if (PARTE == "gatilho")     translate([0, 0, -(z_b + 1)]) gatilho();
else if (PARTE == "tampa")       translate([0, 0, -(x_tr - 3)]) rotate([0, -90, 0]) translate([0, 0, -z_b]) tampa();
else if (PARTE == "amortecedor") translate([0, 0, -x_s]) rotate([0, -90, 0]) translate([0, 0, -z_b]) amortecedor();
else if (PARTE == "soquete")     soquete();
else if (PARTE == "projetil")    projetil();
else if (PARTE == "projetil_corpo") projetil_corpo();
else if (PARTE == "projetil_anel")  translate([0, 0, -z_anel_p]) projetil_anel();
else if (PARTE == "projetil_meio")  translate([0, 0, -z_meio_p]) projetil_meio();
else if (PARTE == "projetil_ponta") translate([0, 0, -z_ponta_p]) projetil_ponta();
else if (PARTE == "carro")       carro();
else if (PARTE == "porta_projeteis") porta_projeteis();
else if (PARTE == "eixo_pinhao") translate([0, 0, f_eixo/2]) rotate([90, 0, 0]) eixo_hex(f_eixo, pi_z0, pi_z1, [pi_g2, pi_g1], dc_6);
else if (PARTE == "eixo_armar")  translate([0, 0, f_eixo/2]) rotate([90, 0, 0]) eixo_hex(f_eixo, ra_z0, ra_z1, [ra_g1, ra_g2, ra_g3], dc_6);
else if (PARTE == "cano")        translate([0, 0, x_soq + 10 + L_cano]) rotate([0, 90, 0]) translate([0, 0, -z_b]) cano();
else if (PARTE == "roda_el")     translate([0, 0, h_roda_el]) rotate([180, 0, 0]) roda_el();   // escala para baixo, ressaltos para cima
else if (PARTE == "rosca_az")    translate([0, 0, L_rosca_az/2]) rosca(m_az, d_rosca_az, L_rosca_az);
else if (PARTE == "rosca_el")    translate([0, 0, L_rosca_el/2]) rosca(m_el, d_rosca_el, L_rosca_el);
else if (PARTE == "manivela_az") manivela(R_manivela_az, z_az);
else if (PARTE == "manivela_el") manivela(R_manivela_el, z_el);
else if (PARTE == "trava_6")     trava(dc_6);
else if (PARTE == "trava_8")     trava(dc_8);
else if (PARTE == "punho")       punho();
else if (PARTE == "punho_armar") punho(d_pino_ra, d_punho_ra, L_punho_ra);
else if (PARTE == "eixo_az")     translate([0, 0, f_eixo/2]) rotate([90, 0, 0])
                                     eixo_hex(f_eixo, az_z0, az_z1, [az_g1, az_g2, az_g3], dc_6);
else if (PARTE == "eixo_el")     translate([0, 0, f_eixo/2]) rotate([90, 0, 0])
                                     eixo_hex(f_eixo, el_z0, el_z1, [el_g1, el_g2, el_g3], dc_6);
else if (PARTE == "eixo_munhao") translate([0, 0, f_munhao/2]) rotate([90, 0, 0])
                                     eixo_hex(f_munhao, mu_z0, mu_z1, [mu_g1, mu_g2], dc_8);
else if (PARTE == "ponteiro_el") translate([0, 0, 2]) rotate([90, 0, 0]) ponteiro(h_pont_el, c_pont_el);
else if (PARTE == "ponteiro_az") translate([0, 0, 2]) rotate([90, 0, 0]) ponteiro(1.5, c_pont_az);
else if (PARTE == "pino_pivo")   pino_pivo();
else if (PARTE == "anel_interno")  translate([0, 0, h_rol/2]) anel_interno();                     // dentes para cima
else if (PARTE == "anel_externo_baixo") translate([0, 0, h_rol/2]) anel_externo_baixo();      // fundo plano na mesa da impressora
else if (PARTE == "anel_externo_cima")  translate([0, 0, h_rol/2]) rotate([180, 0, 0]) anel_externo_cima();   // topo na mesa: o flanco fica para cima
else if (PARTE == "pino_gatilho") translate([0, 0, z_b + 14.9]) rotate([180, 0, 0]) translate([-x_piv_gat, -y_piv_gat, 0]) pino_gatilho();
else if (PARTE == "trava_4")     trava(dc_4);
