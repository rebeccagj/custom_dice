font = "Fabrik"; 

cube_size = 60; // in mm
letter_size = 5; // in mm
letter_depth = 1; // in mm
width1 = 6; //sets the 'base' size aka how thicc it gets
numberangle1 = 3.8;  // has to be adjusted if you change width; soon I'll update this to compute automatically
width2 = 5; //sets the 'base' size aka how thicc it gets
numberangle2 = 3.0;  // has to be adjusted if you change width; soon I'll update this to compute automatically

module letter(l) {
	linear_extrude(height = letter_depth) { 
		text(l, 
        size = letter_size, 
        font = font, 
        halign = "center", 
        valign = "center", 
        $fn = 4);
	} // linear_extrude() makes letters 3D objects 

}

//larger object
/*
translate([20,0,0]) {
difference(){ // difference will subtract the second object from the first
  polyhedron( //first object is the shank d4 base
    points = [
      [width1,width1,0], // side
      [width1,-width1,0], // side
      [-width1,-width1,0], // side
      [-width1,width1,0], // side
      [0,0,25] // top apex
    ],
    faces = [
      [0, 1, 4], // 2 side; I'll be honest I'm not entire sure this works
      [1, 2, 4], // 3 side
      [2, 3, 4], // 4 side
      [3, 0, 4], // 1 side
      [1, 0, 3], // triangle half of base touching 1 and 2
      [2, 1, 3]  // triangle half of base touching 3 and 4
    ]
  );
   // (x, y, z)
  union() { // second object is all the text
    color("blue") translate([0,numberangle1,width1]) rotate([-79, 0, 0]) letter("1");
	color("red") translate([numberangle1,0,width1]) rotate([79,0,90])  letter("2");
	color("green") translate([0,-numberangle1,width1]) rotate([79, 0, 0]) letter("3");
	color("grey") translate([-numberangle1,0,width1]) rotate([79, 0, -90]) letter("4");
    }
}
//beveled bottom for larger dice
translate([20,0,-2]){
    rotate([0,0,45]){
cylinder(2,2,8.5,$fn=4);
}
}
}
*/

translate([0,0,0]) {
difference(){ // difference will subtract the second object from the first
  polyhedron( //first object is the shank d4 base
    points = [
      [width2,width2,0], // side
      [width2,-width2,0], // side
      [-width2,-width2,0], // side
      [-width2,width2,0], // side
      [0,0,17] // top apex
    ],
    faces = [
      [0, 1, 4], // 2 side; I'll be honest I'm not entire sure this works
      [1, 2, 4], // 3 side
      [2, 3, 4], // 4 side
      [3, 0, 4], // 1 side
      [1, 0, 3], // triangle half of base touching 1 and 2
      [2, 1, 3]  // triangle half of base touching 3 and 4
    ]
  );
   // (x, y, z)
  union() { // second object is all the text
    color("blue") translate([0,numberangle2-.2,width2]) rotate([-100, 180, 0]) letter("1");
	color("red") translate([numberangle2,0,width2]) rotate([79,0,90])  letter("2");
	color("green") translate([0,-numberangle2,width2]) rotate([79, 0, 0]) letter("3");
	color("grey") translate([-numberangle2,0,width2]) rotate([79, 0, -90]) letter("4");
    }
}
}



//beveled bottom for smaller dice
translate([0,0,-2]){
    rotate([0,0,45]){
cylinder(2,3,7,$fn=4);
}
}
