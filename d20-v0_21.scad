//------------------------------------------
// Dice RPGenerator v0.2
// By Czertwy - FreeBSD / BSD 2-Clause License
//------------------------------------------

/* A few words from me
------------------------------------------
I wanted to make this generator for easy dice making. I do not know if I will stay in this hobby, so don't guarantee to update this. But I belive that this work can make extremely easier make your own design. 

This time I used BOSL2 librarys. They are huge and make OpenSCAD more affordable for me. They are still in APLHA state, but for code here, work amazingly good ;) Here are Revarbat's Github: https://github.com/revarbat/BOSL2

About licensing. BOSL2 are on BSD 2-Clause License and I would like keep that for my work. License says:

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

So, you can used them as you want, with commercial use included.

Happy dicemaking!
------------------------------------------
*/
include <BOSL2/std.scad>
include <BOSL2/polyhedra.scad>
$fn = $preview ? 30 : 100 ;

/* How to customize your set
------------------------------------------
You have a lot of parameters to play with:

//use <font.tff> - you can use font from file, instead from system. You still need proper font name in next variable

usefont/useunderfont/usesymbolfont - global variable for your font, you need to instal that font in system, or use from file as above

dicesize - global variable for entire set

roundsize - global variable for rounding edges of dices. If "0", edges will be sharp.

dXsize - size of each dice. After measuring and 3D printing, I came to that sizes, they have best proportions for me.

dXtextdepth - in mm. They tell you how deep numbers are. Watch out for d4, if numbers are to close to corner or edge, they can easly intersect between walls!

dXtextsize - % of dXsize. Simply, how big numbers are.

dXundersize - as above, just for underscores.

dXtextpush - some of dices have asymmetrical walls, this is offset for placing numbers and this is mainly for them (d4/d10/d00). "0" means that number are in center of assigned face. Positive values move number down, and negative - up.
dXunderpush - as above, for underscores.

When you would like to render results, hit F5 for preview, and if you are sure enough, hit F6. Because of the rounding possibility, render time are much longer than simply preview.
------------------------------------------
*/

//dice to draw, simply "//" before dice you don't want, like for example d8

//d4();
//right(2*dicesize) d6();
//right(4*dicesize) d8();
//left(2*dicesize) d10();
//left(4*dicesize) d00();
//left(6*dicesize) d12();
//right(12*dicesize) d20();
d00();
left(2*dicesize) d10();


// #*dicesize moves it in the plane, can adjust to more easily work on 1 dice

//config section

//use <font.tff>
usefont = "Font 1 fixed";
// font from Elizabeth Comer
useunderfont = "Berlin Sans FB";
usesymbolfont = "Courier New";

dicesize=16;
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
d4textdepth = 1;
d6textdepth = 1;
d8textdepth = 1;
d10textdepth = 1;
d00textdepth = 1;
d12textdepth = 1;
d20textdepth = 1;

//text size ratio as % of dice size
d4textsize = 23;
d6textsize = 35;
d8textsize = 35;
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