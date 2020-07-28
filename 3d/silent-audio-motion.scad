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
            //pot
            translate([50,70-0.5,1.6]) rotate([0,0,180]) for (i = [ 3.5:10.5:35 ]) {
                color("MediumBlue") translate([i,0,0]) cube([9.5,10,4.75]);
                color("Goldenrod") translate([i+1.25,0,3.5]) rotate([90,0,0]) cylinder(r=1.125, h=1.5);
            }
            //jack
            translate([0,38.5+2.5,1.6]) union() {
                color("DimGray") cube([12,11.5,11]);
                color("Gainsboro") translate([0,6,2.75+3.625]) rotate([0,-90,0]) cylinder(r=3, h=3.5);
            }
            //conn
            translate([-0.5,2.5,1.6]) for(i = [0:10.16:20.5]) {
                color("LimeGreen") difference() {
                    translate([0,i,0]) cube([9.5,10.16,15]);
                    translate([-1,i+1.1,3]) cube([3,3,3.5]);
                    translate([-1,i+1.1+5.08,3]) cube([3,3,3.5]);
                }
                color("Gainsboro") translate([4.5,i+2.5,15]) cylinder(r=2, h=1);
                color("Gainsboro") translate([4.5,i+2.5+5.08,15]) cylinder(r=2, h=1);}
        }
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