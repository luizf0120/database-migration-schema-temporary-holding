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
PARTE = "montagem"; // [montagem, base, mesa, carro, berco, cano, roda_el, rosca_az, rosca_el, manivela_az, manivela_el, punho, eixo_az, eixo_el, eixo_munhao, ponteiro_az, ponteiro_el, pino_pivo]
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
folga       = 0.3;   // folga de impressao em furos/encaixes
folga_dente = 0.15;  // folga (backlash) nos dentes
pa          = 20;    // angulo de pressao dos dentes (graus)
fonte       = "Liberation Sans:style=Bold";
prof_grav   = 0.6;   // profundidade da gravacao das escalas
$fn = 48;

/* [Eixos sextavados] */
// Chave Allen 6 mm serve como eixo das roscas!
f_eixo   = 6;    // eixos das roscas/manivelas (medida entre faces)
f_munhao = 8;    // eixo do munhao (chave Allen 8 mm serve)
d_pino   = 2.0;  // furos transversais p/ pino de filamento 1,75 mm

/* [Azimute] */
m_az        = 1.5;  // modulo
z_az        = 100;  // dentes da coroa/mesa  -> reducao 100:1
h_mesa      = 12;   // espessura da mesa (largura do dente)
d_rosca_az  = 18;   // diametro primitivo da rosca
L_rosca_az  = 40;   // comprimento da rosca
R_manivela_az = 18; // raio da manivela (centro do punho)
y_ext_az    = 50;   // distancia da face interna do mancal externo ao centro da rosca

/* [Elevacao] */
m_el        = 1;
z_el        = 100;  // dentes da coroa de elevacao -> reducao 100:1
h_roda_el   = 10;
d_rosca_el  = 14;
L_rosca_el  = 34;
R_manivela_el = 18;
x_ext_el    = 38;   // distancia da face interna do mancal externo ao centro da rosca
el_min      = -10;  // faixa da escala gravada
el_max      = 80;

/* [Manivela] */
r_tambor  = 17;   // raio do tambor micrometrico
n_tambor  = 36;   // marcas no tambor (36 -> 0,1 graus por marca com 3,6 graus/volta)
L_punho   = 20;   // comprimento do punho giratorio
d_punho   = 12;

/* [Base e rolamento] */
r_base    = 86;
h_base    = 30;
R_pista   = 60;   // raio da pista das esferas
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
y_mancal_az = L_rosca_az/2 + 1;            // face interna dos mancais az

rp_el    = m_el*z_el/2;
ra_el    = rp_el + m_el;
rf_el    = rp_el - 1.25*m_el;
ra_rel   = d_rosca_el/2 + m_el;
a_el     = rp_el + d_rosca_el/2;           // distancia entre eixos (el)
H_t      = z_rosca_el + a_el;              // altura do munhao sobre a mesa
y_boch_in  = larg_berco/2 + 1;
y_boch_out = y_boch_in + esp_bochecha;
y_roda   = y_boch_out + ra_rel + 1.5;      // plano medio da coroa de elevacao
x_mancal_el = L_rosca_el/2 + 1;

gama_az  = atan(m_az/d_rosca_az);          // angulo de avanco das roscas
gama_el  = atan(m_el/d_rosca_el);

n_esferas = floor(2*PI*R_pista/(d_esfera + 0.4));

// manivela: face do tambor encosta a 1 mm do mancal externo
z_pino_man = 9;          // furo do pino no cubo (a partir da face do tambor)
h_cubo     = 12;
y_man_az = y_ext_az + esp_mancal_ext + 1;  // face do tambor (lado -Y)
x_man_el = x_ext_el + esp_mancal_ext + 1;  // face do tambor (lado -X)

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
L_eixo_az = (y_mancal_az + esp_mancal_az + 4.5) + (y_man_az + h_cubo);
L_eixo_el = (x_mancal_el + esp_mancal_el + 4.5) + (x_man_el + h_cubo);
L_munhao  = (y_boch_out + 4.5) + (y_roda + h_roda_el/2 + 4.5);

echo(str("=== AZIMUTE : reducao ", z_az, ":1  ->  ", 360/z_az, " graus por volta da manivela, ",
         360/z_az/n_tambor, " graus por marca do tambor"));
echo(str("=== ELEVACAO: reducao ", z_el, ":1  ->  ", 360/z_el, " graus por volta da manivela, ",
         360/z_el/n_tambor, " graus por marca do tambor"));
echo(str("=== coroa az D", 2*ra_az, " mm, coroa el D", 2*ra_el, " mm, munhao a ", H_t, " mm da mesa"));
echo(str("=== angulo de avanco az = ", gama_az, " graus, el = ", gama_el,
         " graus  (autotravante se tan(gama) < mu~0,3 -> ", tan(max(gama_az,gama_el)) < 0.3 ? "SIM" : "NAO", ")"));
echo(str("=== esferas de ", d_esfera, " mm na pista: ate ", n_esferas, " (use ~", n_esferas-3, ")"));
echo(str("=== eixo az = ", L_eixo_az, " mm, eixo el = ", L_eixo_el, " mm, munhao = ", L_munhao, " mm"));

// =====================================================================
//  ENGRENAGENS
// =====================================================================
function polar(r, a) = [r*cos(a), r*sin(a)];
function inv_graus(a) = (tan(a) - a*PI/180)*180/PI;   // funcao involuta

// Perfil 2D de engrenagem de evolvente (transversal)
module engrenagem2d(m, z) {
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
        circle(r = rf, $fn = z*4);
        for (k = [0:z-1]) rotate(k*360/z) polygon(dente);
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
    cylinder(d = f/cos(30) + 0.6, h = h, center = true);
}

// Eixo sextavado ao longo de Z (0..L) com furos para pino de filamento
module eixo_hex(f, L, furos) {
    difference() {
        cylinder(d = f/cos(30), h = L, $fn = 6);
        for (zf = furos) translate([0, 0, zf]) rotate([90, 0, 0])
            cylinder(d = d_pino, h = f + 2, center = true, $fn = 16);
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
        if (seta) translate([0, 0, esp - 0.8]) linear_extrude(1) rotate(ang_ind)
            polygon([[r_tambor + 1.3, 0], [r_tambor + 5.5, -2.4], [r_tambor + 5.5, 2.4]]);
    }
}

// Manivela (local: face do tambor em z=0, voltada para o mancal externo)
//  - tambor micrometrico com n marcas (a cada 5 marcas um traco longo);
//    o proprio braco marca o "zero"
//  - cubo sextavado travado por pino de filamento que atravessa cubo + eixo
//  - pino para o punho giratorio (peca "punho"), travado por outro pino
module manivela(R, n = n_tambor) {
    difference() {
        union() {
            cylinder(r = r_tambor, h = 3);
            cylinder(r = 7, h = h_cubo);
            hull() {
                cylinder(r = 7, h = 6);
                translate([R, 0, 0]) cylinder(r = 5.5, h = 6);
            }
            translate([R, 0, 0]) cylinder(d = 6, h = 6 + L_punho + 4.5);
        }
        translate([0, 0, 6]) hex_furo(f_eixo, 2*h_cubo);
        translate([0, 0, z_pino_man]) rotate([90, 0, 0])
            cylinder(d = d_pino, h = 20, center = true, $fn = 16);
        translate([R, 0, 6 + L_punho + 2]) rotate([90, 0, 0])
            cylinder(d = d_pino, h = 8, center = true, $fn = 16);
        // marcas do tambor (fora da regiao coberta pelo braco)
        for (i = [0:n-1]) let(a = i*360/n)
            if (abs(a - 360*round(a/360)) > 20)
                rotate(a) translate([r_tambor - (i % 5 == 0 ? 2.4 : 1.3), -0.4, -1])
                    cube([3, 0.8, 5]);
        // traco de referencia no braco
        translate([7.5, -0.4, 6 - 0.6]) cube([R - 12, 0.8, 1]);
    }
}

// Punho giratorio (desliza no pino da manivela)
module punho() {
    difference() {
        cylinder(d = d_punho, h = L_punho - 0.4);
        translate([0, 0, -1]) cylinder(d = 6 + 0.6, h = L_punho + 2);
        for (zz = [0, L_punho - 0.4]) translate([0, 0, zz])   // chanfros
            cylinder(d1 = 8.5, d2 = 6.2, h = 1.2, center = true);
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
    translate([-1.65, -1.65, -prof]) cube([3.3, 3.3, prof + 1]);
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
module base() {
    difference() {
        union() {
            cylinder(r = r_base, h = h_base, $fn = 180);
            translate([x_raz - 16, -(y_ext_az + esp_mancal_ext), 0])
                cube([32, y_ext_az + esp_mancal_ext + y_mancal_az + esp_mancal_az, h_base]);
            // mancais junto a rosca
            translate([x_raz, -y_mancal_az, z_raz]) rotate([90, 0, 0])
                mancal(z_raz - h_base, esp_mancal_az);
            translate([x_raz, y_mancal_az + esp_mancal_az, z_raz]) rotate([90, 0, 0])
                mancal(z_raz - h_base, esp_mancal_az);
            // mancal externo com a seta indice do tambor (para cima)
            translate([x_raz, -y_ext_az, z_raz]) rotate([90, 0, 0])
                mancal(z_raz - h_base, esp_mancal_ext, 90, true);
        }
        translate([0, 0, h_base]) canal_v();
        // sede do rolamento 608 + alivio para a ponta do pino
        translate([0, 0, h_base - rol_608[2] - 0.2]) cylinder(d = rol_608[0] + 0.2, h = 10);
        translate([0, 0, h_base - rol_608[2] - 6]) cylinder(d = 12, h = 7);
        // alivio conico por baixo (teto a 45 graus, imprime sem suporte)
        rotate_extrude($fn = 120) polygon([[20, -0.01], [R_pista + 12, -0.01], [(R_pista + 32)/2, (R_pista - 8)/2]]);
        // calha de folga sob a rosca
        translate([x_raz, 0, z_raz]) rotate([90, 0, 0])
            cylinder(r = ra_raz + 1, h = 2*y_mancal_az, center = true);
        // furo do ponteiro de azimute
        translate([-r_pont_az, 0, h_base]) furo_ponteiro(8);
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
        translate([0, 0, h_mesa - prof_grav]) linear_extrude(1) escala_az_2d();
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
            // espacador entre a bochecha e a coroa
            translate([0, y_boch_out - 0.01, H_t]) rotate([-90, 0, 0])
                cylinder(d = 18, h = y_roda - h_roda_el/2 - 0.5 - y_boch_out);
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

// ---- BERCO do cano (origem no eixo do munhao, cano apontando +X)
module berco() {
    difference() {
        hull() {
            rotate([90, 0, 0]) cylinder(r = 12, h = larg_berco, center = true);
            translate([-16, 0, 0]) rotate([90, 0, 0]) cylinder(r = 8, h = larg_berco, center = true);
            translate([14, -larg_berco/2, -11]) cube([6, larg_berco, 22]);
        }
        rotate([90, 0, 0]) hex_furo(f_munhao, larg_berco + 2);
        translate([8, 0, 0]) rotate([0, 90, 0]) cylinder(d = 18 + 0.4, h = 20);  // soquete do cano
    }
}

// ---- CANO simples (provisorio: o mecanismo de disparo vem depois)
module cano() {
    translate([8, 0, 0]) rotate([0, 90, 0]) difference() {
        union() {
            cylinder(d = 18, h = 130);
            translate([0, 0, 124]) cylinder(d = 22, h = 6);
        }
        translate([0, 0, -1]) cylinder(d = 10, h = 132);
    }
}

// ---- COROA de elevacao com escala gravada na face externa (origem na face interna)
module roda_el() {
    difference() {
        engrenagem_helicoidal(m_el, z_el, h_roda_el, gama_el);
        hex_furo(f_munhao, 3*h_roda_el);
        for (i = [0:5]) rotate(i*60 + 30) translate([18, 0, -1]) cylinder(d = 10, h = h_roda_el + 2);
        translate([0, 0, h_roda_el - prof_grav]) linear_extrude(1) escala_el_2d();
    }
}

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

// manivela + punho ja posicionados (eixo da manivela = Z local)
module manivela_montada(R) {
    color("Firebrick") manivela(R);
    color("Black") translate([R, 0, 6.2]) punho();
}

module acion_az(giro) {   // rosca, eixo e manivela de azimute (coords da base)
    translate([x_raz, 0, z_raz]) rotate([90, 0, 0]) {
        color("Goldenrod") rotate(giro) rosca(m_az, d_rosca_az, L_rosca_az);
        color("Silver") translate([0, 0, -(y_mancal_az + esp_mancal_az + 4.5)])
            eixo_hex(f_eixo, L_eixo_az, [2.5, L_eixo_az - h_cubo + z_pino_man]);
        translate([0, 0, y_man_az]) rotate(giro) manivela_montada(R_manivela_az);
    }
}

module acion_el(giro) {   // rosca, eixo e manivela de elevacao (coords do carro)
    translate([0, y_roda, z_rosca_el]) rotate([0, 90, 0]) {
        color("Goldenrod") rotate(giro) rosca(m_el, d_rosca_el, L_rosca_el);
        color("Silver") translate([0, 0, -(x_man_el + h_cubo)])
            eixo_hex(f_eixo, L_eixo_el, [h_cubo - z_pino_man, L_eixo_el - 2.5]);
    }
    translate([-x_man_el, y_roda, z_rosca_el]) rotate([0, -90, 0]) rotate(-giro)
        manivela_montada(R_manivela_el);
}

module conjunto_elevacao() {  // tudo que gira com o cano (origem no munhao)
    rotate([0, -el, 0]) {
        color("SaddleBrown") berco();
        color("DimGray") cano();
        color("Goldenrod") translate([0, y_roda - h_roda_el/2, 0]) rotate([-90, 0, 0]) roda_el();
        color("Silver") translate([0, y_roda + h_roda_el/2 + 4.5, 0]) rotate([90, 0, 0])
            eixo_hex(f_munhao, L_munhao, [2.5, L_munhao - 2.5]);
    }
}

module montagem() {
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
else if (PARTE == "berco")       translate([0, 0, larg_berco/2]) rotate([90, 0, 0]) berco();
else if (PARTE == "cano")        translate([0, 0, -8]) rotate([0, -90, 0]) cano();
else if (PARTE == "roda_el")     roda_el();
else if (PARTE == "rosca_az")    translate([0, 0, L_rosca_az/2]) rosca(m_az, d_rosca_az, L_rosca_az);
else if (PARTE == "rosca_el")    translate([0, 0, L_rosca_el/2]) rosca(m_el, d_rosca_el, L_rosca_el);
else if (PARTE == "manivela_az") manivela(R_manivela_az);
else if (PARTE == "manivela_el") manivela(R_manivela_el);
else if (PARTE == "punho")       punho();
else if (PARTE == "eixo_az")     translate([0, 0, f_eixo/2]) rotate([90, 0, 0])
                                     eixo_hex(f_eixo, L_eixo_az, [2.5, L_eixo_az - h_cubo + z_pino_man]);
else if (PARTE == "eixo_el")     translate([0, 0, f_eixo/2]) rotate([90, 0, 0])
                                     eixo_hex(f_eixo, L_eixo_el, [h_cubo - z_pino_man, L_eixo_el - 2.5]);
else if (PARTE == "eixo_munhao") translate([0, 0, f_munhao/2]) rotate([90, 0, 0])
                                     eixo_hex(f_munhao, L_munhao, [2.5, L_munhao - 2.5]);
else if (PARTE == "ponteiro_az") translate([0, 0, 2]) rotate([90, 0, 0]) ponteiro(h_pont_az, c_pont_az);
else if (PARTE == "ponteiro_el") translate([0, 0, 2]) rotate([90, 0, 0]) ponteiro(h_pont_el, c_pont_el);
else if (PARTE == "pino_pivo")   pino_pivo();
