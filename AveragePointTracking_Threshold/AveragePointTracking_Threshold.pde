// Daniel Shiffman and Thomas Sanchez Lengeling
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.processing.*;
import com.hamoid.*;

VideoExport videoExport;


// The kinect stuff is happening in another class
KinectTracker tracker;


void setup() {
  size(640, 520);
  tracker = new KinectTracker(this);
  videoExport = new VideoExport(this);
  videoExport.startMovie();
 
  
}

void draw() {
  background(255);
  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();
  
  
  PImage img = tracker.kinect2.getVideoImage();
 
  pushMatrix();
  scale(-1.0, 1.0);
  image(img,-640 ,0, 640, 520);
  popMatrix();
   
  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse((v1.x-50)/(462-50)*640, (v1.y-55)/(334-55)*520, 20, 20);

  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  //Interpolation depth picture in RGB coordinates
  ellipse((v2.x-50)/(462-50)*640, (v2.y-55)/(334-55)*520, 20, 20);

  // Display some info
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " +
    "UP increase threshold, DOWN decrease threshold", 10, 500);
    
  videoExport.saveFrame();
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = tracker.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t +=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t -=5;
      tracker.setThreshold(t);
    }
  }
}
