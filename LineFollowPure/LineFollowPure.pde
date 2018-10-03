import gab.opencv.*;
import java.awt.*;
import processing.video.*;

PImage src, dst;
OpenCV opencv;
Capture video;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;
float[] Areas;
float maxArea=0;
Rectangle rec;

int lineCenter;

void setup() {
//  src = loadImage("d1.png"); 
  size(640, 480);
    video = new Capture(this, 640, 480);
    opencv = new OpenCV(this, 640, 480);
  opencv = new OpenCV(this, video);

  opencv.gray();
  opencv.threshold(70);
  dst = opencv.getOutput();

  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
  //stroke(0, 255, 0);
   video.start();
}

void draw() {
 // scale(0.5);
 // image(src, 0, 0);
 opencv.loadImage(video);
   opencv.gray();
  opencv.threshold(70);
  opencv.blur(12);  
  opencv.invert();
  dst = opencv.getOutput();
 
//  image(video, 0, 0 );

 
  contours = opencv.findContours();
  println("found " + contours.size() + " contours");
 //background(dst);
// filter(INVERT);
  image(dst, 0, 0);
 stroke(255, 0, 0);
  noFill();
  strokeWeight(3);
   line(0,height/2,width,height/2);
   line(width/2,0,width/2,height);
   
   if(contours.size()>=2){
   
     
   if(contours.get(0).containsPoint(mouseX, mouseY) ){
   
     println("Go left");
   }
   if(contours.get(1).containsPoint(mouseX, mouseY) ){
   
     println("Go Right");
   }
   }
   
  // int mArea=max(contours.Contour.area());
  try{
    Areas =new float[contours.size()];
 for (int i = 0; i < contours.size(); i++) {
   Areas[i]=contours.get(i).area();
    print("Max Areas : "+maxArea+" ");
  }

 maxArea=max(Areas);

  
  
  for (Contour contour : contours) {
   
    
    
   if(contour.area()==maxArea){
    stroke(0, 255, 0);
    contour.draw();
    
    println(" Biggest Contour");
    rec = contour.getBoundingBox();
    rect(rec.x, rec.y, rec.width, rec.height);
    
     stroke(0, 0, 255);
     strokeWeight(10);
    point(rec.x+rec.width/2, rec.y+rec.height/2);
    lineCenter=rec.x;
    
    if(lineCenter>width/2){ // x2>x1
    println("RIGHT--------");
    }
    if(lineCenter<width/2){ // x2>x1
     println("LEFT--------");
    }
    
   }

 
;
     println("Ponits............................"+contour);
    stroke(255, 0, 0);

  } 
  }
  catch(Exception e){}
}

void captureEvent(Capture c) {
  c.read();
}
