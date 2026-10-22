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
PARTE = "montagem"; // [montagem, base, mesa, carro, culatra, tampa, amortecedor, pistao, cano, pinhao_armar, coroa_armar, rosca_armar, volante_armar, gatilho, soquete, projetil, porta_projeteis, eixo_pinhao, eixo_armar, roda_el, rosca_az, rosca_el, manivela_az, manivela_el, punho, trava_6, trava_8, eixo_az, eixo_el, eixo_munhao, ponteiro_az, ponteiro_el, pino_pivo]
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
folga_dente = 0.12;  // folga (backlash) nos dentes
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
m_az        = 1.5;  // modulo
z_az        = 90;   // dentes da coroa/mesa  -> reducao 90:1 (4 graus/volta)
h_mesa      = 12;   // espessura da mesa (largura do dente)
d_rosca_az  = 18;   // diametro primitivo da rosca
L_rosca_az  = 40;   // comprimento da rosca
R_manivela_az = 15; // raio da manivela (centro do punho)
y_ext_az    = 52;   // distancia da face interna do mancal externo ao centro da rosca

/* [Elevacao] */
m_el        = 1;
z_el        = 90;   // dentes da coroa de elevacao -> reducao 90:1 (4 graus/volta)
h_roda_el   = 10;
d_rosca_el  = 14;
L_rosca_el  = 34;
R_manivela_el = 15;
x_ext_el    = 32;   // distancia da face interna do mancal externo ao centro da rosca
el_min      = -10;  // faixa da escala gravada
el_max      = 80;
el_batente  = [-12, 82];  // batentes mecanicos (protegem dentes e culatra)

/* [Manivela] */
r_tambor  = 22;   // raio do tambor micrometrico
n_tambor  = 40;   // marcas no tambor (40 -> 0,1 grau por marca com 4 graus/volta)
L_punho   = 20;   // comprimento do punho giratorio
d_punho   = 14;
d_pino_p  = 8;    // pino do punho (oco: aceita parafuso M3 como alma de aco)

/* [Base e rolamento] */
r_base    = 80;   // raio ate onde a base fica na altura cheia (anel da pista + cubo)
// base em cruz: 4 pernas (uma e a da rosca/manivela de azimute, em +X)
r_perna   = 105;  // alcance das pernas (cabe numa mesa de impressao de 220 mm)
larg_perna = 10;  // nervura (a rigidez vem da altura)
d_sapata  = 26;  // sapata redonda na ponta de cada perna
h_ponta   = 10;   // altura na ponta das pernas
r_anel    = [51, 63];  // anel sob a pista das esferas (oco por dentro)
h_base    = 30;
R_pista   = 57;   // raio da pista das esferas
d_esfera  = 6;    // BB de airsoft 6 mm
prof_v    = 3.4;  // profundidade do canal em V (90 graus)
rol_608   = [22, 8, 7];  // rolamento central: ext, int, largura

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
n_proj       = 6;    // quantos aparecem no porta-municao da montagem

// =====================================================================
//  GRANDEZAS DERIVADAS (nao mexer)
// =====================================================================
rp_az    = m_az*z_az/2;
ra_az    = rp_az + m_az;
rf_az    = rp_az - 1.25*m_az;
ra_raz   = d_rosca_az/2 + m_az;            // raio externo da rosca az
x_raz    = rp_az + d_rosca_az/2;           // distancia entre eixos (az)
folga_v  = 2*(d_esfera/2*sqrt(2) - prof_v);// vao entre base e mesa
z_esf    = h_base + folga_v/2;             // centro das esferas
z_mesa   = h_base + folga_v;               // fundo da mesa
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

n_esferas = floor(2*PI*R_pista/(d_esfera + 0.4));

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

// ponteiros
r_pont_az = ra_az + 4.5;                   // furo do ponteiro na base
x_pont_el = -(ra_el + 4);                  // furo do ponteiro na bochecha
h_pont_az = z_deck + 0.8 + 1.5 - h_base;   // agulha 0,8 mm acima da mesa
c_pont_az = r_pont_az - (r_esc_az + 0.5);  // ponta logo alem das marcas
h_pont_el = y_roda + h_roda_el/2 + 0.5 + 1.5 - y_boch_out; // agulha 0,5 mm da face da coroa
c_pont_el = -x_pont_el - (r_esc_el + 0.5);

// placa do carro e furos de fixacao na mesa (M3 / auto-atarraxante)
placa_x = [-(x_ext_el + esp_mancal_ext + 2), 33];
placa_y = [-27, y_roda + 9];
furos_carro = [[-22,-23], [28,-23], [-8, y_roda + 5.5], [8, y_roda + 5.5]];

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
echo(str("=== esferas de ", d_esfera, " mm na pista: ate ", n_esferas, " (use ~", n_esferas-3, ")"));
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
module engrenagem_helicoidal(m, z, h, beta) {
    tw = h*tan(beta)/(m*z/2)*180/PI;
    rotate(tw/2)   // dente em 0 graus no plano medio (onde a rosca toca)
        linear_extrude(height = h, twist = tw, slices = max(4, ceil(abs(tw)*2)), convexity = 10)
            engrenagem2d(m, z);
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
            translate([R, 0, 0]) cylinder(d = d_pino_p, h = z_p + L_punho + 0.4 + g_canal + 2);
        }
        translate([0, 0, h_cubo/2]) hex_furo(f_eixo, h_cubo + 2);
        translate([R, 0, z_p + L_punho + 0.4]) canal(dc_8);
        translate([R, 0, -1]) cylinder(d = 3.2, h = 60, $fn = 16);   // alma opcional: parafuso M3
        // escala gravada na face externa do tambor
        translate([0, 0, 3 - prof_grav]) linear_extrude(1, convexity = 10) {
            for (i = [0:n-1]) let(a = i*360/n)
                rotate(a) translate([i % 10 == 0 ? rt - 5.5 : (i % 5 == 0 ? rt - 3.6 : rt - 2.2), -0.3])
                    square([6, 0.6]);
            for (k = [1:3]) rotate(90*k) translate([rt - 8, 0]) rotate(-90)
                text(str(k), size = 3, font = fonte, halign = "center", valign = "center", $fn = 32);
            rotate(225) {   // "1 VOLTA / = 4 graus" em duas linhas
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
module punho() {
    difference() {
        cylinder(d = d_punho, h = L_punho);
        translate([0, 0, -1]) cylinder(d = d_pino_p + 0.5, h = L_punho + 2);
        for (zz = [0, L_punho]) translate([0, 0, zz])   // chanfros
            cylinder(d1 = d_pino_p + 2.5, d2 = d_pino_p + 0.2, h = 1.2, center = true);
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

// Canal em V (90 graus) para as esferas, centrado no plano z=0
module canal_v() {
    rotate_extrude($fn = 180)
        translate([R_pista, 0]) rotate(45) square(prof_v*sqrt(2), center = true);
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

// Azimute: valor v fica no angulo local 180 - v (ponteiro esta em 180 graus)
module escala_az_2d() {
    re = r_esc_az;
    difference() { circle(r = re, $fn = 360); circle(r = re - 0.6, $fn = 360); }
    for (v = [0:5:355]) rotate(180 - v) {
        r0 = v % 10 == 0 ? re - 6.5 : re - 4;
        translate([r0, -0.4]) square([re - r0, 0.8]);
    }
    for (v = [2.5:5:357.5]) rotate(180 - v)
        translate([re - 2, 0]) circle(d = 1.3, $fn = 16);
    for (v = [0:10:350]) let(a = 180 - v)
        translate(polar(re - 9.5, a)) rotate(a + 90)
            text(str(v), size = 3.6, font = fonte, halign = "center", valign = "center", $fn = 40);
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

// ---- BASE fixa: pista das esferas, sede do 608, 3 mancais da rosca az
module perna(ang) {   // nervura do centro ate a ponta, baixando depois do anel, com sapata
    rotate(ang) difference() {
        union() {
            hull() {
                translate([0, -larg_perna/2, 0]) cube([r_anel[1] + 4, larg_perna, h_base]);
                translate([r_perna - d_sapata/2, -larg_perna/2, 0]) cube([1, larg_perna, h_ponta]);
            }
            translate([r_perna - d_sapata/2, 0, 0]) cylinder(d = d_sapata, h = 4);            // sapata
            translate([r_perna - d_sapata/2, 0, 0]) cylinder(d1 = d_sapata - 4, d2 = larg_perna, h = h_ponta - 2);
        }
        // rebaixo para pe de borracha adesivo (10 mm)
        translate([r_perna - d_sapata/2, 0, -0.01]) cylinder(d = 10.5, h = 1.2);
    }
}
module base() {
    difference() {
        union() {
            cylinder(r = 15, h = h_base);                                           // cubo do 608
            difference() { cylinder(r = r_anel[1], h = h_base, $fn = 180);           // anel da pista
                           translate([0, 0, -1]) cylinder(r = r_anel[0], h = h_base + 2, $fn = 180); }
            for (ang = [90, 180, 270]) perna(ang);
            // apoio do ponteiro de azimute (perna de tras na altura cheia ate o ponteiro)
            translate([-(r_pont_az + 4), -5, 0]) cube([r_pont_az + 4 - r_anel[1] + 2, 10, h_base]);
            // raios do cubo ao anel (nervuras de 10 mm em cruz + diagonais)
            for (ang = [45, 135, 225, 315]) rotate(ang) translate([0, -4, 0]) cube([r_anel[0] + 1, 8, h_base]);
            // perna +X: plataforma da rosca e da manivela de azimute
            translate([0, -5, 0]) cube([x_raz, 10, h_base]);
            translate([x_raz - 16, -(y_ext_az + esp_mancal_ext), 0])
                cube([16 + r_tambor + 7.5, y_ext_az + esp_mancal_ext + y_mancal_az + esp_mancal_az, h_base]);
            // mancais junto a rosca
            translate([x_raz, -y_mancal_az, z_raz]) rotate([90, 0, 0])
                mancal(z_raz - h_base, esp_mancal_az);
            translate([x_raz, y_mancal_az + esp_mancal_az, z_raz]) rotate([90, 0, 0])
                mancal(z_raz - h_base, esp_mancal_az);
            // mancal externo com a seta indice do tambor (para fora, +X)
            translate([x_raz, -y_ext_az, z_raz]) rotate([90, 0, 0])
                mancal(z_raz - h_base, esp_mancal_ext, 0, true);
        }
        translate([0, 0, h_base]) canal_v();
        // sede do rolamento 608 + alivio para a ponta do pino
        translate([0, 0, h_base - rol_608[2] - 0.2]) cylinder(d = rol_608[0] + 0.2, h = 10);
        translate([0, 0, h_base - rol_608[2] - 6]) cylinder(d = 12, h = 7);
        // anel oco: paredes de 2 mm e teto em V a 45 graus, deixando 8 mm de material sob a pista
        rotate_extrude($fn = 120) polygon([[r_anel[0] + 2, -0.01], [r_anel[1] - 2, -0.01],
            [r_anel[1] - 2, h_base - 12], [(r_anel[0] + r_anel[1])/2, h_base - 8], [r_anel[0] + 2, h_base - 12]]);
        // canais de alivio por baixo da plataforma (teto em V a 45 graus)
        translate([x_raz + 5, -(y_ext_az + esp_mancal_ext) + 14, 0]) rotate([-90, 0, 0])
            linear_extrude(y_ext_az + esp_mancal_ext + y_mancal_az + esp_mancal_az - 28)
                polygon([[-17, 0.01], [17, 0.01], [0, -17]]);   // cumeeira 9 mm abaixo da calha da rosca
        // calha de folga sob a rosca
        translate([x_raz, 0, z_raz]) rotate([90, 0, 0])
            cylinder(r = ra_raz + 1, h = 2*y_mancal_az, center = true);
        // furo do ponteiro de azimute (na perna de tras)
        translate([-r_pont_az, 0, h_base]) furo_ponteiro(8);
        // pes de borracha sob a plataforma da manivela
        for (p = [[x_raz + r_tambor + 2, -(y_ext_az + esp_mancal_ext) + 7], [x_raz + r_tambor + 2, y_mancal_az + esp_mancal_az - 7]])
            translate([p[0], p[1], -0.01]) cylinder(d = 10.5, h = 1.2);
    }
}

// ---- MESA giratoria = coroa grande de azimute (origem no fundo)
module mesa() {
    difference() {
        engrenagem_helicoidal(m_az, z_az, h_mesa, gama_az);
        canal_v();                                         // pista de baixo
        translate([0, 0, -1]) cylinder(d = rol_608[1] + 0.3, h = h_mesa + 2);
        translate([0, 0, h_mesa - 3]) cylinder(d = 14.5, h = 4);
        for (p = furos_carro) translate([p[0], p[1], h_mesa - 10]) cylinder(d = 2.8, h = 11);
        translate([0, 0, h_mesa - prof_grav]) linear_extrude(1, convexity = 10) escala_az_2d();
        // janelas de alivio entre o cubo e a pista: 6 raios de 8 mm + ressaltos nos parafusos
        translate([0, 0, -1]) linear_extrude(h_mesa + 2, convexity = 8) offset(r = 2) offset(delta = -2) difference() {
            difference() { circle(r = 46, $fn = 120); circle(r = 17); }
            for (i = [0:5]) rotate(i*60 + 30) translate([0, -4]) square([50, 8]);
            for (p = furos_carro) translate(p) circle(r = 6);
        }
    }
}

// ---- CARRO: placa + bochechas + 3 mancais da rosca de elevacao (origem no topo da mesa)
module perfil_bochecha(com_braco) {
    hull() {
        translate([-20, 0]) square([50, h_placa]);
        translate([0, H_t]) circle(r = 16);
    }
    if (com_braco)  // braco inclinado (>45 graus, imprime sem suporte) que segura o ponteiro
        polygon([[-17, H_t - 52], [x_pont_el + 3, H_t - 5], [x_pont_el - 4, H_t - 5],
                 [x_pont_el - 4, H_t + 5], [-6, H_t + 14]]);
}

module carro() {
    difference() {
        union() {
            translate([placa_x[0], placa_y[0], 0])
                cube([placa_x[1] - placa_x[0], placa_y[1] - placa_y[0], h_placa]);
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
                    mancal(z_rosca_el - h_placa, esp_mancal_el, larg = 14);
                translate([xm - esp_mancal_el, y_boch_out - 0.5, 0])
                    cube([esp_mancal_el, y_roda - y_boch_out, z_rosca_el - 4]);
            }
            // mancal externo (manivela atras, -X) com seta indice para baixo
            translate([-x_ext_el, y_roda, z_rosca_el]) rotate([90, 0, -90])
                mancal(z_rosca_el - h_placa, esp_mancal_ext, -90, true, larg = 14);
        }
        translate([0, 0, H_t]) rotate([90, 0, 0]) furo_redondo_p_hex(f_munhao, 120);
        for (p = furos_carro) translate([p[0], p[1], 0]) {
            translate([0, 0, -1]) cylinder(d = 3.4, h = h_placa + 2);
            translate([0, 0, h_placa - 2.5]) cylinder(d = 6.5, h = 3);
        }
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
            // orelha do gatilho (so por cima; 6 mm de rosca para o M3 auto-atarraxante)
            translate([0, 0, z_b + 7.3]) linear_extrude(6) hull() {
                translate([x_piv_gat, y_piv_gat]) circle(r = 4.5);
                translate([x_piv_gat - 6, -5]) square([12, 1]);
            }
        }
        rotate([90, 0, 0]) hex_furo(f_munhao, larg_berco + 2);
        // furo do cilindro (aberto atras) + degrau + soquete do cano
        translate([x_tr - 1, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_cil_i, h = x_degrau - x_tr + 1);
        translate([x_degrau - 1, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_degrau, h = 10);
        translate([x_soq, 0, z_b]) rotate([0, 90, 0]) cylinder(d = 20 + folga, h = 11);
        // rasgo da quilha: aberto atras (o pistao entra por tras), fechado na frente
        translate([x_tr - 1, -2.7, z_b]) cube([x_fim_crem + 1.5 - x_tr + 1, 5.4, r_e + 1]);   // quilha 5 + 0,2/lado
        // janela do dente do gatilho (lado esquerdo, um pouco acima do centro)
        translate([x_s - p_trava - 0.5, -r_e - 1, z_b + 0.5]) cube([6, r_e + 1 - d_cil_i/2 + 1, 7]);
        translate([x_piv_gat, y_piv_gat, z_b + 7.3 - 0.01]) cylinder(d = 2.6, h = 7);     // M3 do gatilho
        translate([x_soq + 5, 0, z_b - 15]) cylinder(d = 3.4, h = 10);                    // M3 do cano
        for (a = [-90, 0]) translate([x_tr + 3, 0, z_b]) rotate([a, 0, 0])               // M3 da tampa
            translate([0, 0, -r_e - 1]) cylinder(d = 3.4, h = 4);
    }
}

// ---- TAMPA traseira: espigao + guia da mola (presa por 2 M3 radiais)
module tampa() {
    difference() {
        union() {
            translate([x_tr - 3, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_cil_e, h = 3);
            translate([x_tr - 0.01, 0, z_b]) rotate([0, 90, 0]) cylinder(d = d_cil_i - folga, h = x_tampa - x_tr + 0.01);
            translate([x_tampa - 0.01, 0, z_b]) rotate([0, 90, 0]) cylinder(d1 = mola_d - 2.5, d2 = mola_d - 3.5, h = 25);
            // ressalto que entra no rasgo da quilha (trava o giro da tampa)
            translate([x_tr - 0.01, -2.5, z_b + d_cil_i/2 - 1]) cube([x_tampa - x_tr, 5, d_cil_e/2 - d_cil_i/2 + 1]);
        }
        for (a = [-90, 0]) translate([x_tr + 3, 0, z_b]) rotate([a, 0, 0])
            translate([0, 0, -d_cil_i/2 - 1]) cylinder(d = 2.6, h = 8);
    }
}

// ---- AMORTECEDOR (anel entre o pistao e o degrau; ideal em TPU)
module amortecedor() {
    translate([x_s, 0, z_b]) rotate([0, 90, 0]) difference() {
        cylinder(d = d_cil_i - 0.3, h = x_degrau - x_s);
        translate([0, 0, -1]) cylinder(d = d_degrau + 0.4, h = 10);
    }
}

// ---- CANO (espiga de Ø20 no soquete da culatra, preso por 1 M3; nao leva a pancada do pistao)
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
        translate([x0 + 5, 0, z_b - 11]) cylinder(d = 2.6, h = 6);
    }
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
            translate([8.5, 0, 0]) cylinder(d = 6, h = 8 + 12);            // pino para girar com o dedo
            translate([8.5, 0, 8 + 12]) sphere(d = 6, $fn = 16);
        }
        translate([0, 0, h_cubo/2]) hex_furo(f_eixo, h_cubo + 2);
        translate([0, 0, 8 - prof_grav]) linear_extrude(1, convexity = 6)  // seta do sentido de armar
            rotate(200) translate([-1.5, -9.5]) polygon([[0, 0], [3, 0], [3, 4], [5, 4], [1.5, 7], [-2, 4], [0, 4]]);
    }
}

// ---- GATILHO: lingueta que gira num parafuso M3 vertical (desenhada armada)
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
        translate([P[0], P[1], 0]) cylinder(d = 3.4, h = 100);
    }
}

// ---- PROJETIL (estilo granada de morteiro): cilindro curto + ogiva tangente.
//      Duas cintas de guia (frente e tras) com 0,15 mm de folga por lado; o meio e
//      rebaixado 0,4 mm, so as cintas tocam o cano: desliza leve e nao balanca.
//      Base plana (o pistao empurra) com chanfro para entrar no funil do cano.
d_proj_e = d_alma - folga_proj;
module projetil() {
    R   = d_proj_e/2;
    Lc  = L_corpo_proj;
    Ln  = L_ogiva_proj;
    rho = (R*R + Ln*Ln)/(2*R);                    // raio da ogiva tangente
    r_m = 1.0;                                    // ponta achatada (meplat)
    x_m = sqrt(rho*rho - pow(rho - R + r_m, 2));  // onde a ogiva chega ao meplat
    ogiva = [for (i = [0:24]) let(x = x_m*i/24) [sqrt(rho*rho - x*x) + R - rho, Lc + x]];
    rotate_extrude($fn = 72) polygon(concat(
        [[0, 0], [R - 0.7, 0], [R, 0.7],                 // base + chanfro
         [R, 3.5], [R - 0.4, 3.9],                       // cinta traseira -> rebaixo
         [R - 0.4, Lc - 3.9], [R, Lc - 3.5]],            // rebaixo -> cinta dianteira
        ogiva, [[0, Lc + x_m]]));
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
    for (i = [0:n_proj-1]) translate([(i % nx)*passo, floor(i/nx)*passo, 3]) color("Goldenrod") projetil();
}

// ---- SOQUETE (vareta para empurrar a bolinha cano abaixo, como nos canhoes antigos)
module soquete() {
    cylinder(d = d_alma - 2, h = 150);
    cylinder(d = 14, h = 3);
}

// ---- COROA de elevacao com escala gravada na face externa (origem na face interna)
module roda_el() {
    difference() {
        // fase: um dente em 90 graus locais (aponta para a rosca quando el = 0)
        rotate(90 - (360/z_el)*floor(90/(360/z_el))) engrenagem_helicoidal(m_el, z_el, h_roda_el, gama_el);
        hex_furo(f_munhao, 3*h_roda_el);
        for (i = [0:5]) rotate(i*60 + 30) translate([18, 0, -1]) cylinder(d = 10, h = h_roda_el + 2);
        translate([0, 0, h_roda_el - prof_grav]) linear_extrude(1, convexity = 10) escala_el_2d();
    }
    // ressaltos de batente na face interna (encostam no batente da bochecha)
    for (phi = fases_batente()) translate([0, 0, -3.5]) linear_extrude(3.51) arco(26, 34, phi - 5, phi + 5);
}
// angulo local de cada ressalto: bate no bloco (centro 270, +-6 graus) em el_batente
function fases_batente() = [el_batente[1] + 5 - 264, el_batente[0] - 5 - 276];

// ---- Pino pivo (ou use parafuso M8)
module pino_pivo() {
    cylinder(d = rol_608[1] - 0.1, h = (h_mesa - 3) + folga_v + rol_608[2] + 3);
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
    color("DeepSkyBlue") translate([R, 0, 8 + L_punho + 0.4 + 0.1]) trava(dc_8);
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
            color("Firebrick") volante_armar();
        // coroa de elevacao + munhao
        color("Goldenrod") translate([0, y_roda - h_roda_el/2, 0]) rotate([-90, 0, 0]) roda_el();
        rotate([-90, 0, 0]) {
            color("Silver") eixo_hex(f_munhao, mu_z0, mu_z1, [mu_g1, mu_g2], dc_8);
            for (zc = [mu_g1, mu_g2]) color("DeepSkyBlue") translate([0, 0, zc + 0.1]) trava(dc_8);
        }
    }
}

module montagem() {
    // porta-municao ao lado do canhao (alem da perna -Y)
    translate([-20, -(r_perna + 30), 0]) porta_montado();
    color("DarkOliveGreen") base();
    color("Silver") translate([0, 0, h_base - rol_608[2]]) difference() {
        cylinder(d = rol_608[0], h = rol_608[2]);
        translate([0, 0, -1]) cylinder(d = rol_608[1], h = rol_608[2] + 2);
    }
    if (MOSTRAR_ESFERAS) color("Gold")
        for (i = [0:n_esferas-4]) rotate(i*360/(n_esferas-3))
            translate([R_pista, 0, z_esf]) sphere(d = d_esfera, $fn = 16);

    acion_az(rot_raz);
    color("Red") translate([-r_pont_az, 0, h_base]) ponteiro(h_pont_az, c_pont_az);

    // tudo que gira com a mesa
    rotate([0, 0, az]) {
        color("OliveDrab") translate([0, 0, z_mesa]) mesa();
        color("Silver") translate([0, 0, z_deck]) rotate([180, 0, 0]) pino_pivo();
        translate([0, 0, z_deck]) {
            color("DarkKhaki") carro();
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
else if (PARTE == "carro")       carro();
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
else if (PARTE == "eixo_az")     translate([0, 0, f_eixo/2]) rotate([90, 0, 0])
                                     eixo_hex(f_eixo, az_z0, az_z1, [az_g1, az_g2, az_g3], dc_6);
else if (PARTE == "eixo_el")     translate([0, 0, f_eixo/2]) rotate([90, 0, 0])
                                     eixo_hex(f_eixo, el_z0, el_z1, [el_g1, el_g2, el_g3], dc_6);
else if (PARTE == "eixo_munhao") translate([0, 0, f_munhao/2]) rotate([90, 0, 0])
                                     eixo_hex(f_munhao, mu_z0, mu_z1, [mu_g1, mu_g2], dc_8);
else if (PARTE == "ponteiro_az") translate([0, 0, 2]) rotate([90, 0, 0]) ponteiro(h_pont_az, c_pont_az);
else if (PARTE == "ponteiro_el") translate([0, 0, 2]) rotate([90, 0, 0]) ponteiro(h_pont_el, c_pont_el);
else if (PARTE == "pino_pivo")   pino_pivo();
