// =====================================================================
//  CANHÃO DE BRINQUEDO  -  reparo com coroa e rosca sem fim
// ---------------------------------------------------------------------
//  Dois eixos de pontaria, cada um com manivela e redução por
//  rosca sem fim (1 entrada) + coroa helicoidal:
//
//    AZIMUTE  (horizontal): rosca na base fixa  -> coroa grande que é a
//                           própria MESA giratória, apoiada num
//                           rolamento de esferas (BBs 6 mm) + 608 central.
//    ELEVAÇÃO (vertical)  : rosca no carro      -> coroa no munhão do cano.
//
//  Escalas em graus:
//    - azimute : gravada no anel da mesa, ponteiro preso na base
//    - elevação: gravada na face da coroa, ponteiro preso na bochecha
//    - cada manivela tem um "tambor micrométrico" com marcas de 0,5°
//
//  O mecanismo de disparo ainda NÃO existe: o cano é um tubo simples
//  encaixado no berço (troque o módulo cano() depois).
//
//  Unidades: mm.  Testado no OpenSCAD 2021.01.
// =====================================================================

/* [Visualização] */
// O que gerar: "montagem" ou o nome de uma peça para imprimir
PARTE = "montagem"; // [montagem, base, mesa, carro, berco, cano, roda_el, rosca_az, rosca_el, manivela_az, manivela_el, eixo_az, eixo_el, eixo_munhao, ponteiro_az, ponteiro_el, pino_pivo]
// Ângulo horizontal mostrado na montagem (graus)
AZIMUTE  = 30;
// Ângulo vertical mostrado na montagem (graus)
ELEVACAO = 25;
// Anima com $t (View > Animate)
ANIMAR = false;
MOSTRAR_ESFERAS = true;

/* [Geral] */
folga       = 0.3;   // folga de impressão em furos/encaixes
folga_dente = 0.15;  // folga (backlash) nos dentes
pa          = 20;    // ângulo de pressão dos dentes (graus)
fonte       = "Liberation Sans:style=Bold";
$fn = 48;

/* [Eixos sextavados] */
// Chave Allen 6 mm serve como eixo das roscas!
f_eixo   = 6;    // eixos das roscas (medida entre faces)
f_munhao = 8;    // eixo do munhão (chave Allen 8 mm serve)
d_pino   = 2.0;  // furos transversais p/ pino de filamento 1,75 mm

/* [Azimute] */
m_az        = 2;    // módulo
z_az        = 72;   // dentes da coroa/mesa  -> redução 72:1
h_mesa      = 12;   // espessura da mesa (largura do dente)
d_rosca_az  = 18;   // diâmetro primitivo da rosca
L_rosca_az  = 40;   // comprimento da rosca
R_manivela_az = 20; // raio da manivela

/* [Elevação] */
m_el        = 1.5;
z_el        = 60;   // dentes da coroa de elevação -> redução 60:1
h_roda_el   = 10;
d_rosca_el  = 16;
L_rosca_el  = 34;
R_manivela_el = 16;
el_min      = -10;  // faixa da escala gravada
el_max      = 80;

/* [Base e rolamento] */
r_base    = 82;
h_base    = 22;
R_pista   = 56;   // raio da pista das esferas
d_esfera  = 6;    // BB de airsoft 6 mm
prof_v    = 3.4;  // profundidade do canal em V (90°)
rol_608   = [22, 8, 7];  // rolamento central: ext, int, largura

/* [Carro] */
larg_berco   = 24;
esp_bochecha = 6;
h_placa      = 5;
z_rosca_el   = 28;  // altura do eixo da rosca de elevação acima da mesa
esp_mancal_az = 8;
esp_mancal_el = 6;

// =====================================================================
//  GRANDEZAS DERIVADAS (não mexer)
// =====================================================================
rp_az    = m_az*z_az/2;
ra_raz   = d_rosca_az/2 + m_az;            // raio externo da rosca az
x_raz    = rp_az + d_rosca_az/2;           // distância entre eixos (az)
folga_v  = 2*(d_esfera/2*sqrt(2) - prof_v);// vão entre base e mesa
z_esf    = h_base + folga_v/2;             // centro das esferas
z_mesa   = h_base + folga_v;               // fundo da mesa
z_deck   = z_mesa + h_mesa;                // topo da mesa
z_raz    = z_mesa + h_mesa/2;              // eixo da rosca az
y_mancal_az = L_rosca_az/2 + 1;            // face interna dos mancais az

rp_el    = m_el*z_el/2;
ra_rel   = d_rosca_el/2 + m_el;
a_el     = rp_el + d_rosca_el/2;           // distância entre eixos (el)
H_t      = z_rosca_el + a_el;              // altura do munhão sobre a mesa
y_boch_in  = larg_berco/2 + 1;
y_boch_out = y_boch_in + esp_bochecha;
y_roda   = y_boch_out + ra_rel + 1.5;      // plano médio da coroa de elevação
x_mancal_el = L_rosca_el/2 + 1;

gama_az  = atan(m_az/d_rosca_az);          // ângulo de avanço das roscas
gama_el  = atan(m_el/d_rosca_el);

n_esferas = floor(2*PI*R_pista/(d_esfera + 0.4));

// posição dos ponteiros
r_pont_az = 78;            // furo do ponteiro na base
x_pont_el = -53;           // furo do ponteiro na bochecha
h_pont_az = z_deck + 0.8 + 1.5 - h_base;               // agulha 0,8 mm acima da mesa
c_pont_az = r_pont_az - 68.5;                          // ponta logo além das marcas
h_pont_el = y_roda + h_roda_el/2 + 0.5 + 1.5 - y_boch_out; // agulha 0,5 mm da face da coroa
c_pont_el = -x_pont_el - 42.5;

// furos de fixação do carro na mesa (M3 / parafuso auto-atarraxante)
furos_carro = [[-22,-23], [28,-23], [-10, y_roda+5], [10, y_roda+5]];

// comprimentos dos eixos
L_eixo_az = (y_mancal_az + esp_mancal_az + 4.5) + (y_mancal_az + esp_mancal_az + 1 + 9 + 4.5);
L_eixo_el = (x_mancal_el + esp_mancal_el + 4.5) + (x_mancal_el + esp_mancal_el + 1 + 9 + 4.5);
L_munhao  = (y_boch_out + 4.5) + (y_roda + h_roda_el/2 + 4.5);

echo(str("=== AZIMUTE : redução ", z_az, ":1  ->  ", 360/z_az, " graus por volta da manivela"));
echo(str("=== ELEVAÇÃO: redução ", z_el, ":1  ->  ", 360/z_el, " graus por volta da manivela"));
echo(str("=== ângulo de avanço az = ", gama_az, "°, el = ", gama_el,
         "°  (autotravante se tan(γ) < μ≈0,3 -> ", tan(max(gama_az,gama_el)) < 0.3 ? "SIM" : "NÃO", ")"));
echo(str("=== esferas de ", d_esfera, " mm na pista: até ", n_esferas, " (use ~", n_esferas-3, ")"));
echo(str("=== eixo az = ", L_eixo_az, " mm, eixo el = ", L_eixo_el, " mm, munhão = ", L_munhao, " mm"));

// =====================================================================
//  ENGRENAGENS
// =====================================================================
function polar(r, a) = [r*cos(a), r*sin(a)];
function inv_graus(a) = (tan(a) - a*PI/180)*180/PI;   // função involuta

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
                [rb*sqrt(1 + t*t), t*180/PI - atan(t)]];      // [raio, ângulo polar]
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

// Coroa helicoidal (casa com a rosca sem fim: hélice = ângulo de avanço)
module engrenagem_helicoidal(m, z, h, beta) {
    tw = h*tan(beta)/(m*z/2)*180/PI;
    rotate(tw/2)   // dente em 0° no plano médio (onde a rosca toca)
        linear_extrude(height = h, twist = tw, slices = max(4, ceil(abs(tw)*2)), convexity = 10)
            engrenagem2d(m, z);
}

// Seção transversal da rosca sem fim (1 entrada, flanco reto de 2*pa)
module rosca2d(m, d) {
    p  = PI*m;
    rp = d/2;  ra = rp + m;  rf = rp - 1.25*m;
    N  = 180;
    polygon([for (i = [0:N-1]) let(
        th = 360*i/N,
        u0 = p*th/360,
        u  = u0 - p*floor(u0/p + 0.5),                 // posição axial em [-p/2, p/2]
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
            rotate(T/2)   // seção em z=0 alinhada com o perfil base
                linear_extrude(height = L, center = true, twist = T,
                               slices = ceil(L/p*30), convexity = 6)
                    rosca2d(m, d);
            // chanfro de 45° nas pontas (imprime melhor em pé)
            rotate_extrude($fn = 64)
                polygon([[0, -L/2], [rf, -L/2], [ra + 0.5, -L/2 + (ra + 0.5 - rf)],
                         [ra + 0.5, L/2 - (ra + 0.5 - rf)], [rf, L/2], [0, L/2]]);
        }
        hex_furo(f_eixo, L + 2);
    }
}

// =====================================================================
//  PEÇAS AUXILIARES
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
// h_ax = distância do eixo até a superfície de apoio.
// ang_ind = direção da seta índice do tambor micrométrico.
module mancal(h_ax, esp, ang_ind, seta = true, larg = 16) {
    difference() {
        linear_extrude(esp) hull() {
            translate([-larg/2, -h_ax]) square([larg, h_ax]);
            circle(r = larg/2);
            if (seta) rotate(ang_ind) translate([0, -4]) square([13, 8]);
        }
        translate([0, 0, esp/2]) furo_redondo_p_hex(f_eixo, esp + 2);
        if (seta) translate([0, 0, esp - 0.8]) linear_extrude(1)
            rotate(ang_ind) polygon([[8.6, 0], [12.3, -2.2], [12.3, 2.2]]);
    }
}

// Manivela com tambor micrométrico: n_marcas no aro (pares = 1°, ímpares = 0,5°)
module manivela(R, n_marcas) {
    difference() {
        union() {
            cylinder(r = 7.5, h = 9);
            hull() {
                cylinder(r = 7.5, h = 5);
                translate([R, 0, 0]) cylinder(r = 5, h = 5);
            }
            translate([R, 0, 0]) cylinder(r = 4.5, h = 5 + 20);   // punho
            translate([R, 0, 25]) cylinder(r1 = 4.5, r2 = 3.5, h = 1.5);
        }
        translate([0, 0, 4.5]) hex_furo(f_eixo, 12);
        for (i = [0:n_marcas-1]) rotate(i*360/n_marcas)
            translate([7.5 - (i % 2 == 0 ? 1.4 : 0.8), -0.4, 5.5]) cube([2, 0.8, 4]);
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

// Canal em V (90°) para as esferas, centrado no plano z=0
module canal_v() {
    rotate_extrude($fn = 180)
        translate([R_pista, 0]) rotate(45) square(prof_v*sqrt(2), center = true);
}

// =====================================================================
//  ESCALAS GRAVADAS
// =====================================================================
// Azimute: valor v fica no ângulo local 180 - v (ponteiro está em 180°)
module escala_az_2d() {
    for (v = [0:5:355]) rotate(180 - v) {
        r0 = v % 30 == 0 ? 62.5 : (v % 10 == 0 ? 64 : 65.5);
        translate([r0, -0.4]) square([68.3 - r0, 0.8]);
    }
    for (v = [0:30:330]) let(a = 180 - v)
        translate(polar(58.5, a)) rotate(a + 90)
            text(str(v), size = 4.5, font = fonte, halign = "center", valign = "center");
}

// Elevação: valor v no ângulo local v - 180 (vira 180 - v depois de montada)
module escala_el_2d() {
    for (v = [el_min:5:el_max]) rotate(v - 180) {
        r0 = v % 10 == 0 ? 36 : 38.5;
        translate([r0, -0.4]) square([42 - r0, 0.8]);
        if (v % 10 == 0)
            translate([35, 0]) text(str(v), size = 3.2, font = fonte,
                                    halign = "right", valign = "center");
    }
}

// =====================================================================
//  PEÇAS PRINCIPAIS
// =====================================================================

// ---- BASE fixa: pista das esferas, sede do 608, mancais da rosca az
module base() {
    difference() {
        union() {
            cylinder(r = r_base, h = h_base, $fn = 180);
            translate([x_raz - 16, -(y_mancal_az + esp_mancal_az), 0])
                cube([32, 2*(y_mancal_az + esp_mancal_az), h_base]);
            // mancal do lado da manivela (-Y) com seta índice para cima
            translate([x_raz, -y_mancal_az, z_raz]) rotate([90, 0, 0])
                mancal(z_raz - h_base, esp_mancal_az, 90, true);
            // mancal do lado oposto
            translate([x_raz, y_mancal_az + esp_mancal_az, z_raz]) rotate([90, 0, 0])
                mancal(z_raz - h_base, esp_mancal_az, 90, false);
        }
        translate([0, 0, h_base]) canal_v();
        // sede do rolamento 608 + alívio para a ponta do pino
        translate([0, 0, h_base - rol_608[2] - 0.2]) cylinder(d = rol_608[0] + 0.2, h = 10);
        translate([0, 0, h_base - rol_608[2] - 6]) cylinder(d = 12, h = 7);
        // calha de folga sob a rosca
        translate([x_raz, 0, z_raz]) rotate([90, 0, 0])
            cylinder(r = ra_raz + 1, h = 2*y_mancal_az, center = true);
        // rebaixo para a manivela de azimute girar sem bater na base
        translate([x_raz, -(y_mancal_az + esp_mancal_az + 0.5), z_raz]) rotate([90, 0, 0])
            cylinder(r = R_manivela_az + 6, h = 40, $fn = 96);
        // furo do ponteiro de azimute
        translate([-r_pont_az, 0, h_base]) furo_ponteiro(8);
    }
}

// ---- MESA giratória = coroa grande de azimute (origem no fundo)
module mesa() {
    difference() {
        engrenagem_helicoidal(m_az, z_az, h_mesa, gama_az);
        canal_v();                                         // pista de baixo
        translate([0, 0, -1]) cylinder(d = rol_608[1] + 0.3, h = h_mesa + 2);
        translate([0, 0, h_mesa - 3]) cylinder(d = 14.5, h = 4);
        for (p = furos_carro) translate([p[0], p[1], h_mesa - 10]) cylinder(d = 2.8, h = 11);
        translate([0, 0, h_mesa - 0.6]) linear_extrude(1) escala_az_2d();
    }
}

// ---- CARRO: placa + bochechas + mancais da rosca de elevação (origem no topo da mesa)
module perfil_bochecha(com_braco) {
    hull() {
        translate([-20, 0]) square([50, h_placa]);
        translate([0, H_t]) circle(r = 16);
    }
    if (com_braco)  // braço inclinado (~50°, imprime sem suporte) que segura o ponteiro
        polygon([[-17, 40], [-50, H_t - 5], [x_pont_el - 4, H_t - 5],
                 [x_pont_el - 4, H_t + 5], [-6, H_t + 14]]);
}

module carro() {
    difference() {
        union() {
            translate([-27, -27, 0]) cube([60, 27 + y_roda + 9, h_placa]);
            // bochecha direita (+Y, com braço do ponteiro) e esquerda
            translate([0, y_boch_out, 0]) rotate([90, 0, 0])
                linear_extrude(esp_bochecha) perfil_bochecha(true);
            translate([0, -y_boch_in, 0]) rotate([90, 0, 0])
                linear_extrude(esp_bochecha) perfil_bochecha(false);
            // espaçador entre a bochecha e a coroa
            translate([0, y_boch_out - 0.01, H_t]) rotate([-90, 0, 0])
                cylinder(d = 18, h = y_roda - h_roda_el/2 - 0.5 - y_boch_out);
            // mancais da rosca de elevação (manivela atrás, -X)
            translate([-x_mancal_el, y_roda, z_rosca_el]) rotate([90, 0, -90])
                mancal(z_rosca_el - h_placa, esp_mancal_el, -90, true);
            translate([x_mancal_el + esp_mancal_el, y_roda, z_rosca_el]) rotate([90, 0, -90])
                mancal(z_rosca_el - h_placa, esp_mancal_el, -90, false);
        }
        translate([0, 0, H_t]) rotate([90, 0, 0]) furo_redondo_p_hex(f_munhao, 120);
        for (p = furos_carro) translate([p[0], p[1], 0]) {
            translate([0, 0, -1]) cylinder(d = 3.4, h = h_placa + 2);
            translate([0, 0, h_placa - 2.5]) cylinder(d = 6.5, h = 3);
        }
        // furo do ponteiro de elevação (atravessa a bochecha)
        translate([x_pont_el, y_boch_out, H_t]) rotate([-90, 0, 0]) furo_ponteiro(esp_bochecha + 1);
    }
}

// ---- BERÇO do cano (origem no eixo do munhão, cano apontando +X)
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

// ---- CANO simples (provisório: o mecanismo de disparo vem depois)
module cano() {
    translate([8, 0, 0]) rotate([0, 90, 0]) difference() {
        union() {
            cylinder(d = 18, h = 130);
            translate([0, 0, 124]) cylinder(d = 22, h = 6);
        }
        translate([0, 0, -1]) cylinder(d = 10, h = 132);
    }
}

// ---- COROA de elevação com escala gravada na face externa (origem na face interna)
module roda_el() {
    difference() {
        engrenagem_helicoidal(m_el, z_el, h_roda_el, gama_el);
        hex_furo(f_munhao, 3*h_roda_el);
        for (i = [0:5]) rotate(i*60 + 30) translate([19, 0, -1]) cylinder(d = 11, h = h_roda_el + 2);
        translate([0, 0, h_roda_el - 0.6]) linear_extrude(1) escala_el_2d();
    }
}

// ---- Pino pivô (ou use parafuso M8)
module pino_pivo() {
    cylinder(d = rol_608[1] - 0.1, h = (h_mesa - 3) + folga_v + rol_608[2] + 3);
    translate([0, 0, 0]) cylinder(d = 14, h = 3);
}

// =====================================================================
//  MONTAGEM
// =====================================================================
az = ANIMAR ? 60*sin(360*$t) : AZIMUTE;
el = ANIMAR ? 35 + 35*sin(720*$t) : ELEVACAO;
rot_raz = -az*z_az;   // giro da rosca de azimute (graus)
rot_rel =  el*z_el;   // giro da rosca de elevação

module conjunto_elevacao() {  // tudo que gira com o cano (origem no munhão)
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

    // acionamento de azimute (fixo na base)
    translate([x_raz, 0, z_raz]) rotate([90, 0, 0]) {
        color("Goldenrod") rotate(rot_raz) rosca(m_az, d_rosca_az, L_rosca_az);
        color("Silver") translate([0, 0, -(y_mancal_az + esp_mancal_az + 4.5)])
            eixo_hex(f_eixo, L_eixo_az, [2.5, L_eixo_az - 2.5]);
        color("Firebrick") translate([0, 0, y_mancal_az + esp_mancal_az + 1])
            rotate(rot_raz) manivela(R_manivela_az, round(2*360/z_az));
    }
    color("Red") translate([-r_pont_az, 0, h_base]) ponteiro(h_pont_az, c_pont_az);

    // tudo que gira com a mesa
    rotate([0, 0, az]) {
        color("OliveDrab") translate([0, 0, z_mesa]) mesa();
        color("Silver") translate([0, 0, z_deck]) rotate([180, 0, 0]) pino_pivo();
        translate([0, 0, z_deck]) {
            color("DarkKhaki") carro();
            // acionamento de elevação
            translate([0, y_roda, z_rosca_el]) rotate([0, 90, 0]) {
                color("Goldenrod") rotate(rot_rel) rosca(m_el, d_rosca_el, L_rosca_el);
                color("Silver") translate([0, 0, -(x_mancal_el + esp_mancal_el + 1 + 9 + 4.5)])
                    eixo_hex(f_eixo, L_eixo_el, [2.5, L_eixo_el - 2.5]);
            }
            color("Firebrick") translate([-(x_mancal_el + esp_mancal_el + 1), y_roda, z_rosca_el])
                rotate([0, -90, 0]) rotate(-rot_rel) manivela(R_manivela_el, round(2*360/z_el));
            color("Red") translate([x_pont_el, y_boch_out, H_t]) rotate([-90, 0, 0])
                ponteiro(h_pont_el, c_pont_el);
            translate([0, 0, H_t]) conjunto_elevacao();
        }
    }
}

// =====================================================================
//  SAÍDA (peças já na orientação de impressão)
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
else if (PARTE == "manivela_az") manivela(R_manivela_az, round(2*360/z_az));
else if (PARTE == "manivela_el") manivela(R_manivela_el, round(2*360/z_el));
else if (PARTE == "eixo_az")     translate([0, 0, f_eixo/2]) rotate([90, 0, 0]) eixo_hex(f_eixo, L_eixo_az, [2.5, L_eixo_az - 2.5]);
else if (PARTE == "eixo_el")     translate([0, 0, f_eixo/2]) rotate([90, 0, 0]) eixo_hex(f_eixo, L_eixo_el, [2.5, L_eixo_el - 2.5]);
else if (PARTE == "eixo_munhao") translate([0, 0, f_munhao/2]) rotate([90, 0, 0]) eixo_hex(f_munhao, L_munhao, [2.5, L_munhao - 2.5]);
else if (PARTE == "ponteiro_az") translate([0, 0, 2]) rotate([90, 0, 0]) ponteiro(h_pont_az, c_pont_az);
else if (PARTE == "ponteiro_el") translate([0, 0, 2]) rotate([90, 0, 0]) ponteiro(h_pont_el, c_pont_el);
else if (PARTE == "pino_pivo")   pino_pivo();
