//------------------------------------------
// Dice RPGenerator v0.1
//------------------------------------------
// https://www.thingiverse.com/thing:1043661 Original
// https://www.thingiverse.com/thing:3472349 Modified
// This modification - Czerstwy

/* A few words from me

Thanks to TimEdwards and bronkula, without them I even could not dream about writing generator like this.

Most of my work here are code cleaning, renaming for easier understanding and extracting parameters outside modules, for easy generator control. Many thinks are hardcoded before that... a lot still are ;)

Some comments are in Polish, becouse, suprise suprise, I'm from Poland. Probably you don't need them, but they are helpfull for me. In future they probably disappear or they will be translated. And all this probably have a lot of syntax and punctuation mistakes, sory :P

I wanted to make this generator for easy dice making. I do not know if I will stay in this hobby, so don't guarantee to update this. But I belive that this work can make extremely easier make your own design. Even if I spend much less time on this than my predecessors ;)

Happy dicemaking!

*/
/* How to customize your set
------------------------------------------
Before many modules, you have a lot of parameters to play with:

//use <font.tff> - you can use font from file, instead from system. You still need proper font name in next variable
font1 - global variable for your font, you need to instal that font in system, or use from file as above
dicesize - global variable for entire set
dXsize - size of each dice. After measuring and 3D printing, I came to that sizes, they have best proportions for me. Number after "dicesize" (in d4size) are correction multipler. It is simpler than recalculate all points of tetrahedron ;).

Text variables - you probably need adjust after any font changing:

dXtextdepth - % of dXsize. They tell you how deep numbers are. Watch out for d4, if numbers are to close to corner or edge, they can easly intersect between walls!
dXtextsize - % of dXsize. Simply, how big numbers are.
dXundersize - as above, just for "_" marks.
dXtextpush - some of dices have asymmetrical walls, this is offset for placing numbers. For d4 you can enter negative value (for any other one too, but for d4 it make even sense ;) ), in this case you, after rolling dice, read number at the bottom of the wall, instead of from corner.
dXunderpushY - as above, for "_" marks.
dice_to_draw - simply tells what dices will be rendered. You can write any combination of dices in format ["4","6","8","10","00","12","20"]

Next, they are text arrays. Probably you don't need  change them, but if you need, there are here. For example you can add "_" marks for d00 if you like.
------------------------------------------
*/
/*What works well
- Easy changing font 
- Scaling entire sets and individual dices
- Scaling numbers and underscores
- Positioning numbers and underscores
- satisfactory control over generating sets
*/
/* And what don't?
- limits in size - they are resonably large, but they are
- Good positioning underscores isn't easy
*/
/* Plans for future
- More transparent code!
- separate configuration file
- Parametric rounding 
- Parametric chamfering
- Easy change font of min and/or max numbers (for example - to use with symbols from fonts)
- Easy change min and/or max numbers into symbols (critical failure/hit symbols) from external files
- Easy change any numbers into symbols from external files
*/
/*  
d4 - 1 - 7568
d6 - 1.1 - 4345
d8 - 1 - 5214

*/
//use <font.tff>
font1 = "Josefin Slab";
dicesize = 16; 

//cube size coefficients
d4size = 1.125*dicesize*1.224956;
d6size = dicesize;
d8size = dicesize;
d10size = dicesize;
d00size = dicesize;
d12size = 1.125*dicesize;
d20size = 1.25*dicesize;

// digit depth, defined as% of the cube's height
d4textdepth = 2.5;
d6textdepth = 2.5;
d8textdepth = 2.5;
d10textdepth = 2.5;
d00textdepth = 2.5;
d12textdepth = 2.5;
d20textdepth = 4;

// text size multiplier as a % of cube height
d4textsize = 30;
d6textsize = 55;
d8textsize = 45;
d10textsize = 37;
d00textsize = 37;
d12textsize = 31;
d20textsize = 25;

//incremental scale
d10undersize = 30;
d00undersize = 35;
d12undersize = 25;
d20undersize = 30;

//offset numbers from the center of the dice as a% of dice height
d4textpush = 20;
d10textpush = 16.5;

//offset the 6 / 9 _ or .
d10underpush6 = 15;
d10underpush9 = 15;
d00underpush6 = 25;
d00underpush9 = 35;
d12underpush6 = 13;
d12underpush9 = 15;
d20underpush6 = -10;
d20underpush9 = -11;

//What dices you would like to draw?
//dice_to_draw = ["4","6","8","10","00","12","20"];
dice_to_draw = ["20"];

//text d4
d4text=["1", "2", "3", "4", "3", "2", "4", "2", "1", "4", "1", "3"]; 

//text d6 and d8
textvals=["1", "2", "3", "4", "5", "6", "7", "8","9", "10", "11", "12", "13","14", "15","16", "17", "18", "19", "20"];

//text d12
d12text=["2", "11", "4", "9", "6", "7", "5", "8", "3", "10"];                    

//underscore d12
d12underscore=[" ", " ", " ", ".  ", "   .", " ", " ", " ", " ", " ", " ", " "];      

d10underscore=[" ", ".  ", " ", " ", " ", " ", "   .", " ", " ", " ", " ", " "];     //underscore d10
d00underscore=[" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "];     //underscore d00
d10text=["0", "9", "8", "1", "2", "7", "6", "3", "4", "5"];                       //text d10
d00text=["00", "90", "80", "10", "20", "70", "60", "30", "40", "50"];            //text d00
underscore=[" ", " ", " ", " ", " ",
            " ", " ", " ", " ", " ",
            "   .", " ", "  .", " ", " ",
            " ", " ", " ", " ", " "];        //underscore d20
d20text=["12", "1", "16", "4", "20",
         "15", "3", "11", "17", "13", 
         "6", "2", "9", "7", "18",
         "8", "5", "19", "10", "14"];  //text d20

/*Modules section, don't mess with this, if you don't know what you do!*/


/*kosc k4 */
// drawing a block d4
module dice4(height) {
    scale([height, height, height]) {	// Scale by height parameter
        polyhedron(
            points = [
                [-0.288675, 0.5, -0.20417],
                [-0.288675, -0.5, -0.20417],
                [0.57735, 0, -0.20417],
                [0, 0, 0.612325]
            ],
            faces = [
                [1, 2, 0],
                [3, 2, 1],
                [3, 1, 0],
                [2, 3, 0]
            ]
        );
    }
}

// text na d4
module dice4text(height) {
    
    text_multiplier = d4textsize * height / 100;
    text_depth = d4textdepth * height / 100;
    text_push = d4textpush * height / 100;
    rotate([180, 0, 0])
    translate([0, 0, 0.2041081 * height - text_depth])
    for (i = [0:2]) { 
        rotate([0, 0, 120 * i])
        translate([text_push, 0, 0])
        rotate([0, 0, -90])
        linear_extrude(height)
        text(d4text[i], size=text_multiplier, valign="center", halign="center", font=font1);
    }

    for (j = [0:2]) { 
        rotate([0, -70.5288, j * 120])
        translate([0, 0, 0.2041081 * height - text_depth])
        for (i = [0:2]) {
            rotate([0, 0, 120 * i])
            translate([text_push, 0, 0])
            rotate([0, 0, -90])
            linear_extrude(height)
            text(d4text[(j + 1) * 3 + i], size=text_multiplier, valign="center", halign="center", font=font1);
        }
    }
}

//kompletna d4
module d4draw() {
    translate ([0, 0, d4size * 0.2])
    difference() {
        intersection() {dice4(d4size);}
        dice4text(d4size);
        }
}
//

/*kosc k6 */
// rysowanie bryly d6
module dice6(height) {cube(height, center = true);}
// text na d6
module dice6text(height) {

    text_multiplier = d6textsize * height / 100;
    text_depth = d6textdepth * height / 100;
    rotate([0, 0, 180])
    translate([0, 0, 0.5 * height - text_depth])
	linear_extrude(height)
	text("1", size=text_multiplier, valign="center", halign="center", font=font1);

    translate([0, 0, -0.5 * height + 1])
    rotate([0, 180, 180])
    linear_extrude(height)
	text("6", size=text_multiplier, valign="center", halign="center", font=font1);

    // Loop i from 0 to 2, and intersect results
    for (i = [0:1]) { 
        rotate([90, 0, 90 * i]) {
            translate([0, 0, 0.5 * height - text_depth])
            linear_extrude(height)
            text(textvals[i*2 + 1], size=text_multiplier,
                valign="center", halign="center", font=font1);

            translate([0, 0, -0.5 * height + text_depth])
            rotate([0, 180, 180])
            linear_extrude(height)
            text(textvals[4 - i*2], size=text_multiplier,
                valign="center", halign="center", font=font1);
        }
    }
}
//kompletna d6
module d6draw() {
    translate ([0, 0, d6size*0.5])
    difference() {
        intersection()  {dice6(d6size);}
        dice6text(d6size);
        }
}



//

/*kosc k8 */
// rysowanie bryly d8
module dice8(height) {
    intersection() {
        // Make a cube
        cube([2 * height, 2 * height, height], center = true); 

        // Loop i from 0 to 2, and intersect results
        intersection_for(i = [0:2]) { 
            // Make a cube, rotate it 109.47122 degrees around the X axis,
            // then 120 * i around the Z axis
            rotate([109.47122, 0, 120 * i])
            cube([2 * height, 2 * height, height], center = true); 
        }
    }
}
// text na d8
module dice8text(height) {
    
    text_multiplier = d8textsize * height / 100;
    text_depth = d8textdepth * height / 100;
    rotate([0, 0, 180])
    translate([0, 0, 0.5 * height - text_depth])
    linear_extrude(height*10)
	text("1", size=text_multiplier, valign="center", halign="center", font=font1);

    translate([0, 0, -0.5 * height + text_depth])
    rotate([0, 180, 180])
    linear_extrude(height)
	text("8", size=text_multiplier, valign="center", halign="center", font=font1);

    // Loop i from 0 to 2, and intersect results
    for (i = [0:2]) { 
        rotate([109.47122, 0, 120 * i]) {
            translate([0, 0, 0.5 * height - text_depth])
            linear_extrude(height)
            text(textvals[i*2 + 1], size=text_multiplier, valign="center", halign="center", font=font1);

            translate([0, 0, -0.5 * height + text_depth])
            rotate([0, 180, 180])
            linear_extrude(height)
            text(textvals[6 - i*2], size=text_multiplier, valign="center", halign="center", font=font1);
        }
    }
}


//kompletna d8
module d8draw() {
    translate ([0, 0, d8size*0.5]) {
    difference() {
        intersection() {dice8(d8size);}
        dice8text(d8size);
        }
    }
}
//

// rysowanie bryly d10
module dice10(height) {
    slope = 132;
    cut_modifier = 1.43;
    
    rotate([48, 0, 0])
    intersection() {
        intersection() {
        // Make a cube
        cube([2 * height, 2 * height, height*2], center = true); 

        // Loop i from 0 to 4, and intersect results
        intersection_for(i = [0:4]) { 
            // Make a cube, rotate it 116.565 degrees around the X axis,
            // then 72 * i around the Z axis
            rotate([0, 0, 72 * i])
            rotate([slope, 0, 0])
            cube([2 * height, 2 * height, height], center = true); 
        }
        
    }
}
}

// text na d10
module dice10text(height,dXtextsize,dXundersize,dXunderpush6,dXunderpush9,slope,text_array,underscore_array) {
        
    text_multiplier = dXtextsize * height / 100;
    text_depth = d10textdepth * height / 100;
    under_multiplier = dXundersize * height / 100;
    text_push = d10textpush*height/100;
    
    // Loop i from 0 to 4, and intersect results
    for (i = [0:4]) { 
        rotate([0, 0, 72 * i])
        rotate([slope, 0, 0]) {
            translate([0, text_push, 0.5 * height - text_depth])
            linear_extrude(height)
            text(text_array[i*2], size=text_multiplier, valign="center", halign="center", font=font1);

            translate([0, text_push+(-height*dXunderpush6/100), 0.5 * height - text_depth])
            linear_extrude(height)
            text(underscore_array[i*2], size=under_multiplier, valign="center", halign="center", font=font1);

            translate([0, -text_push, -0.5 * height + text_depth])
            rotate([0, 180, 180])
            linear_extrude(height)
            text(text_array[i*2+1], size=text_multiplier, valign="center", halign="center", font=font1);

            translate([0, -text_push+(height*dXunderpush9/100), -0.5 * height + text_depth])
            rotate([0, 180, 0])
            linear_extrude(height)
            text(underscore_array[i*2+1], size=under_multiplier, valign="center", halign="center", font=font1);
        }
    }
}

//kompletna d10
module d10draw() {
    translate ([0, 0, d10size*0.5]) {
        difference() {
            dice10(d10size);
            rotate([48, 0, ])
            dice10text(d10size,d10textsize,d10undersize,d10underpush6,d10underpush9,132,d10text,d10underscore);
            
        }
    }
}


//

// rysowanie bryly d00
// text na d00
//kompletna d00
module d00draw() {
    translate ([0, 0, d10size*0.5]) {
        difference() {
            dice10(d10size);
            rotate([48, 0, ])
            dice10text(d00size,d00textsize,d00undersize,d00underpush6,d00underpush9,132,d00text,d00underscore);
        }
    }
}

//
/*kosc k12 w trakcie*/
// rysowanie bryly d12
module dice12(height,slope) {
    intersection() {
        // Make a cube
        cube([2 * height, 2 * height, height], center = true); 

        // Loop i from 0 to 4, and intersect results
        intersection_for(i = [0:4]) { 
            // Make a cube, rotate it 116.565 degrees around the X axis,
            // then 72 * i around the Z axis
            rotate([0, 0, 72 * i])
            rotate([slope, 0, 0])
            cube([2 * height, 2 * height, height], center = true); 
        }
    }
}
// text na d12
module dice12text(height,slope) {
    
    text_multiplier = d12textsize * height / 100;
    text_depth = d12textdepth * height / 100;
    under_multiplier = d12undersize * height / 100;
    
    rotate([0, 0, 180])
    translate([0, 0, 0.5 * height - text_depth])
    linear_extrude(height)
	text("12", size=text_multiplier, valign="center", halign="center", font=font1);

    translate([0, 0, -0.5 * height + text_depth])
    rotate([0, 180, 0])
    linear_extrude(height)
	text("1", size=text_multiplier, valign="center", halign="center", font=font1);
        
    // Loop i from 0 to 4, and intersect results
    for (i = [0:4]) { 
        rotate([0, 0, 72 * i])
        rotate([slope, 0, 0]) {
            translate([0, 0, 0.5 * height - text_depth])
            linear_extrude(height)
            text(d12text[i*2], size=text_multiplier, valign="center", halign="center", font=font1);

            //podkreslnik pod 6
            translate([0, 0+(-height*d12underpush6/100), 0.5 * height - text_depth])
            linear_extrude(height)
            text(d12underscore[i*2], size=under_multiplier, valign="center", halign="center", font=font1);

            translate([0, 0, -0.5 * height + text_depth])
            rotate([0, 180, 180])
            linear_extrude(height)
            text(d12text[i*2+1], size=text_multiplier, valign="center", halign="center", font=font1);

            //podkreslnik pod 9
            translate([0, 0+(height*d12underpush9/100), -0.5 * height + text_depth])
            rotate([0, 180, 0])
            linear_extrude(height)
            text(d12underscore[i*2 + 1], size=under_multiplier, valign="center", halign="center", font=font1);
        }
    
}
    
}
//kompletna d12
module d12draw() {
    translate ([0, 0, d12size*0.5]) {
    difference() {
            intersection() {dice12(d12size,116.565);
            }
            dice12text(d12size,116.565);
        }
    }
}

//
/*kosc k20 */
// rysowanie bryly d20
module dice20(height) {
    intersection() {
        dice8(height);

        rotate([0, 0, 60 -15.525])
            dice8(height);

        intersection_for(i = [1:3]) { 
            rotate([0, 0, i * 120])
            rotate([109.471, 0, 0])
            rotate([0, 0, -15.525])
            dice8(height);
        }
    }
}
// text na d20
module dice20text(height) {

    rotate([70.5288, 0, 60])
    dice20half(height, 0);

    rotate([0, 0, 60 -15.525]) {
        dice20half(height, 4);
    }

    for(i = [1:3]) { 
        rotate([0, 0, i * 120])
        rotate([109.471, 0, 0])
        rotate([0, 0, -15.525])
	    dice20half(height, 4 + i * 4);
    }
}

module dice20half(height, j) {
    
    text_multiplier = d20textsize * height / 100;
    text_depth = d20textdepth * height / 100;
    under_multiplier = d20undersize * height / 100;
    rotate([0, 0, 180]) {
        rotate([0, 0, 39])
        translate([0, 0, 0.5 * height - text_depth])
        linear_extrude(height)
        text(d20text[j], size=text_multiplier, valign="center", halign="center", font=font1);

        rotate([0, 0, 39])
        translate([0, height*d20underpush9/100, 0.5 * height - text_depth])
        linear_extrude(height)
        text(underscore[j], under_multiplier, valign="center", halign="center", font=font1);
    }

    // Loop i from 0 to 2, and intersect results
    for (i = [0:2]) { 
        rotate([109.47122, 0, 120 * i]) {
            rotate([0, 0, 39])
            translate([0, 0, 0.5 * height - text_depth])
            linear_extrude(height)
            text(d20text[i + j + 1], size=text_multiplier, valign="center", halign="center", font=font1);

            rotate([0, 0, 39])
            translate([0, height*d20underpush6/100, 0.5 * height - text_depth])
            linear_extrude(height)
            text(underscore[i + j + 1], size=under_multiplier, valign="center", halign="center", font=font1);
        }
    }
}

//kompletna d20
module d20draw() {
    translate ([0, 0, d20size*0.5]) {
        difference() {
            intersection() {
                dice20(d20size);
            }
            dice20text(d20size);
        }
    }
}
//
/* moduły rysowania kostek, rysuje i rozstawia kostki w przestrzeni*/

positions = [
    [[0,0,0]],
    [[-dicesize,0,0],[dicesize,0,0]],
    [[-(2*dicesize),0,0],[0,0,0],[(2*dicesize),0,0]],
    [[-dicesize,-dicesize,0],[dicesize,-dicesize,0],[-dicesize,dicesize,0],[dicesize,dicesize,0]],
    [[-(2*dicesize),(2*dicesize),0],[-(2*dicesize),-(2*dicesize),0],[0,0,0],[(2*dicesize),(2*dicesize),0],[(2*dicesize),-(2*dicesize),0]],
    [[-(2*dicesize),(2*dicesize),0],[-(2*dicesize),-(2*dicesize),0],[0,0,0],[(2*dicesize),(2*dicesize),0],[(2*dicesize),-(2*dicesize),0],[(4*dicesize),-(2*dicesize),0]],
    [[-(2*dicesize),(2*dicesize),0],[-(2*dicesize),-(2*dicesize),0],[0,0,0],[(2*dicesize),(2*dicesize),0],[(2*dicesize),-(2*dicesize),0],[(4*dicesize),-(2*dicesize),0],[(4*dicesize),(2*dicesize),0]]
];
module drawWhich(which) {
    if(which=="4") d4draw();
    if(which=="6") d6draw();
    if(which=="8") d8draw();
    if(which=="10") d10draw();
    if(which=="00") d00draw();
    if(which=="12") d12draw();
    if(which=="20") d20draw();
}

module drawPolyset(polyset=["4","6","8","10","00","12","20"]) {
    polylength = len(polyset)-1;
    for(i = [0:polylength]) {
        translate(positions[polylength][i])
            drawWhich(polyset[i]);
    }
}

drawPolyset(dice_to_draw);