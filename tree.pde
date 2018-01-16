
int iters = 9;
float phi = (sqrt(5)+1)/2;
int maxDepth = 3;
int count = 0;

a = 255;
treeColor = #C04100;
leafColor = #3FA800;

void setup(){
	//Sets it based on brower window
	size(screen.width, screen.height);
	w = screen.width
	h = screen.height
	smooth();

	//sets correct colors
	background(#03264A);
	stroke(treeColor,a)
	strokeWeight(1);
	noFill();
}

void draw(){
	//for middle tree no longer used
	//line(w/2,h,w/2,h*0.9)
	//translate(w/2-200,h*0.9);
	
	//Used for drawing right tree
	line(w,h,w*0.939,h*0.92);
	pushMatrix();
	translate(w*0.83,h*1.1);
	rotate(2*PI-(PI/4))

	//Draws each spiral with different matrix
	pushMatrix();
	scale(-1,1);
	drawSpiral(0,0,200,0);
	popMatrix();

	translate(400,0);
	drawSpiral(0,0,200,0);
	popMatrix();

	//Moves to spot to draw next spirals from
	line(0,h,w*0.065,h*0.925);
	translate(-w*0.045,h*0.75);
	rotate(PI*0.25);

	pushMatrix();
	scale(-1,1);
	drawSpiral(0,0,200,0);
	popMatrix();

	translate(400,0);
	drawSpiral(0,0,200,0);

	//Count allows leaves to come in slower
	count += 1;

	//Stops the depth and drawing eventually
	if(maxDepth < 8 && count > 10){
		maxDepth += 1;
		count = 0;
	}
	if(maxDepth >= 8){
		noLoop();
	}
	
}

void drawSpiral(int startX, int startY, int startSize, int depth){
	//Prevents it from going forever
	if(depth < maxDepth){
		int piStart;
		int piEnd;


		for(int i = 0; i < iters; i++){
			//This changes the drawing point for each of the different segements
			//of the spiral
			if((i%4)==1){
				translate(0,-startSize/pow(phi,(i+1)));
			}
			if((i%4)==2){
				translate(startSize/pow(phi,(i+1)),0);
			}
			if((i%4)==3){
				translate(0,startSize/pow(phi,(i+1)));
				
			}
			if(((i%4)==0) && (i > 0)){
				translate(-startSize/pow(phi,(i+1)),0);
			}

			//Changes the radius of the spiral and the degrees 
			//between which it goes
			size = startSize/pow(phi,i);
			piStart = PI*(0.5*(i+2));
			piEnd = PI*(0.5*(i+3));

			//Changes to green at a higher depth for leaves
			if (depth>2) {
				stroke(leafColor,a);
			}
			arc(0,0,size*2,size*2,piStart,piEnd);
			stroke(treeColor,a);

			//This makes offspring spirals 1 and two
			//I placed them off the same one as it was easier and
			//I saw them as touching that main top area
			//Though technically they dont both touch the first curve 
			if(i==0){
				pushMatrix();
				scale(-1,1);
				//The translates relate to size to keep them propotionate.
				//THe multiplies were found by trial and error for all of them
				translate(size/2,-size*1.35);
				rotate(PI*1.75);
				drawSpiral(0,0,startSize/2,depth+1);
				popMatrix();

				pushMatrix();
				scale(-1,1);
				translate(-startSize/1.85,-startSize*1.25)
				rotate(6.5*PI/5);
				drawSpiral(0,0,startSize/2.5,depth+1);
				popMatrix();
			}
			//This is for the third curl off any parent curl
			if(i==1){
				pushMatrix();
				translate(size*1.5,0);
				rotate(PI);
				scale(-1,1);
				drawSpiral(0,0,size/2,depth+2);
				popMatrix();
			}
			//Adds another curl but looks weird
			// if(i==3){
			// 	pushMatrix();
			// 	translate(-size,size*1.1);
			// 	rotate(2*PI-(PI/3));
			// 	scale(-1,1);
			// 	drawSpiral(0,0,size/2,depth+3);
			// 	popMatrix();
			// }
		}
	}
}

