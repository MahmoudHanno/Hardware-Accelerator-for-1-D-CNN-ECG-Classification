module controlprocedure1(rst,clk,start,done,out1,out2,out3,out4,maxflagout);

parameter idle=0,conv=1,convandmax=2;
reg [1:0] ns,cs;
reg signed [7:0] firstmem [0:2503] ;
input clk,rst,start;
//start from the main control unit
reg signed [4:0] [7:0] inconv ; 
reg enconv=0;

reg  signed [3:0] [7:0] outconv;
reg [3:0] [7:0] outrelu;
reg [5:1] [7:0] inmax1,inmax2,inmax3,inmax4;
reg enmax=0;
reg [3:0] [7:0] outmax ;
reg [2:0] count1=0;
reg [8:0] count2=0;
output [7:0] out1,out2,out3,out4;
output reg maxflagout;
output reg done=0;


convlayer1 convolution(rst,enconv,inconv,outconv[0],outconv[1],outconv[2],outconv[3]);

RELUlayer1 relu(outconv[0],outconv[1],outconv[2],outconv[3],outrelu[0],outrelu[1],outrelu[2],outrelu[3]);

maxpoolinglayer1 pooling(rst,enmax,inmax1,inmax2,inmax3,inmax4,outmax[0],outmax[1],outmax[2],outmax[3]);



initial begin
	$readmemb("E:/CNN Final/binary_NA_Q/row_1/binary_data.dat", firstmem);
end


always@(posedge clk, posedge rst) begin
	
	if(rst) begin
		cs<=idle;
	end
	else begin
		cs<=ns;
	end
end


always@(*) begin
	
	case(cs) 

		idle: begin 
		if(start) 
		ns=conv;
		else 
		ns=idle;
		end 
		conv: begin
		if(count1<5 && done!=1) begin
		ns=conv;
		end else if(done==1)begin
			ns=idle;
		end 
		else begin 
		ns=convandmax;
		end
	end 
		convandmax: begin
			if(count2<500) begin
			ns=conv;
		end
		else begin
			ns=idle;
		end
	end
	default: ns=idle;
endcase

end
//output logic 


  always@(posedge clk) begin
  	

  	case(cs)


  		idle: begin
  		enconv<=0;
  		enmax<=0;
  		done<=0;
  		 maxflagout<=0;
  	end
  		conv: begin
  			if(count1==5 || done==1) begin
  		count1<=0;
  		enconv<=0;
  		maxflagout<=0;
  	end
  	else begin
  		count1<=count1+1;
  		enconv<=1;
  		enmax<=0; 
  		maxflagout<=0;
  		inconv[0]<=firstmem[count1+count2*5];   
  		inconv[1]<=firstmem[count1+count2*5+1];
  		inconv[2]<=firstmem[count1+count2*5+2];
  		inconv[3]<=firstmem[count1+count2*5+3];  
  		inconv[4]<=firstmem[count1+count2*5+4];
  	end
  	
  		if(count1>0) begin
  		inmax1[count1]<=outrelu[0];
  		inmax2[count1]<=outrelu[1];
  		inmax3[count1]<=outrelu[2];
  		inmax4[count1]<=outrelu[3];
  	end

  	end
  		convandmax: begin
  		count1<=count1+1;
  		enconv<=1;
  		enmax<=1;
  		maxflagout<=1;
  		inconv[0]<=firstmem[count1+count2*5];   
  		inconv[1]<=firstmem[count1+count2*5+1];
  		inconv[2]<=firstmem[count1+count2*5+2];
  		inconv[3]<=firstmem[count1+count2*5+3];  
  		inconv[4]<=firstmem[count1+count2*5+4];

  		//inmax1[count1]<=outrelu[0];
  		//inmax2[count1]<=outrelu[1];
  		//inmax3[count1]<=outrelu[2];
  		//inmax4[count1]<=outrelu[3];
  		if(count2==499)begin
  			done<=1;
  			count2<=0;
  			enconv<=0;
  		end
  		else begin
  			count2<=count2+1;
  			done<=0;
  		end
  	end
  	endcase

end


assign out1=outmax[0];
assign out2=outmax[1];
assign out3=outmax[2];
assign out4=outmax[3];


endmodule