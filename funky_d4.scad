font = "Font 1 fixed"; // from Elizabeth Comer in FB Dice Making Discoveries

cube_size = 60; // in mm
letter_size = 5; // in mm
letter_depth = 1; // in mm
width = 6; //sets the 'base' size aka how thicc it gets
numberangle = 3.8;  // has to be adjusted if you change width; soon I'll update this to compute automatically

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

difference(){ // difference will subtract the second object from the first
  polyhedron( //first object is the shank d4 base
    points = [
      [width,width,0], // side
      [width,-width,0], // side
      [-width,-width,0], // side
      [-width,width,0], // side
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
    color("blue") translate([0,numberangle,width]) rotate([-79, 0, 0]) letter("1");
	color("red") translate([numberangle,0,width]) rotate([79,0,90])  letter("2");
	color("green") translate([0,-numberangle,width]) rotate([79, 0, 0]) letter("3");
	color("grey") translate([-numberangle,0,width]) rotate([79, 0, -90]) letter("4");
    }
}