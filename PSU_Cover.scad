resolution=120;
wall_thk=0;
corner_rad=2;
overlap=10;

wth=115;
hgt=50;
term_len=25;
block_hgt=3;

m3_dia=3.4;
m3_back_offset=27.5 + term_len;
m3_side_offset=10;
m4_dia=4.5;
m4_back_offset=32.5 + term_len;
m4_side_offset=32.5;
m4side_back_offset=32.5 + term_len;
m4side_center_offset=25;

cord_dia=7.5;
cord_center_offset=33;

overall_len=term_len + 32.5 + overlap; // m4_back_offset
back_wall_offset=-overall_len/2 + corner_rad/2 + wall_thk/2;
back_wall_inside_offset=-overall_len/2 + corner_rad + wall_thk;
bottom_wall_offset=-hgt/2 - corner_rad/2 - wall_thk/2;
bottom_wall_inside_offset=-hgt/2;
left_wall_offset=-wth/2 - corner_rad/2 - wall_thk/2;
left_wall_inside_offset=-wth/2;
right_wall_offset=wth/2 + corner_rad/2 + wall_thk/2;
right_wall_inside_offset=wth/2;
top_wall_offset=hgt/2 + corner_rad/2 + wall_thk/2;

side_cutout_hgt=25;
side_cutout_len=17;
side_cutout_len_offset=6 + term_len;
top_cutout_wth=25;
top_cutout_len=31;
top_cutout_cen_wth=20;
top_cutout_len_offset=13 + term_len;

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,h], [0,0,h], [0,w,0], [l,w,h], [0,w,h]],
        faces=[
            [0,2,1], 
            [3,4,5], 
            [0,1,4,3], 
            [2,5,4,1],
            [0,3,5,2]
        ]
    );
}

module blocks() {
    translate([ 0, back_wall_inside_offset + term_len, bottom_wall_inside_offset + block_hgt/2 ]) {
        cube([ wth, wall_thk, block_hgt ], center=true );
    }
    translate([ right_wall_inside_offset - block_hgt/2, back_wall_inside_offset + term_len, 0 ]) {
        cube([ block_hgt, wall_thk, hgt ], center=true );
    }
    translate([ left_wall_inside_offset + block_hgt/2, back_wall_inside_offset + term_len, 0 ]) {
        cube([ block_hgt, wall_thk, hgt ], center=true );
    }
    
    translate([ 0, back_wall_inside_offset + term_len, bottom_wall_inside_offset + block_hgt/2 ]) {
        translate([ -wth/2, -wall_thk/2, block_hgt/2 ]) {
            rotate([ 180, 0, 90 ]) {
                mirror([1,0,0]) {
                    
                    prism( block_hgt, wth, block_hgt );
                    
                }
            }
        }
    }
    
    translate([ right_wall_inside_offset - block_hgt/2, back_wall_inside_offset + term_len, 0 ]) {
        translate([ -block_hgt/2, -wall_thk/2, -hgt/2 ]) {
            rotate([ 90, 0, 90 ]) {
                mirror([1,0,0]) {
                    
                    prism( block_hgt, hgt, block_hgt );
                    
                }
            }
        }
    }
    
    translate([ left_wall_inside_offset - block_hgt/2, back_wall_inside_offset + term_len, 0 ]) {
        translate([ -block_hgt/2 + block_hgt, -wall_thk/2 - block_hgt, -hgt/2 ]) {
            rotate([ 90, 0, 180 ]) {
                mirror([1,0,0]) {
                    
                    prism( block_hgt, hgt, block_hgt );
                    
                }
            }
        }
    }
}

module holes() {
    // back holes
    // ============
    // DC power
    translate([ 0, back_wall_offset, 0 ]) {
        rotate([ 90, 0, 0 ]) {
            cylinder( d=cord_dia, h=wall_thk + corner_rad + 4, $fn=resolution, center=true );
        }
    }
    // AC power
    translate([ cord_center_offset, back_wall_offset, 0 ]) {
        rotate([ 90, 0, 0 ]) {
            cylinder( d=cord_dia, h=wall_thk + corner_rad + 4, $fn=resolution, center=true );
        }
    }
    
    // bottom holes
    // ============
    // m3 holes
    translate([right_wall_inside_offset - m3_side_offset, back_wall_inside_offset + m3_back_offset, bottom_wall_offset ]) {
        cylinder( d=m3_dia, h=wall_thk + corner_rad + 1, $fn=resolution, center=true );
    }
    translate([left_wall_inside_offset + m3_side_offset, back_wall_inside_offset + m3_back_offset, bottom_wall_offset ]) {
        cylinder( d=m3_dia, h=wall_thk + corner_rad + 1, $fn=resolution, center=true );
    }
    
    // m4 holes
    translate([right_wall_inside_offset - m4_side_offset, back_wall_inside_offset + m4_back_offset, bottom_wall_offset ]) {
        cylinder( d=m4_dia, h=wall_thk + corner_rad + 1, $fn=resolution, center=true );
    }
    translate([left_wall_inside_offset + m4_side_offset, back_wall_inside_offset + m4_back_offset, bottom_wall_offset ]) {
        cylinder( d=m4_dia, h=wall_thk + corner_rad + 1, $fn=resolution, center=true );
    }
    
    // side holes (all m4)
    // ============
    translate([ right_wall_offset, back_wall_inside_offset + m4side_back_offset, m4side_center_offset/2 ]) {
        rotate([ 0, 90, 0 ]) {
            cylinder( d=m4_dia, h=wall_thk + corner_rad + 1, $fn=resolution, center=true );
        }
    }
    translate([ right_wall_offset, back_wall_inside_offset + m4side_back_offset, -m4side_center_offset/2 ]) {
        rotate([ 0, 90, 0 ]) {
            cylinder( d=m4_dia, h=wall_thk + corner_rad + 1, $fn=resolution, center=true );
        }
    }
    /*translate([ left_wall_offset, back_wall_inside_offset + m4side_back_offset, m4side_center_offset/2 ]) {
        rotate([ 0, 90, 0 ]) {
            cylinder( d=m4_dia, h=wall_thk + corner_rad + 1, $fn=resolution, center=true );
        }
    }*/
    translate([ left_wall_offset, back_wall_inside_offset + m4side_back_offset, -m4side_center_offset/2 ]) {
        rotate([ 0, 90, 0 ]) {
            cylinder( d=m4_dia, h=wall_thk + corner_rad + 1, $fn=resolution, center=true );
        }
    }
}

module side_cutouts() {
    translate( [ right_wall_offset, back_wall_inside_offset + side_cutout_len/2 + side_cutout_len_offset, 0 ] ) {
        cube([ wall_thk*2 + corner_rad + 1, side_cutout_len, side_cutout_hgt ], center=true );
    }
    
    translate( [ left_wall_offset, back_wall_inside_offset + side_cutout_len/2 + side_cutout_len_offset, 0 ] ) {
        cube([ wall_thk*2 + corner_rad + 1, side_cutout_len, side_cutout_hgt ], center=true );
    }
}

module top_cutouts() {
    translate([ top_cutout_cen_wth/2 + top_cutout_wth/2, back_wall_inside_offset + top_cutout_len_offset + top_cutout_len/2, top_wall_offset ]) {
        cube([ top_cutout_wth, top_cutout_len, wall_thk + corner_rad + 1 ], center=true );
    }
    
    translate([ -top_cutout_cen_wth/2 - top_cutout_wth/2, back_wall_inside_offset + top_cutout_len_offset + top_cutout_len/2, top_wall_offset ]) {
        cube([ top_cutout_wth, top_cutout_len, wall_thk + corner_rad + 1 ], center=true );
    }
}

// main body
union() {
    difference() {
        minkowski() {
            cube([ wth + wall_thk * 2, overall_len + wall_thk, hgt + wall_thk * 2 ], center=true );
            sphere( r=corner_rad, $fn=resolution );
        }
        translate([ 0, corner_rad/2, 0 ]) {
            cube([ wth, overall_len + corner_rad, hgt ], center=true) ;
        }
        
        holes();
        side_cutouts();
        top_cutouts();
    }
    blocks();
}

color("blue") {
    //blocks();
    /*translate([0, back_wall_inside_offset + 5, 0]) {
        cube([ 10, 10, 10 ], center=true);
    }
    translate([0, 0, top_wall_offset ]) {
        cube([ 10, 10, 10 ], center=true);
    }
    translate([0, 0, bottom_wall_offset ]) {
        cube([ 10, 10, 10 ], center=true);
    }
    translate([left_wall_offset, 0, 0 ]) {
        cube([ 10, 10, 10 ], center=true);
    }
    translate([right_wall_offset, 0, 0 ]) {
        cube([ 10, 10, 10 ], center=true);
    }*/
}

/*
color("red") {
    translate([ 0, back_wall_inside_offset + term_len, bottom_wall_inside_offset + block_hgt/2 ]) {
        translate([ -wth/2, -wall_thk/2, block_hgt/2 ]) {
            rotate([ 180, 0, 90 ]) {
                mirror([1,0,0]) {
                    color("red"){
                    prism( block_hgt, wth, block_hgt );
                    }
                }
            }
        }
    }
    
    translate([ right_wall_inside_offset - block_hgt/2, back_wall_inside_offset + term_len, 0 ]) {
        translate([ -block_hgt/2, -wall_thk/2, -hgt/2 ]) {
            rotate([ 90, 0, 90 ]) {
                mirror([1,0,0]) {
                    color("red"){
                    prism( block_hgt, hgt, block_hgt );
                    }
                }
            }
        }
    }
    
    translate([ left_wall_inside_offset - block_hgt/2, back_wall_inside_offset + term_len, 0 ]) {
        translate([ -block_hgt/2 + block_hgt, -wall_thk/2 - block_hgt, -hgt/2 ]) {
            rotate([ 90, 0, 180 ]) {
                mirror([1,0,0]) {
                    color("red"){
                    prism( block_hgt, hgt, block_hgt );
                    }
                }
            }
        }
    }
}
*/