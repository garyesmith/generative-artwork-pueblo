
// PUEBLO 
// A ProcessingJS/Canvas code-generated Spanish pueblo (village) by Gary Smith (https://www.genartive.com)
// For educational purposes only: please do not redistribute for profit unmodified.

int calcWidth=250; // theoretical canvas width to use for calculations
int calcHeight=250; // theoretical canvas height to use for calculations

// Initialize the canvas and draw the artwork elements
void setup() {

  // clear the background
  background(0,0,0,0);
  fill(0,0,0,0); 

  // there is no animating loop, just a static image
  noLoop(); 

  size(640,640);

  smooth(); // smooth rendering

  textAlign(CENTER,CENTER); // position text to be centered on x,y coords

  strokeJoin(ROUND);

  strokeWeight(calcWidth*0.010); 

  ellipseMode(CORNER);

  colorMode(HSB, 360, 100, 100); // set colour mode to HSB (Hue/Saturation/Brightness)

  background(0,0,100); // white  

  int hue1 = random(1,360); // main colour
  int hue2 = colorSplitComplementLeft(hue1); // left split complement to main colour
  int hue3 = colorSplitComplementRight(hue1); // right split complement to main colour
  var roofHue=random(20,40);

  // draw sky
  drawTexture('_', calcWidth*0.0320, 0.22, calcWidth*0.08, calcHeight*0.030, calcWidth*0.963, calcHeight*0.72, hue1, random(0,5), random(30,50), random(94,100), random(80,90));

  // determine color to use for mountains
  var mountainHue=random(0,100);
  if (mountainHue<=33) {
    mountainHue=hue1;
  } else if (mountainHue<=66) {
    mountainHue=hue2;
  } else {
    mountainHue=hue3;
  }

  // draw two overlapping sets of mountains
  drawMountains(calcWidth*0.018,calcHeight*random(0.25,0.35),calcWidth*0.965,calcHeight*0.15, color(mountainHue,40,45,5),calcWidth*0.003);
  drawMountains(calcWidth*0.018,calcHeight*random(0.36,0.55),calcWidth*0.965,calcHeight*0.25, color(mountainHue,40,45,40),calcWidth*0.003);
  drawMountains(calcWidth*0.018,calcHeight*random(0.50,0.70),calcWidth*0.965,calcHeight*0.15, color(mountainHue,30,25,50),calcWidth*0.003);

  // draw pueblo village on top of the mountains
  drawPueblo(calcWidth*0.015,calcHeight*random(0.40,0.65),calcWidth*0.972,calcHeight*0.25, hue1, hue2, hue3, roofHue);

  // add signature
  noStroke();
  fill(0,0,100,215);
  rect(scalePixelsX(calcWidth*0.893), scalePixelsY(calcHeight*0.930), scalePixelsX(calcWidth*0.062), scalePixelsY(calcHeight*0.030));
  PFont fontA = loadFont("Courier New");
  textFont(fontA, scalePixelsX(calcWidth*0.032)); 
  fill(0,0,0,300);
  text("GES",scalePixelsX(calcWidth*0.922), scalePixelsY(calcHeight*0.945));

  // draw a white border frame around the final artwork
  drawPictureFrame();  

}

// Draw a textured rectangle composed of overlapping characters
//  char - character(s) to draw
//  xLeft - left x position of rectangle
//  yTop - top y position of rectangle
//  w - width of rectangle
//  h - height of rectangle
//  hue - base hue for color
//  startSat - starting saturation range for color
//  endSat - ending saturation range for color
//  startBri - staring brightness range for color
//  endBri - ending brightness range for color
void drawTexture(string char, float txtSize, float variance, float x1, float y1, float w, float h, int hue, int startSat, int endSat, int startBri, int endBri, int opacity) {
 
  int dw=calcWidth*0.006;
  int dh=calcHeight*0.008;

  float numRows=h/dh;
  float dSat = (endSat-startSat)/numRows;
  float dBri = (startBri-endBri)/numRows;

  if (typeof opacity == "undefined" || !opacity) {
    opacity=100;
  }

  textSize(scalePixelsX(txtSize));

  noStroke();
  for (int x=x1; x<x1+w; x+=dw){
    float sat=startSat;
    float bri=startBri;
    for (int y=y1; y<y1+h; y+=dh) {      
      fill(color(hue,sat,bri,opacity));
      sat+=dSat;
      bri-=dBri;
      for (int i=0; i<6; i++) {
        text(char,scalePixelsX(x+calcWidth*random(-variance, variance)),scalePixelsY(y+calcWidth*random(-variance, variance)));
      }
    }
 }
}

// Draw a line of mountains
//  - xLeft - left x position of mountain line
//  - yBot - bottom y position of mountain line
//  - w - width of mountain line
//  - maxcalcHeight - maximum high mountain line can reach
//  - mountainColor - color of mountain line
//  - blobSize - size of characters used to draw mountain line elements
void drawMountains(float xLeft, float yBot, float w, float maxcalcHeight, color mountainColor, void blobSize) {
  stroke(mountainColor);
  fill(mountainColor);
  textSize(scalePixelsX(calcWidth*0.0225));
  float mountaincalcHeight=round(maxcalcHeight*random(0.5,1));
  float mountainDelta=calcHeight*0.005;
  for (x=xLeft; x<xLeft+w; x+=blobSize*0.8) {
    for (y=calcHeight*0.972; y>yBot-mountaincalcHeight; y-=blobSize*0.8) {
      text("x",scalePixelsX(x+calcWidth*random(-0.002,0.002)),scalePixelsY(y+calcWidth*random(-0.002,0.002)));
    }
    if (random(1,100)>80) {
      mountaincalcHeight+=mountainDelta;
    }
    if (mountaincalcHeight>maxcalcHeight) {
      mountaincalcHeight-=abs(mountainDelta);
      mountainDelta=-mountainDelta;
    } else if (mountaincalcHeight<(maxcalcHeight/2)) {
      mountaincalcHeight+=abs(mountainDelta);
      mountainDelta=-mountainDelta;
    } else {
        mountainDelta=mountainDelta*random(0.98,1.02);
    }
  }
}

// Draw multiple rows of overlapping pueblo homes, top to bottom, gradually growing larger
//  xLeft - left x position of the skyline area
//  yBot - bottom y position of the skyline area
//  w - width of the skyline area
//  h - height of the skyline area
//  tallest - tallest possible height for a building
//  hue1 - first color hue to use
//  hue2 - second color hue to use
//  hue3 - third color hue to use
void drawPueblo(float xLeft, float yBot, float w, float tallest, color hue1, color hue2, color hue3, int roofHue) {
  
  float x=xLeft-(calcWidth*random(0.005,0.050));
  float minW=calcWidth*random(0.04,0.08);
  float maxW=calcWidth*random(0.14,0.18);
  float growRatioY=1.20;
  float growRatioX=1.24;
  float txtSize=calcWidth*0.011;
  float sat=int(random(3,12));
  int dSat=int(random(0,1));
  float bri=80;
  int dBri=int(random(2,6));
  int rows=0;

  while (yBot<calcHeight*1.4) {
    while (x<(w-xLeft)) {
      float buildingWidth=random(minW,maxW);
      float buildingHeight=random(tallest*0.7,tallest*0.9);
      if (yBot>calcHeight*0.6 || random(0,10)>2) {
        if (rows>1 || random(0,100)>50) {
          drawBuilding(x, yBot-buildingHeight, buildingWidth, buildingHeight, sat, bri, hue1, hue2, hue3, txtSize, roofHue);
        }
      }
      x+=buildingWidth+random(buildingWidth*0.10,buildingWidth*0.25); // gap between buildings
    }
    x=xLeft-(calcWidth*random(0.005,0.050));
    if (yBot<calcHeight*1.5 && random(0,10)>5) {
      var treeLeft=random(calcWidth*0.015,calcWidth*0.95);
      drawTree(treeLeft,yBot+calcHeight*0.25,random(maxW*0.26,maxW*0.36),color(hue2,sat*2,bri*0.20),calcWidth*0.003);    
    }   
    if (yBot<calcHeight*1.5 && random(0,10)>7) {
      var treeLeft=random(calcWidth*0.015,calcWidth*0.95);
      drawTree(treeLeft,yBot+calcHeight*0.25,random(maxW*0.26,maxW*0.36),color(hue3,sat*2,bri*0.20),calcWidth*0.003);    
    }      
    yBot*=growRatioY;
    tallest*=growRatioY;
    minW*=growRatioX;
    maxW*=growRatioX;
    sat+=dSat;
    sat=min(sat,100);
    bri-=dBri;
    bri=max(0,bri);
    txtSize*=growRatioX;
    rows++;
  }

}

// Draw a single pueblo home
//  x - left x position of the building
//  y -  top y position of the building
//  w - width of the building
//  h - height of the building
//  colorSat - HSB saturation level of the color
//  colorBri - HSB brightness level of the color
//  hue1 - first color hue to use
//  hue2 - second color hue to use
//  hue3 - third color hue to use
//  txtSize - 
void drawBuilding(float x, float y, float w, float h, int colorSat, int colorBri, color hue1, color hue2, color hue3, float txtSize, int roofHue) {

  int[] hues = { hue1, hue2, hue3 };

  color baseColor=color(hues[Math.round(random(0,2))],colorSat,colorBri,360);
  color highlightColor=color(hue1,colorSat,100,60);
  color blackColor=color(hue1,15,colorBri*0.25);

  textSize(scalePixelsX(txtSize));

  bool buildingHasRoundedWindows=Math.round(random(0,1));

  int colSize=0;
  int numCols = 5; //int(random(4,6));
  while (colSize<2) {
    colSize=ceil(w/numCols);
    numCols--;
  }
  int colPadding=ceil(colSize*0.25);
  w=colPadding+(numCols*colSize)+colPadding;

  int rowSize=0;
  int numRows=int(random(30,50));
  while (rowSize<2) {
    rowSize=ceil(h/numRows);
    numRows--;
  }
  int rowPadding=ceil(rowSize*0.05);
  h=rowPadding+(numRows*rowSize)+rowPadding;

  // if a building is too tall and skinny, make it shorter
  while (h/w>2.5) {
    h=h*0.8;
    w=w*1.4;
  }

  // draw shadow rectangle of building
  var shadowWidth=w*random(1.05,1.15);
  var buildingBaseColor=color(hue(baseColor), colorSat*0.6, colorBri, 360);
  fill(buildingBaseColor);
  scaleRect(x,y,shadowWidth,h); 
  drawTexture("H", calcWidth*random(0.008, 0.015), 0.004, x, y, shadowWidth, h, hue(baseColor), colorSat*0.4, colorSat*0.6, colorBri*0.8, colorBri*1.0,200);

  // draw base rectangle of building
  drawTexture("H", calcWidth*random(0.010, 0.016), 0.004, x, y, w, h, hue(baseColor), colorSat*0.3, colorSat*0.5, colorBri*1.2, colorBri*1.7,340);

  // draw a roof on the building
  drawRoof(x, y, w, h, shadowWidth, roofHue);

  // draw building windows in dark
  stroke(blackColor); 
  fill(blackColor);
  var totalWindows=0;
  var winWidth=colSize-colPadding*2;
  while (totalWindows<6) {
    float dx=x+colPadding;
    float dy=y+(rowPadding*2);
    int row=0;    
    if (buildingHasRoundedWindows) {
      dy+=winWidth*0.7;
    }
    while (dy<y+h-rowSize*2) {
        while (dx<x+w-colSize) {
          if (random(0,100)>82) {
            
            if (buildingHasRoundedWindows) {
              scaleEllipse(dx+colPadding,dy-(winWidth*0.25),winWidth,winWidth);
              scaleRect(dx+colPadding,dy+(winWidth*0.35),winWidth,winWidth*0.75);
            } else {
              scaleRect(dx+colPadding,dy+(winWidth*0.35),winWidth,winWidth);
            }
            if (random(0,100)>66) {
              stroke(highlightColor);
              if (buildingHasRoundedWindows) {
                scaleLine(dx+colPadding+(winWidth*0.500),dy-winWidth*0.15,dx+colPadding+(winWidth*0.500),dy+winWidth);
              } else {
                scaleLine(dx+colPadding+(winWidth*0.500),dy+winWidth*0.25,dx+colPadding+(winWidth*0.500),dy+winWidth*1.2);
              }
              stroke(blackColor);
            }
            totalWindows++;
            if (totalWindows>4) break;
          }
          dx+=colSize;
        }
      if (totalWindows>6) break;
      if (buildingHasRoundedWindows) {
        dy+=winWidth*2.5;
      } else {
        dy+=winWidth*1.7;
      }
      dx=x+colPadding;
      row++; 
      if (row>6) break;
    }
  }

}

// Draw a roof on a building
// x - horizontal x position of bottom-left of roof
// y - vertical y position of bottom-left of roof
// w - width of roof without shadow
// h - height of roof
// shadowWidth - width of roof including additional shadow area on right edge
// roofHue - hue to use for roof color
void drawRoof(float x, float y, float w, float h, float shadowWidth, int roofHue) {
  var roofLeft=x;
  var roofRight=x+shadowWidth;
  var roofColor=color(roofHue,random(60,90),random(50,90));
  fill(roofColor);
  scaleQuad(x-calcWidth*0.01,y,x+shadowWidth+(calcWidth*0.005),y, x+shadowWidth-(shadowWidth*0.05), y-h*0.09, x+(shadowWidth*0.06), y-h*0.09);
  
  // add shadowing to right edge of the roof
  roofColor=color(roofHue,random(60,80),random(20,35));
  fill(roofColor);
  scaleQuad(x+w,y,x+shadowWidth+(calcWidth*0.005),y, x+shadowWidth-(shadowWidth*0.05), y-h*0.09, x+w, y-h*0.09);

  // add tile texture to the roof
  stroke(roofColor);
  fill(roofColor);
  textSize(scalePixelsX(shadowWidth*0.045));
  var roofLeftX=x-shadowWidth*0.02;
  var roofRightX=roofLeftX+shadowWidth+shadowWidth*0.02;
  for (roofY=y-h*0.007; roofY>y-(h*0.09); roofY-=h*0.0045) {
    for (roofX=roofLeftX; roofX<roofRightX; roofX+=shadowWidth*0.024) {
      scaleText('o', roofX, roofY);
    }
    roofLeftX+=shadowWidth*0.005;
    roofRightX-=shadowWidth*0.004;
  }
}

// Draw a single evergreen tree
//  xLeft - left x position of treeline
//  yBot - bottom y position of treeline
//  w - width of treeline
//  maxcalcHeight - maximum high treeline can reach
//  ORA - color of treeline
//  blobSize - size of characters used to draw tree elements
void drawTree(float xLeft, float yBot, float w, color treeColor, void blobSize) {
  stroke(treeColor);
  fill(treeColor);
  textSize(scalePixelsX(calcWidth*0.0225));

 // float mountaincalcHeight=round(maxcalcHeight*random(0.5,1));
 float treeHeight=0; // h*(random,0.8,1.5);
 float yDelta=14;
  // left half of tree (increasing heights)
  for (x=xLeft; x<xLeft+(w*0.5); x+=blobSize*0.8) {
    for (y=yBot; y>yBot-treeHeight; y-=blobSize*0.8) {
      text("^",scalePixelsX(x+calcWidth*random(-0.002,0.002)),scalePixelsY(y+calcWidth*random(-0.002,0.002))); 
    }
    treeHeight+=yDelta;    
    yDelta=yDelta*0.97;
  }
  // right half of tree (decreasing heights)
  for (x=xLeft+(w*0.5); x<xLeft+w; x+=blobSize*0.8) {
    for (y=yBot; y>yBot-treeHeight; y-=blobSize*0.8) {
      text("^",scalePixelsX(x+calcWidth*random(-0.002,0.002)),scalePixelsY(y+calcWidth*random(-0.002,0.002))); 
    }
    treeHeight-=yDelta;    
    yDelta=yDelta*1.03;
  }  
}

// Return the left split complementary color for a given hue
//  hue - hue to split
color colorSplitComplementLeft(int h) {
  h+=150;
  h=h%360;
  return h;
}

// Return the right split complementary color for a given hue
//  hue - hue to split
color colorSplitComplementRight(int h) {
  h+=210;
  h=h%360;
  return h;
}

// Scale a horizontal (x) position on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  px - The horizontal x position to scale
float scalePixelsX(px) {
  return int(px*(width/calcWidth));
}

// Scale a vertical (y) position on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  py - The vertical y position to scale
float scalePixelsY(px) {
  return int(px*(height/calcHeight));
}

// Scale a lines's coordinates on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  x - left x position of the line
//  y - top y position of the line
//  w - width of the line
//  h - height of the line
void scaleLine(float x1, float y1, float x2, float y2) {
  line(scalePixelsX(x1), scalePixelsY(y1), scalePixelsX(x2), scalePixelsY(y2));
}

// Scale a rectangle's coordinates on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  x - left x position of the rectangle
//  y - top y position of the rectangle
//  w - width of the rectangle
//  h - height of the rectangle
void scaleRect(float x, float y, float w, float h) {
  rect(scalePixelsX(x), scalePixelsY(y), scalePixelsX(w), scalePixelsY(h));
}

// Scale a quads's coordinates on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  x - first left x position of the rectangle
//  y - top y position of the rectangle
//  x2, x3, x4 - second, third and fourth left x positions of vertices in the quad
//  y2, y3, y4 - second, third and fourth  top y positions of vertices in the quad
void scaleQuad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  quad(scalePixelsX(x1), scalePixelsY(y1), scalePixelsX(x2), scalePixelsY(y2), scalePixelsX(x3), scalePixelsY(y3), scalePixelsX(x4), scalePixelsY(y4));
}

// Scale an elllipse's coordinates on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
// x - horizontal left edge of the ellipse
// y - vertical top edge of the ellipse
// w - width of the ellipse
// h - height of the ellipse
void scaleEllipse(float x, float y, float w, float h) {
  ellipse(scalePixelsX(x), scalePixelsY(y), scalePixelsX(w), scalePixelsY(h));
} 

// Scale text coordinates on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  txt - text string to render
//  x - left x position of the text
//  y - top y position of the text
void scaleText(string txt, float x, float y) {
  text(txt, scalePixelsX(x), scalePixelsY(y));
}


// Draw a white border frame around the final artwork
// Use characters to make the frame look a bit "ragged"
void drawPictureFrame() {
  fill(0,0,100,360);   
  noStroke();
  
  scaleRect(0,0,calcWidth,calcHeight*0.021);
  drawTexture('X', calcWidth*0.0600, 0.003, 0,0,calcWidth,calcHeight*0.021, 0, 0, 0, 100, 100);

  scaleRect(0,calcHeight*0.985,calcWidth,calcHeight*0.05);
  drawTexture('X', calcWidth*0.0600, 0.003, 0,calcHeight*0.987,calcWidth,calcHeight*0.05, 0, 0, 0, 100, 100);

  scaleRect(0,0,calcWidth*0.017,calcHeight*1.01);
  drawTexture('X', calcWidth*0.0600, 0.003, 0,0,calcWidth*0.019,calcHeight*1.01, 0, 0, 0, 100, 100);

  scaleRect(calcWidth*0.982,0,calcWidth,calcHeight*1.1);
  drawTexture('X', calcWidth*0.0600, 0.003, calcWidth*0.982,0,calcWidth,calcHeight*1.1, 0, 0, 0, 100, 100);
}