//------------------------------------------
// Dice RPGenerator v0.2
// By Czertwy - FreeBSD / BSD 2-Clause License
//------------------------------------------

include <BOSL2/std.scad>
include <BOSL2/polyhedra.scad>
$fn = $preview ? 30 : 100 ;

//dice to draw

/*d4();
right(1.5*dicesize) d6();
right(3*dicesize) d8();
left(1.5*dicesize) d10();
left(3*dicesize) d00();
left(4.6*dicesize) d12();
right(4.6*dicesize) */d20();
    
// #*dicesize moves it in the plane, can adjust to more easily work on 1 dice

//config section
usefont = "Fabrik";
useunderfont = "Berlin Sans FB";
usesymbolfont = "Courier New";

dicesize=55;
roundsize=0;

//dice size ratio
d4size = 1.125*dicesize;
d6size = dicesize;
d8size = dicesize;
d10size = dicesize;
d00size = dicesize;
d12size = 1.125*dicesize;
d20size = 1.25*dicesize;

//depth of numbers in w mm
depth = 1;
d4textdepth = depth;
d6textdepth = depth;
d8textdepth = depth;
d10textdepth = depth;
d00textdepth = depth;
d12textdepth = depth;
d20textdepth = depth;

//text size ratio as % of dice size
d4textsize = 25;
d6textsize = 40;
d8textsize = 40;
d10textsize = 30;
d00textsize = 30;
d12textsize = 30;
d20textsize = 23;

//underscore size ratio as % of dice size
d4undersize = 17.5;
d6undersize = 50;
d8undersize = 45;
d10undersize = 35;
d00undersize = 0;
d12undersize = 30;
d20undersize = 25;

//text push ratio from center of face as % of dice size
d4textpush = -25;
d6textpush = 0;
d8textpush = 0;
d10textpush = -5;
d00textpush = 0;
d12textpush = 0;
d20textpush = 2;

//underscore push ratio from center of face as % of dice size
d4underpush = -15;
d6underpush = 30;
d8underpush = 25;
d10underpush = 12.5;
d00underpush = 0;
d12underpush = 12;
d20underpush = 10;

/*  pattern variables
------------------------------------------
For any one dice you have 4 arrays to play with:

dXtext: order of characters on dice - default it is set like for most market dices

dXsymbols: as above, second array to use with another font - default all variables are "undef"
If you would like use second font, write in appropriate value of "dxtext" an undef value, and in "dxsymbols" write char with chosen symbol or whatever you like.

dXunderscore: as dxtext but mainly for underscore (under 6 and 9 for example)
If you like dot instead underscore, write them after number in "dxtext" or "dxsymbols", not here.

dXrot: variables with degree of rotation from original position of number.
------------------------------------------
*/
d4text=["1", "4", "1", "1", "3", "3", "4", "4", "2", "2", "2", "3"]; //text d4
d4symbols=[undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef]; //symbols d4
d4underscore=[" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "]; //underscore d4
d4rot=[0,0,0,0 ,0,0,0,0 ,0,0,0,0]; //rotating text d4

d6text=["1", "3", "2", "4", "5", "6"]; //text d6
d6symbols=[undef, undef, undef, undef, undef, undef]; //symbols d6
d6underscore=[" ", " ", " ", " ", " ", " "]; //underscore d6
d6rot=[0,0,0,0,0,0];//rotating text d6

d8text=["1", "3", "2", "4", "5", "7", "8", "6"]; //text d8
d8symbols=[undef, undef, undef, undef, undef, undef, undef, undef]; //symbols d8
d8underscore=[" ", " ", " ", " ", " ", " ", " ", " "]; //underscore d8
d8rot=[0,0,0,0,0,0,0,0]; //rotating text d8


d10text=["9.", "1", "7", "5", "3", "6.", "2", "4", "10", "8"]; //text d10
d10symbols=[undef, undef, undef, undef, undef, undef, undef, undef, undef, undef]; //symbols d10
d10underscore=[" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "]; //underscore d10
d00text=["90", "10", "70", "50", "30", "60", "20", "40", "00", "80"]; //text d00
d00symbols=[undef, undef, undef, undef, undef, undef, undef, undef, undef, undef]; //symbols d00
d00underscore=[" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "]; //underscore d00
d10d00rot=[0,0,0,0,0,0,0,0,0,0];//rotating text d10 and d00


d12text=["1", "5", "6.", "4", "10", "11", "2", "3", "9.", "8", "7", "12"]; //text d12
d12symbols=[undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef]; //symbols d12
d12underscore=[" ", "   ", " ", " ", " ", " ", " ", " ", "  ", " ", " ", " "]; //underscore d12
d12rot=[0,0,0,0,0,0,0,0,0,0,0,0]; //rotating text d12

d20text=["18", "2", "4", "5", "20", "14", "12", "15", "11", "13", "8", "10", "6 ", "9", "16", "7", "1", "17", "3", "19"];  //text d20
d20symbols=[undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef]; //symbols d20
//d20underscore=[" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "  .", "  .", " ", " ", " ", " ", " ", " "]; //underscore d20
d20underscore=[" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "  .", "  .", " ", " ", " ", " ", " ", " "]; //underscore d20
d20rot=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];//rotating text d20




//generation section - probably you dont need change anything here ;)

module d4(){
difference(){
    text_multiplier = d4textsize * d4size / 100;
    under_multiplier = d4undersize * d4size / 100;
    based4rot=[-15,15,15,15 ,105,255,255,135 ,225,135,135,255];
    
    
    //render polyhedron
    regular_polyhedron("tetrahedron", side=sqrt(3/2)*(d4size+roundsize), facedown=true, anchor=BOTTOM, rounding=roundsize);
    
    //render numbers
    for(i=[0,1,2])
    regular_polyhedron("tetrahedron", side=sqrt(3/2)*(d4size+roundsize), facedown=true, anchor=BOTTOM, draw=false)
    zrot(d4rot[$faceindex+i*4]+ based4rot[$faceindex+i*4])
    down(d4textdepth) linear_extrude(height=2*d4textdepth)
    fwd(d4textpush*d4size/100)
    text(d4text[$faceindex+i*4], size=text_multiplier, font=usefont, halign="center",valign="center");
    
    //render symbols
    for(i=[0,1,2])
    regular_polyhedron("tetrahedron", side=sqrt(3/2)*(d4size+roundsize), facedown=true, anchor=BOTTOM, draw=false)
    zrot(d4rot[$faceindex+i*4]+ based4rot[$faceindex+i*4])
    down(d4textdepth) linear_extrude(height=2*d4textdepth)
    fwd(d4textpush*d4size/100)
    text(d4symbols[$faceindex+i*4], size=text_multiplier, font=usesymbolfont, halign="center",valign="center");
    
    //render underscore
    for(i=[0,1,2])
    regular_polyhedron("tetrahedron", side=sqrt(3/2)*(d4size+roundsize), facedown=true, anchor=BOTTOM, draw=false)
    zrot(d4rot[$faceindex+i*4]+ based4rot[$faceindex+i*4])
    down(d4textdepth) linear_extrude(height=2*d4textdepth)
    fwd(d4underpush*d4size/100)
    text(d4underscore[$faceindex+i*4], size=under_multiplier, font=useunderfont, halign="center",valign="center");
}
}

module d6(){
difference(){
    text_multiplier = d6textsize * d6size / 100;
    under_multiplier = d6undersize * d6size / 100;
    based6rot=[0,270,180,90,0,180];
    
    //render polyhedron
    regular_polyhedron("cube", side=d6size, facedown=true, anchor=BOTTOM, rounding=roundsize);
    
    //render numbers
    regular_polyhedron("cube", side=d6size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d6rot[$faceindex]+based6rot[$faceindex])
    down(d6textdepth) linear_extrude(height=2*d6textdepth)
    fwd(d6textpush*d6size/100)
    text(d6text[$faceindex], size=text_multiplier, font=usefont, halign="center",valign="center");
    
    //render symbols
    regular_polyhedron("cube", side=d6size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d6rot[$faceindex]+based6rot[$faceindex])
    down(d6textdepth) linear_extrude(height=2*d6textdepth)
    fwd(d6textpush*d6size/100)
    text(d6symbols[$faceindex], size=text_multiplier, font=usesymbolfont, halign="center",valign="center");
    
    //render underscore
    regular_polyhedron("cube", side=d6size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d6rot[$faceindex]+based6rot[$faceindex])
    down(d6textdepth) linear_extrude(height=2*d6textdepth)
    fwd(d6underpush*d6size/100)
    text(d6underscore[$faceindex], size=under_multiplier, font=useunderfont, halign="center",valign="center");
    
}
}
module d8(){
difference(){
    text_multiplier = d8textsize * d8size / 100; 
    under_multiplier = d8undersize * d8size / 100;
    based8rot=[165,195,315,195,195,195,15,75];
    
    //render polyhedron
    regular_polyhedron("octahedron", side=sqrt(3/2)*d8size, facedown=true, anchor=BOTTOM, rounding=roundsize);
    
    //render numbers
    regular_polyhedron("octahedron", side=sqrt(3/2)*d8size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d8rot[$faceindex]+based8rot[$faceindex])
    down(d8textdepth) linear_extrude(height=2*d8textdepth)
    fwd(d8textpush*d8size/100)
    text(d8text[$faceindex], size=text_multiplier, font=usefont, halign="center",valign="center");
    
    //render symbols
    regular_polyhedron("octahedron", side=sqrt(3/2)*d8size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d8rot[$faceindex]+based8rot[$faceindex])
    down(d8textdepth) linear_extrude(height=2*d8textdepth)
    fwd(d8textpush*d8size/100)
    text(d8symbols[$faceindex], size=text_multiplier, font=usesymbolfont, halign="center",valign="center");
    
    //render underscore
    regular_polyhedron("octahedron", side=sqrt(3/2)*d8size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d8rot[$faceindex]+based8rot[$faceindex])
    down(d8textdepth) linear_extrude(height=2*d8textdepth)
    fwd(d8underpush*d8size/100)
    text(d8underscore[$faceindex], size=under_multiplier, font=useunderfont, halign="center",valign="center");
}
}
module d10(){
difference(){    
    text_multiplier = d10textsize * d10size / 100; 
    under_multiplier = d10undersize * d10size / 100;
    based10d00rot=[54.25,306.25,306.25,306.25,306.25,254.25,357.75,177.75,126.25,74.25];
    
    //render polyhedron 
    d10d00base(d10size);
    
    //render numbers
    regular_polyhedron("trapezohedron",faces=10, side=0.4857*dicesize, longside=dicesize, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d10d00rot[$faceindex]+based10d00rot[$faceindex])
    down(d10textdepth) linear_extrude(height=2*d10textdepth)
    fwd(d10textpush*d10size/100)
    text(d10text[$faceindex], size=text_multiplier, font=usefont, halign="center",valign="center");
    
    //render symbols
    regular_polyhedron("trapezohedron",faces=10, side=0.4857*dicesize, longside=dicesize, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d10d00rot[$faceindex]+based10d00rot[$faceindex])
    down(d10textdepth) linear_extrude(height=2*d10textdepth)
    fwd(d10textpush*d10size/100)
    text(d10symbols[$faceindex], size=text_multiplier, font=usesymbolfont, halign="center",valign="center");
    
    //render underscore
    regular_polyhedron("trapezohedron",faces=10, side=0.4857*dicesize, longside=dicesize, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d10d00rot[$faceindex]+based10d00rot[$faceindex])
    down(d10textdepth) linear_extrude(height=2*d10textdepth)
    fwd(d10underpush*d10size/100)
    text(d10underscore[$faceindex], size=under_multiplier, font=useunderfont, halign="center",valign="center");
    
}
}
module d00(){
difference(){    
    text_multiplier = d00textsize * d00size / 100; 
    under_multiplier = d00undersize * d00size / 100;
    based10d00rot=[54.25,306.25,306.25,306.25,306.25,254.25,357.75,177.75,126.25,74.25];
    
    //render polyhedron 
    d10d00base(d00size);
    
    //render numbers
    regular_polyhedron("trapezohedron",faces=10, side=0.4857*dicesize, longside=dicesize, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d10d00rot[$faceindex]+based10d00rot[$faceindex])
    down(d00textdepth) linear_extrude(height=2*d00textdepth)
    fwd(d00textpush*d00size/100)
    text(d00text[$faceindex], size=text_multiplier, font=usefont, halign="center",valign="center");
    
    //render symbols
    regular_polyhedron("trapezohedron",faces=10, side=0.4857*dicesize, longside=dicesize, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d10d00rot[$faceindex]+based10d00rot[$faceindex])
    down(d00textdepth) linear_extrude(height=2*d00textdepth)
    fwd(d00textpush*d00size/100)
    text(d00symbols[$faceindex], size=text_multiplier, font=usesymbolfont, halign="center",valign="center");
    
    //render underscore
    regular_polyhedron("trapezohedron",faces=10, side=0.4857*dicesize, longside=dicesize, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d10d00rot[$faceindex]+based10d00rot[$faceindex])
    down(d00textdepth) linear_extrude(height=2*d00textdepth)
    fwd(d00underpush*d00size/100)
    text(d00underscore[$faceindex], size=under_multiplier, font=useunderfont, halign="center",valign="center");
    
}
}
module d10d00base(d10d00size){
    
    up(roundsize)
    minkowski()
    {
        scale((d10d00size-2*roundsize)/d10d00size){
        regular_polyhedron("trapezohedron",faces=10, side=0.4857*d10d00size, longside=d10d00size, facedown=true, anchor=BOTTOM); //, side=0.4857*dicesize, longside=dicesize
        }
        sphere(r=roundsize)
        ;  
    }
    
}

module d12(){
difference(){
    text_multiplier = d12textsize * d12size / 100;
    under_multiplier = d12undersize * d12size / 100;
    based12rot=[17.5,-17.5,-17.5,52.5,-17.5,-17.5,-87.5,125.5,-17.5,-17.5,197.5,-197.5];
    
    //render polyhedron
    regular_polyhedron("dodecahedron", ir=0.5*d12size, facedown=true, anchor=BOTTOM, rounding=roundsize);
    
    //render numbers
    regular_polyhedron("dodecahedron", ir=0.5*d12size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d12rot[$faceindex]+based12rot[$faceindex])
    down(d12textdepth) linear_extrude(height=2*d12textdepth)
    fwd(d12textpush*d12size/100)
    text(d12text[$faceindex], size=text_multiplier, font=usefont, halign="center",valign="center");
    
    //render symbols
    regular_polyhedron("dodecahedron", ir=0.5*d12size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d12rot[$faceindex]+based12rot[$faceindex])
    down(d12textdepth) linear_extrude(height=2*d12textdepth)
    fwd(d12textpush*d12size/100)
    text(d12symbols[$faceindex], size=text_multiplier, font=usesymbolfont, halign="center",valign="center");
    
    //render underscore
    regular_polyhedron("dodecahedron", ir=0.5*d12size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d12rot[$faceindex]+based12rot[$faceindex])
    down(d12textdepth) linear_extrude(height=2*d12textdepth)
    fwd(d12underpush*d12size/100)
    text(d12underscore[$faceindex], size=under_multiplier, font=useunderfont, halign="center",valign="center");
}
}

module d20(){
difference(){
    text_multiplier = d20textsize * d20size / 100;
    under_multiplier = d20undersize * d20size / 100;
    based20rot=[40,200,80,320,200,80,200,320,80,320,37.5,5,245,275,320,157.5,125,80,140,200];
    
    //render polyhedron
    regular_polyhedron("icosahedron", ir=0.5*d20size, facedown=true, anchor=BOTTOM, rounding=roundsize);
    
    //render numbers
    regular_polyhedron("icosahedron", ir=0.5*d20size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d20rot[$faceindex]+based20rot[$faceindex])
    down(d20textdepth) linear_extrude(height=2*d20textdepth)
    fwd(d20textpush*d20size/100)
    text(d20text[$faceindex], size=text_multiplier, font=usefont, halign="center",valign="center");
    
    //render symbols
    regular_polyhedron("icosahedron", ir=0.5*d20size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d20rot[$faceindex]+based20rot[$faceindex])
    down(d20textdepth) linear_extrude(height=2*d20textdepth)
    fwd(d20textpush*d20size/100)
    text(d20symbols[$faceindex], size=text_multiplier, font=usesymbolfont, halign="center",valign="center");
    
    //render underscore
    regular_polyhedron("icosahedron", ir=0.5*d20size, facedown=true, anchor=BOTTOM, draw=false)
    zrot(d20rot[$faceindex]+based20rot[$faceindex])
    down(d20textdepth) linear_extrude(height=2*d20textdepth)
    fwd(d20underpush*d20size/100)
    text(d20underscore[$faceindex], size=under_multiplier, font=useunderfont, halign="center",valign="center");
}
}