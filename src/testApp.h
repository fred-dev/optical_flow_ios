#pragma once


#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"


//ON IPHONE NOTE INCLUDE THIS BEFORE ANYTHING ELSE
#include "ofxOpenCv.h"
#include "ofxOpticalFlowFarneback.h"
#include "ofxSimpleGuiToo.h"

#define screenWidth 1024
#define screenHeight 768

class testApp : public ofxiPhoneApp{
	
	public:
		
		void setup();
		void update();
		void draw();
        void exit();
    
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);
	
        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

    void drawInFbo();
    
    
    ofVideoGrabber vidGrabber;
    ofxOpticalFlowLK flowSolver;
    ofFbo   trailsFbo;
    int fadeAmnt;
    
    float pyramidScale;
    float pyramidLevels;
    int  windowSize;
    int iterationPerLevel;
    int expansionArea;
    float expansionSigma;
    bool flowFeedback;
    bool guasianFIltering;
    bool clearIt;
    bool    isColour;
    bool    drawVideo;
    

};
