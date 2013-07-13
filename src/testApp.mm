#include "testApp.h"


//--------------------------------------------------------------
void testApp::setup(){
    drawVideo=false;
    isColour=true;
    clearIt=false;
    fadeAmnt=20;
     pyramidScale=0.5;
     pyramidLevels=3;
      windowSize=10;
     iterationPerLevel=1;
     expansionArea=5;
     expansionSigma=1.5;
     flowFeedback=false;
     guasianFIltering=false;
    vidGrabber.listDevices();
    vidGrabber.setDeviceID(1);
    vidGrabber.initGrabber(640, 480);
    flowSolver.setup(vidGrabber.getWidth()/4, vidGrabber.getHeight()/4, 0.5, 3, 10, 1, 7, 1.5, false, false);
    ofEnableAlphaBlending();
    ofSetBackgroundColor(0, 0, 0);
    trailsFbo.allocate(screenWidth, screenHeight,GL_RGBA);
    trailsFbo.begin();
    ofClear(0, 0, 0,0);
    trailsFbo.end();
    
    gui.addSlider("Pyramid Scale", pyramidScale, 0.0, 1.0);
    gui.addSlider("Pyramid Levels", pyramidLevels, 1, 150);
    gui.addSlider("Windowing size", windowSize, 1, 100);
    gui.addSlider("Iterations", iterationPerLevel, 1, 20);
    gui.addSlider("Expansion Area", expansionArea, 1, 20);
    gui.addSlider("Expansion Sigma", expansionSigma, 0, 10);
    gui.addSlider("Fade Amount", fadeAmnt, 0, 255);
    gui.addToggle("Gausian FIltering", guasianFIltering);
    gui.addToggle("FLow Feedback", flowFeedback);
    gui.addToggle("Clear", clearIt);
    gui.addToggle("Colour", isColour);
    gui.addToggle("Draw Video", drawVideo);
    
   // gui.loadFromXML();
}
;
void testApp::drawInFbo(){
    
    //we clear the fbo if c is pressed.
	//this completely clears the buffer so you won't see any trails
	if( clearIt==true){
		ofClear(0,0,0, 0);
        clearIt=false;
	}
    
	
	//some different alpha values for fading the fbo
	//the lower the number, the longer the trails will take to fade away.
//	fadeAmnt = 2;
//	if(ofGetKeyPressed('1')){
//		fadeAmnt = 1;
//	}else if(ofGetKeyPressed('2')){
//		fadeAmnt = 5;
//	}else if(ofGetKeyPressed('3')){
//		fadeAmnt = 15;
//	}
    
	//1 - Fade Fbo
	//blackImage.draw(0,0,ofGetWidth(),ofGetHeight());
	//this is where we fade the fbo
	//by drawing a rectangle the size of the fbo with a small alpha value, we can slowly fade the current contents of the fbo.
	ofFill();
	ofSetColor(0,0,0, fadeAmnt);
	ofRect(0,0,screenWidth,screenHeight);
    
    //vidGrabber.draw(0, 0);
    if (isColour==true) {
         flowSolver.drawColored(screenWidth, screenHeight, 16, 6);
    }
    
if (isColour==false) {
    flowSolver.draw(screenWidth, screenHeight, 16, 6);
}



}
//--------------------------------------------------------------
void testApp::update(){
    vidGrabber.update();
    if(vidGrabber.isFrameNew()){
        flowSolver.update(vidGrabber);
    }
    
    
   flowSolver.setPyramidScale(pyramidScale);
    
   flowSolver.setPyramidLevels(pyramidLevels); 

   flowSolver.setWindowSize(windowSize); 

  flowSolver.setIterationsPerLevel(iterationPerLevel); 

flowSolver.setExpansionArea(expansionArea);
    
flowSolver.setExpansionSigma(expansionSigma); 

 flowSolver.setFlowFeedback(flowFeedback); 
flowSolver.setGaussianFiltering(guasianFIltering);
    
    trailsFbo.begin();
    drawInFbo();
    trailsFbo.end();
}

//--------------------------------------------------------------
void testApp::draw(){
//    ofFill();
//	ofSetColor(0,0,0);
//	ofRect(0,0,ofGetWidth(),ofGetHeight());
    if (drawVideo==false) {
        ofDisableAlphaBlending();
        ofSetColor(255, 255, 255);
        trailsFbo.draw(0,0,screenHeight, screenWidth);
    }
    if (drawVideo==true) {
        ofDisableAlphaBlending();
        vidGrabber.draw(0, 0,screenHeight, screenWidth);
       // ofSetColor(255, 255, 255);
        flowSolver.drawColored(screenHeight, screenWidth, 16, 6);
        
    }
    
    //vidGrabber.draw(0, 0,screenHeight, screenWidth);
    //flowSolver.drawColored(screenHeight, screenWidth, 16, 6);
    
    
    stringstream m;
    m << "fps " << ofGetFrameRate() << endl
    << "pyramid scale: " << flowSolver.getPyramidScale() << " p/P" << endl
    << "pyramid levels: " << flowSolver.getPyramidLevels() << " l/L" << endl
    << "averaging window size: " << flowSolver.getWindowSize() << " w/W" << endl
    << "iterations per level: " << flowSolver.getIterationsPerLevel() << " i/I" << endl
    << "expansion area: " << flowSolver.getExpansionArea() << " a/A" << endl
    << "expansion sigma: " << flowSolver.getExpansionSigma() << " s/S" << endl
    << "flow feedback: " << flowSolver.getFlowFeedback() << " f/F" << endl
    << "gaussian filtering: " << flowSolver.getGaussianFiltering() << " g/G";
    
    ofDrawBitmapString(m.str(), 20, 20);
    gui.draw();
}
//--------------------------------------------------------------
void testApp::exit(){
        
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
	//bLearnBakground = true;
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
        
}
    
//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
        
}
    
//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
    gui.toggleDraw();
        
}
    
//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
        
}
    
//--------------------------------------------------------------
void testApp::lostFocus(){
        
}
    
//--------------------------------------------------------------
void testApp::gotFocus(){
        
}
    
//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
        
}
    
//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
        
}
