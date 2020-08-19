$fn=36;

base();
translate([53,0,1]) cover();
translate([26,37,3]) bridge_v3();
translate([26,37,0]) solenoid();
translate([26,37,3.5+21+12.5]) magnet();
translate([105,72,3]) rotate([0,0,180]) pcb();

module base() {
    radius = 4;
    size_x = 107;
    size_y = 74;
    padding_x = 53;
    padding_y = 4;

    difference() {
        union() {
            union() {
                hull() {
                    for (i = [ [radius,radius + padding_y,0], [radius,size_y - radius - padding_y,0], [padding_x - radius,size_y - radius - padding_y,0], [padding_x - radius,radius + padding_y,0] ]) {
                        translate(i) cylinder(r=radius, h=1);
                    }
                }
                hull() {
                    for (i = [ [padding_x - radius*2,radius + padding_y,0], [padding_x - radius*2,size_y - radius - padding_y,0], [padding_x,radius,0], [padding_x,size_y - radius,0] ]) {
                        translate(i) cylinder(r=radius, h=1);
                    }
                }
                hull() {
                    for (i = [ [padding_x,radius,0], [padding_x,size_y - radius,0], [size_x - radius,size_y - radius,0], [size_x - radius,radius,0] ]) {
                        translate(i) cylinder(r=radius, h=1);
                    }
                }
                hull() {
                    for (i = [ [size_x - radius,radius,0], [size_x + radius,radius,0] ]) {
                        translate(i) cylinder(r=radius, h=1);
                    }
                }
                //refuerzos
                for (i = [ [5,7,1], [5,11,1], [5,67,1], [5,63,1] ]) {
                    hull() {
                        for (j = [0:1:1]) {
                            translate(i) translate([0,0,j]) sphere(r=1, $fn=36);
                            translate(i) translate([45,0,j]) sphere(r=1, $fn=36);
                        }
                    }
                }
            }
            //bridge
            translate([20,padding_y, 0]) cube([12,size_y - padding_y*2, 3]);
            //puntos montaje base
            translate([size_x + radius,radius,0]) cylinder(r=radius, h=3);
            translate([radius,size_y - radius - padding_y,0]) cylinder(r=radius, h=3);
            //punto montaje pcb
            translate([58.25,16.5,0]) cylinder(r=3.5, h=3.25);
            translate([58.25,68.25,0]) cylinder(r=3.5, h=3.25);
            translate([100.75,35.25,0]) cylinder(r=3.5, h=3.25);
        }
        union() {
            //solenoide
            translate([26,37,-1]) cylinder(r=24.5, h=5);
            //vaciado pcb
            hull() {
                for (i = [ [60,25,-1], [60,60,-1], [75,10,-1], [92,60,-1], [92,10,-1] ]) {
                    translate(i) cylinder(r=3, h=3);
                }
            }
            //taladros montaje bridge
            translate([26,7,-1]) cylinder(r=1.25, h=5);
            translate([26,67,-1]) cylinder(r=1.25, h=5);
            //taladros montaje pcb
            translate([58.25,16.5,-1]) cylinder(r=1.25, h=5);
            translate([58.25,68.25,-1]) cylinder(r=1.25, h=5);
            translate([100.75,35.25,-1]) cylinder(r=1.25, h=5);
            //taladros montaje base
            translate([size_x + radius,radius,-1]) cylinder(r=1.75, h=5);
            translate([size_x + radius,radius,0.1]) cylinder(r1=1.75, r2=3, h=3.1);
            translate([radius,size_y - radius - padding_y,-1]) cylinder(r=1.75, h=5);
            translate([radius,size_y - radius - padding_y,0.1]) cylinder(r1=1.75, r2=3, h=3.1);
        }
    }
}

module cover() {
    difference() {
        union() {
            hull() {
                for(i = [ [3,3,0], [3,71,0], [51,3,0], [51,71,0] ]) {
                    translate(i) cylinder(r=3, h=20);
                }
            }
            union() {
                translate([6.75+5.25,0.5,5]) rotate([90,0,0]) linear_extrude(1) text("L", font=":bold", size=4, valign="center", halign = "center");
                translate([6.75,0.5,14]) rotate([90,270,0]) linear_extrude(1) text("TRG", font=":bold", size=4, valign="center", halign = "center");
                translate([6.75+10.5,0.5,14]) rotate([90,270,0]) linear_extrude(1) text("ADJ", font=":bold", size=4, valign="center", halign = "center");
                translate([6.75+5.25+21,0.5,5]) rotate([90,0,0]) linear_extrude(1) text("R", font=":bold", size=4, valign="center", halign = "center");
                translate([6.75+21,0.5,14]) rotate([90,270,0]) linear_extrude(1) text("ADJ", font=":bold", size=4, valign="center", halign = "center");
                translate([6.75+31.5,0.5,14]) rotate([90,270,0]) linear_extrude(1) text("TRG", font=":bold", size=4, valign="center", halign = "center");
                translate([53.5,25,17]) rotate([90,0,90]) linear_extrude(1) text("IN", font=":bold", size=4, valign="center", halign = "center");
                translate([53.5,41.6+2.54,13]) rotate([90,0,90]) linear_extrude(1) text("L", font=":bold", size=4, valign="center", halign = "center");
                translate([53.5,41.6+10.16+2.54,13]) rotate([90,0,90]) linear_extrude(1) text("R", font=":bold", size=4, valign="center", halign = "center");
                translate([53.5,41.6+20.32,13]) rotate([90,0,90]) linear_extrude(1) text("-", font=":bold", size=6, valign="center", halign = "center");
                translate([53.5,41.6+20.32+5.08,13]) rotate([90,0,90]) linear_extrude(1) text("+", font=":bold", size=5, valign="center", halign = "center");
            }
        }
        union() {
            //ventilacion
            translate([10.25,10.25,18]) for(i = [0:7:30]) {
                for(j = [0:7:50]) {
                    translate([i,j,0]) cube([4.5,4.5,3]);
                }
            }
            //puntos de montaje
            difference() {
                hull() {
                    for(i = [ [4,4,-1], [4,70,-1], [50,4,-1], [50,70,-1] ]) {
                        translate(i) cylinder(r=3, h=20);
                    }
                }
                translate([5.25,16.5,3.75]) cylinder(r=3.75, h=17);
                translate([5.25,68.25,3.75]) cylinder(r=3.75, h=17);
                translate([47.75,35.25,3.75]) cylinder(r=3.75, h=17);
            }
            //pot
            translate([6.75,2,7.1]) for(i = [0:10.5:35]) {
                translate([i,0,0]) rotate([90,0,0]) cylinder(r=1.5, h=3);
            }
            //jack
            translate([52,25,10]) hull() {
                rotate([0,90,0]) cylinder(r=4, h=3);
                translate([0,0,-10]) rotate([0,90,0])  cylinder(r=4, h=3);
            }
            //conn
            translate([52,39.6,0]) for(i = [0:5.08:26]) {
                translate([0,i,6]) cube([3,4,4.5]);
                translate([-4,i+2,18]) cylinder(r=2.5, h=3);
            }
            //puntos de montaje
            union() {
                translate([5.25,16.5,3]) cylinder(r=1.75, h=3);
                translate([5.25,68.25,3]) cylinder(r=1.75, h=3);
                translate([47.75,35.25,3]) cylinder(r=1.75, h=3);
                translate([5.25,16.5,4.75]) cylinder(r=2.85, h=16);
                translate([5.25,68.25,4.75]) cylinder(r=2.85, h=16);
                translate([47.75,35.25,4.75]) cylinder(r=2.85, h=16);
            }
        }
    }
}

module bridge_v3() {
    thickness = 0.5;
    aperture = 1;
    lenght = 50;

    difference() {
        union() {
            //base
            translate([-6,-33,0]) cube([12,66,3]);
            translate([-6,-27,0]) cube([12,54,32.5]);
            //anillo
            translate([-6,-(lenght/2),26]) hull() {
                rotate([0,90,0]) cylinder(r=8, h=12);
                translate([0,lenght,0]) rotate([0,90,0]) cylinder(r=8, h=12);
            }
            //soporte iman
            translate([0,0,34]) cylinder(r=10, h=2);
        }
        union() {
            //solenoide
            translate([0,0,-1]) cylinder(r=25, h=19);
            //apertura
            translate([(12-aperture)/2-6,-(lenght/2)-10,22]) cube([aperture,10,8]);
            translate([(12-aperture)/2-6,(lenght/2),22]) cube([aperture,10,8]);
            //hueco anillo
            difference() {
                translate([-7,-(lenght/2),26]) hull() {
                    rotate([0,90,0]) cylinder(r=8-thickness, h=14);
                    translate([0,lenght,0]) rotate([0,90,0]) cylinder(r=8-thickness, h=14);
                }
                //tope
                translate([-8,-8.25,18]) cube([16, 16, 7]);
            }
            //hueco tope
            translate([-9,-6.25,16]) cube([18,12,7]);
            //cortes soporte iman
            translate([0,0,34]) cylinder(r=8, h=3);
            translate([-11,-10,32.5]) cube([5,20,4]);
            translate([6,-10,32.5]) cube([5,20,4]);
            //taladros montaje
            translate([0,-30,-1]) cylinder(r=1.75, h=5);
            translate([0,30,-1]) cylinder(r=1.75, h=5);
        }
    }
}

module pcb() {
    difference() {
        union() {
            //pcb
            color("ForestGreen") cube([50,70,1.6]);
            //components
            translate([0,0,1.6]) union() {
                //jack
                translate([0,38.5+2.5,0]) union() {
                    color("DimGray") cube([12,11.5,11]);
                    color("Gainsboro") translate([0,6,2.75+3.625]) rotate([0,-90,0]) cylinder(r=3, h=3.5);
                    color("lightgray") translate([-3.5+6.5,5.75-0.5,-4]) cube([0.5,1,4]);
                    color("lightgray") translate([-3.5+6.5+5,5.75+5-0.25,-4]) cube([1,0.5,4]);
                    color("lightgray") translate([-3.5+6.5+5,5.75-5-0.25,-4]) cube([1,0.5,4]);
                }
                //conn
                translate([-0.5,2.5,0]) for(i = [0:10.16:20.5]) {
                    color("LimeGreen") difference() {
                        translate([0,i,0]) cube([9.5,10.16,15]);
                        translate([-1,i+1.1,3]) cube([3,3,3.5]);
                        translate([-1,i+1.1+5.08,3]) cube([3,3,3.5]);
                    }
                    color("Gainsboro") translate([4.5,i+2.5,15]) cylinder(r=2, h=1);
                    color("Gainsboro") translate([4.5,i+2.5+5.08,15]) cylinder(r=2, h=1);
                    color("lightgray") translate([4.75-0.45,i+2.54-0.4,-3.5]) cube([0.9,0.8,3.5]);
                    color("lightgray") translate([4.75-0.45,i+5.08+2.54-0.4,-3.5]) cube([0.9,0.8,3.5]);
                }
                //QFP32
                translate([(50 - 12.192), (70 - 45.466), 0]) union() {
                    color("dimgrey") translate([-3.5, -3.5, 0]) cube([7, 7, 1.2]);
                    color("lightgray") for (i = [-3:0.8:2.9]) {
                        translate([-4.5, i, 0]) cube([9, 0.4, 0.6]);
                    }
                    color("lightgray") for (i = [-3:0.8:2.9]) {
                        translate([i, -4.5, 0]) cube([0.4, 9, 0.6]);
                    }
                }
                //SSOP24
                translate([(50 - 35.052), (70 - 45.212), 0]) union() {
                    color("dimgrey") translate([-2.8, -3.9, 0]) cube([5.6, 7.8, 1.6]);
                    color("lightgray") for (i = [-3.575:0.65:3.575]) {
                        translate([-3.8, i - 0.11, 0]) cube([7.6, 0.22, 0.8]);
                    }
                }
                //TSSOP14
                for (i = [ [(50 - 8.128), (70 - 25.146), 0], [(50 - 27.686), (70 - 25.146), 0], [(50 - 21.028), (70 - 15.494), 0] ]) {
                    translate(i) union() {
                        color("dimgrey") translate([-2.2, -2.5, 0]) cube([4.4, 5, 1]);
                        color("lightgray") for (j = [-1.96:0.65:1.96]) {
                            translate([-3.2, j - 0.11, 0]) cube([6.4, 0.22, 0.5]);
                        }
                    }
                }
                //SOIC8
                translate([(50 - 36.068), (70 - 59.944), 0]) union() {
                    color("dimgrey") translate([-1.95, -2.45, 0]) cube([3.9, 4.9, 1.75]);
                    color("lightgray") for (i = [-1.905, -0.635, 0.635, 1.905]) {
                        translate([-3.05, i - 0.255, 0]) cube([6.1, 0.51, 1.13]);
                    }
                }
                //DPAK-3
                translate([(50 - 28.448), (70 - 61.976), 0]) rotate([0,0,90]) union() {
                    color("dimgrey") translate([-2.985, -3.175, 0]) cube([5.97, 6.35, 2.18]);
                    color("lightgray") translate([0, -2.285, 0]) cube([0.89+2.985, 4.57, 0.46]);
                    color("lightgray") for (i = [-2.29, 2.29]) {
                        translate([-2.985-2.9, i - 0.315, 0]) cube([2.9, 0.63, 1.09]);
                    }
                    color("lightgray") translate([-2.985-0.89, -0.315, 0]) cube([0.89, 0.63, 1.09]);
                }
                //SOT23-3
                translate([(50 - 7.366), (70 - 54.102), 0]) rotate([0,0,90]) union() {
                    color("dimgrey") translate([-0.875, -1.525, 0]) cube([1.75, 3.05, 1.1]);
                    color("lightgray") for (i = [-0.95, 0.95]) {
                        translate([0, i - 0.25, 0]) cube([1.525, 0.5, 0.6]);
                    }
                    color("lightgray") translate([-1.525, -0.25, 0]) cube([1.525, 0.5, 0.6]);
                }
                //SOD-123 D
                for (i = [ [(50 - 11.43), (70 - 18.542), 0], [(50 - 8.636), (70 - 31.75), 0], [(50 - 11.176), (70 - 31.75), 0], [(50 - 30.988), (70 - 18.542), 0], [(50 - 28.194), (70 - 31.75), 0], [(50 - 30.734), (70 - 31.75), 0] ]) {
                    translate(i) rotate([0,0,90]) union() {
                        color("dimgrey") translate([-1.425, -0.9, 0]) cube([2.85, 1.8, 1.17]);
                        color("lightgray") translate([-1.95, -0.35, 0]) cube([3.9, 0.7, 0.585]);
                    }
                }
                //0805 LED
                translate([(50 - 3.556), (70 - 40.64), 0]) union() {
                    color("lightsalmon") translate([-0.6, -0.625, 0.3]) cube([1.2, 1.25, 0.5]);
                    color("ivory") translate([-0.6, -0.625, 0]) cube([1.2, 1.25, 0.3]);
                    color("lightgray") for (i = [-0.8, 0.8]) {
                        translate([i - 0.2, -0.625, 0]) cube([0.4, 1.25, 0.35]);
                    }
                }
                translate([(50 - 47.752), (70 - 68.58), 0]) union() {
                    color("lightskyblue") translate([-0.6, -0.625, 0.3]) cube([1.2, 1.25, 0.5]);
                    color("ivory") translate([-0.6, -0.625, 0]) cube([1.2, 1.25, 0.3]);
                    color("lightgray") for (i = [-0.8, 0.8]) {
                        translate([i - 0.2, -0.625, 0]) cube([0.4, 1.25, 0.35]);
                    }
                }
                //XTAL
                translate([(50 - 22.606), (70 - 45.974), 0]) rotate([0,0,90]) {
                    color("dimgrey") translate([-5.7, -2.35, 0]) cube([11.4, 4.7, 0.75]);
                    color("silver") hull() {
                        translate([3.31,0,0]) cylinder(r=1.84, h=4.3, $fn=8);
                        translate([-3.31,0,0]) cylinder(r=1.84, h=4.3, $fn=8);
                    }
                    color("lightgray") translate([-6.15, -0.35, 0]) cube([12.3, 0.7, 0.4]);
                }
                //pv36
                translate([50,70-0.5,0]) rotate([0,0,180]) for (i = [ 3.5:10.5:35 ]) {
                    color("MediumBlue") translate([i,0,0]) cube([9.5,9.5,4.75]);
                    color("Goldenrod") translate([i+1.25,0,3.5]) rotate([90,0,0]) cylinder(r=1.125, h=1.5);
                    color("lightgray") translate([i+4.75-2.54,10-5.23,-3]) cylinder(r=0.35, h=3);
                    color("lightgray") translate([i+4.75,10-5.23-2.54,-3]) cylinder(r=0.35, h=3);
                    color("lightgray") translate([i+4.75+2.54,10-5.23,-3]) cylinder(r=0.35, h=3);
                }
                //0805 R
                for (i = [ [(50 - 43.18), (70 - 68.58), 0], [(50 - 14.478), (70 - 68.58), 0], [(50 - 3.556), (70 - 42.672), 0], [(50 - 15.24), (70 - 28.194), 0], [(50 - 15.24), (70 - 26.162), 0], [(50 - 15.24), (70 - 24.13), 0], [(50 - 15.24), (70 - 22.098), 0], [(50 - 12.192), (70 - 14.986), 0], [(50 - 34.798), (70 - 28.194), 0], [(50 - 34.798), (70 - 26.162), 0], [(50 - 34.798), (70 - 24.13), 0], [(50 - 34.798), (70 - 22.098), 0], [(50 - 31.75), (70 - 14.986), 0] ]) {
                    translate(i) union() {
                        color("slategray") translate([-0.775, -0.625, 0]) cube([1.55, 1.25, 0.5]);
                        color("lightgray") for (i = [-0.825, 0.825]) {
                            translate([i - 0.175, -0.65, 0]) cube([0.35, 1.3, 0.55]);
                        }
                    }
                }
                for (i = [ [(50 - 10.16), (70 - 54.102), 0], [(50 - 26.416), (70 - 45.974), 0], [(50 - 6.35), (70 - 31.75), 0], [(50 - 13.716), (70 - 31.75), 0], [(50 - 15.748), (70 - 31.75), 0], [(50 - 13.716), (70 - 18.542), 0], [(50 - 25.908), (70 - 31.75), 0], [(50 - 33.274), (70 - 31.75), 0], [(50 - 35.306), (70 - 31.75), 0], [(50 - 33.274), (70 - 18.542), 0] ]) {
                    translate(i) rotate([0,0,90]) union() {
                        color("slategray") translate([-0.775, -0.625, 0]) cube([1.55, 1.25, 0.5]);
                        color("lightgray") for (i = [-0.825, 0.825]) {
                            translate([i - 0.175, -0.65, 0]) cube([0.35, 1.3, 0.55]);
                        }
                    }
                }
                //4x5.3 C ELEC
                for (i = [ [(50 - 36.068), (70 - 65.024), 0], [(50 - 35.052), (70 - 52.324), 0] ]) {
                    translate(i) {
                        color("dimgrey") translate([-2.15, -2.15, 0]) cube([4.3, 4.3, 1]);
                        color("silver") cylinder(r=2, h=5.3, $fn=8);
                        color("lightgray") translate([-2.3, -0.35, 0]) cube([4.6, 0.7, 0.3]);
                    }
                }
                //0805 C
                for (i = [ [(50 - 36.068), (70 - 68.58), 0], [(50 - 28.448), (70 - 68.58), 0], [(50 - 9.906), (70 - 68.58), 0], [(50 - 35.052), (70 - 55.88), 0], [(50 - 35.052), (70 - 39.37), 0], [(50 - 11.684), (70 - 38.796), 0], [(50 - 27.686), (70 - 21.082), 0], [(50 - 8.128), (70 - 21.082), 0], [(50 - 21.082), (70 - 11.43), 0] ]) {
                    translate(i) union() {
                        color("tan") translate([-0.8, -0.625, 0]) cube([1.6, 1.25, 1]);
                        color("lightgray") for (i = [-0.775, 0.775]) {
                            translate([i  -0.125, -0.65, 0]) cube([0.25, 1.3, 1.05]);
                        }
                    }
                }
                for (i = [ [(50 - 26.416), (70 - 50.8), 0], [(50 - 26.416), (70 - 41.148), 0], [(50 - 16.256), (70 - 54.102), 0], [(50 - 14.224), (70 - 54.102), 0], [(50 - 12.192), (70 - 54.102), 0], [(50 - 4.572), (70 - 54.118), 0] ]) {
                    translate(i) rotate([0,0,90]) union() {
                        color("tan") translate([-0.8, -0.625, 0]) cube([1.6, 1.25, 1]);
                        color("lightgray") for (i = [-0.775, 0.775]) {
                            translate([i  -0.125, -0.65, 0]) cube([0.25, 1.3, 1.05]);
                        }
                    }
                }
                //0805 L
                translate([(50 - 18.288), (70 - 54.102), 0]) rotate([0,0,90]) union() {
                    color("darkgray") translate([-0.775, -0.625, 0]) cube([1.55, 1.25, 0.5]);
                    color("lightgray") for (i = [-0.825, 0.825]) {
                        translate([i - 0.175, -0.65, 0]) cube([0.35, 1.3, 0.55]);
                    }
                }
            }
        }
        //conn 1x04
        union() {
            for (i = [0:2.54:7.62] ) {
                translate([(50 - 1.778),(70 - 45.466) - i,-1]) cylinder(r=0.5, h=3);
            }
        }
        //conn 2x03
        union() {
            for (i = [0:2.54:5.08] ) {
                for (j = [0:2.54:2.54] ) {
                    translate([(50 - 17.018) + i,(70 - 63.5) + j,-1]) cylinder(r=0.5, h=3);
                }
            }
        }
        //taladros
        union () {
            translate([46.75,3.75,-1]) cylinder(r=1.5, h=3);
            translate([46.75,55.5,-1]) cylinder(r=1.5, h=3);
            translate([4.25,36.75,-1]) cylinder(r=1.5, h=3);
        }
    }
}

module solenoid() {
    color("Gainsboro") difference() {
        cylinder(r=24.5, h=21);
        union() {
            difference() {
                translate([0,0,1]) cylinder(r=21, 21);
                cylinder(r=11.5, h=21);
            }
            translate([0,0,-1]) cylinder(r=3, h=14);
        }
    }
    color("DimGray") difference() {
        translate([0,0,1]) cylinder(r=21.5, 19.5);
        cylinder(r=11, h=21);
    }
}

module magnet() {
    color("Gainsboro") cylinder(r=7.5, h=8);
}