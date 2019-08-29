font = "Font 1 fixed";

cube_size = 60;
letter_size = 5;
letter_height = 1;
width = 6;
indent = 3.8;

module letter(l) {
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	linear_extrude(height = letter_height) {
		text(l, 
        size = letter_size, 
        font = font, 
        halign = "center", 
        valign = "center", 
        $fn = 4);
	}
}

difference(){
  polyhedron(
    points = [
      [width,width,0], //side
      [width,-width,0], //side
      [-width,-width,0], //side
      [-width,width,0], //side
      [0,0,25] //apex
    ],
    faces = [
      [0, 1, 4], //first four are triangle sides
      [1, 2, 4],
      [2, 3, 4],
      [3, 0, 4],
      [1, 0, 3], //square base
      [2, 1, 3]
    ]
  );
   // (x, y, z)
  union() {
    color("blue") translate([0,indent,width]) rotate([-79, 0, 0]) letter("1");
	color("red") translate([indent,0,width]) rotate([79,0,90])  letter("2");
	color("green") translate([0,-indent,width]) rotate([79, 0, 0]) letter("3");
	color("grey") translate([-indent,0,width]) rotate([79, 0, -90]) letter("4");
    }
}