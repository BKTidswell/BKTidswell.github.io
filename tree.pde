
int iters = 7;
float phi = (sqrt(5)+1)/2;
maxDepth = 7;

a = 75;
treeColor = #C04100;
leafColor = #3FA800;

void setup(){
	size(screen.width, screen.height);
	w = screen.width
	h = screen.height
	smooth();
	background(#03264A);
	stroke(treeColor,a)
	strokeWeight(1);
	noFill();
}

void draw(){
	//line(w/2,h,w/2,h*0.9)

	//translate(w/2-200,h*0.9);
	
	line(w,h,w*0.939,h*0.92);
	pushMatrix();
	translate(w*0.83,h*1.1);
	rotate(2*PI-(PI/4))

	pushMatrix();
	scale(-1,1);
	drawSpiral(0,0,200,0);
	popMatrix();

	translate(400,0);
	drawSpiral(0,0,200,0);
	popMatrix();

	line(0,h,w*0.065,h*0.925);
	translate(-w*0.045,h*0.75);
	rotate(PI*0.25);

	pushMatrix();
	scale(-1,1);
	drawSpiral(0,0,200,0);
	popMatrix();

	translate(400,0);
	drawSpiral(0,0,200,0);
	
}

void drawSpiral(int startX, int startY, int startSize, int depth){
	if(depth < maxDepth){
		int piStart;
		int piEnd;

		iMod = 1

		for(int i = 0; i < iters; i++){
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

			size = startSize/pow(phi,i);
			piStart = PI*(0.5*(i+2));
			piEnd = PI*(0.5*(i+3));

			if (depth>2) {
				stroke(leafColor,a);
			}
			arc(0,0,size*2,size*2,piStart,piEnd);
			stroke(treeColor,a);

			if(i==0){
				pushMatrix();
				scale(-1,1);
				translate(size/2,-size*1.35)
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
			if(i==1){
				pushMatrix();
				translate(size*1.5,0);
				rotate(PI);
				scale(-1,1);
				drawSpiral(0,0,size/2,depth+2);
				popMatrix();
			}
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

