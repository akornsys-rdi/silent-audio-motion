$fn=36;

base();
translate([24,0,3]) bridge_v2();
translate([30,40,2]) solenoid();
translate([30,40,3.5+21+14.5]) magnet();
translate([5,77,5]) pcb();

module base() {
    difference() {
        union() {
            cube([60,155,3]);
            //pcb
            union() {
                translate([46.75+5,3.75+77,0]) cylinder(r=2.5, h=5);
                translate([46.75+5,55.5+77,0]) cylinder(r=2.5, h=5);
                translate([4.25+5,36.75+77,0]) cylinder(r=2.5, h=5);
            }
        }
        union() {
            //solenoid
            union() {
                translate([30,40,2]) cylinder(r=25, h=2);
            }
            //bridge
            union() {
                translate([30,5,-1]) cylinder(r=1.25, h=5);
                translate([30,70,-1]) cylinder(r=1.25, h=5);
            }
            //pcb
            union() {
                translate([46.75+5,3.75+77,-1]) cylinder(r=1.25, h=8);
                translate([46.75+5,55.5+77,-1]) cylinder(r=1.25, h=8);
                translate([4.25+5,36.75+77,-1]) cylinder(r=1.25, h=8);
            }
            //mounting holes
            union() {
                translate([5,5,-1]) cylinder(r=1.75, h=5);
                translate([55,5,-1]) cylinder(r=1.75, h=5);
                translate([5,150,-1]) cylinder(r=1.75, h=5);
                translate([55,150,-1]) cylinder(r=1.75, h=5);
            }
        }
    }
}

module bridge() {
    difference() {
        union() {
            cube([12,75,3]);
            translate([0,13,0]) cube([12,54,34.5]);
            translate([6,40,34.5]) cylinder(r=10, h=2);
        }
        union() {
            translate([6,40,-1]) cylinder(r=25, h=22);
            translate([-1,14,20]) cube([14,52,13.5]);
            translate([6,40,34.5]) cylinder(r=8, h=3);
            translate([-5,30,34]) cube([5,20,4]);
            translate([12,30,34]) cube([5,20,4]);
            translate([6,5,-1]) cylinder(r=1.75, h=5);
            translate([6,70,-1]) cylinder(r=1.75, h=5);
        }
    }
}

module bridge_v2() {
    difference() {
        union() {
            cube([12,75,3]);
            translate([0,13,0]) cube([12,54,34.5]);
            translate([0,10,28]) hull() {
                rotate([0,90,0]) cylinder(r=8, h=12);
                translate([0,60,0]) rotate([0,90,0]) cylinder(r=8, h=12);
            }
            translate([6,40,36]) cylinder(r=10, h=2);
        }
        union() {
            translate([6,40,-1]) cylinder(r=25, h=21);
            difference() {
                translate([-1,10,28]) hull() {
                    rotate([0,90,0]) cylinder(r=7.5, h=14);
                    translate([0,60,0]) rotate([0,90,0]) cylinder(r=7.5, h=14);
                }
                union() {
                    translate([-2,13.75,20]) cube([16, 52, 0.5]);
                    translate([-2,31.75,20]) cube([16, 16, 7]);
                }
            }
            translate([6,40,36]) cylinder(r=8, h=3);
            translate([-5,30,34.5]) cube([5,20,4]);
            translate([12,30,34.5]) cube([5,20,4]);
            translate([6,5,-1]) cylinder(r=1.75, h=5);
            translate([6,70,-1]) cylinder(r=1.75, h=5);
        }
    }
}

module pcb() {
    /*color("SandyBrown") cube([50,70,1.6]);
    translate([33,11,-13]) color("DimGray") cube([16,10,13]);
    translate([-15,6,-5]) color("LimeGreen") cube([15,11,11]);
    translate([8,4,1.6]) color("ForestGreen") cube([16,21,14]);
    translate([8,28,1.6]) color("MidnightBlue") cube([43,18,22]);*/
    difference() {
        color("ForestGreen") cube([50,70,1.6]);
        translate([46.75,3.75,-1]) cylinder(r=1.5, h=3);
        translate([46.75,55.5,-1]) cylinder(r=1.5, h=3);
        translate([4.25,36.75,-1]) cylinder(r=1.5, h=3);
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