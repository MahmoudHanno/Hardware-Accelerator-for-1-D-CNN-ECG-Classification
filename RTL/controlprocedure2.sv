module controlprocedure2(rst,clk,start,done,maxflagin,in1,in2,in3,in4,out1,out2,out3,out4,out5,out6,out7,out8,maxflagout);

parameter idle=0,waiting=1,conv=2,max=3;
reg [1:0] ns,cs;
//reg [7:0] firstmem [10240:0];

input clk,rst,start,maxflagin;
input signed [7:0] in1,in2,in3,in4;
reg signed [4:0] [7:0] inconv1,inconv2,inconv3,inconv4; 
reg enconv;
reg  signed [7:0] [7:0] outconv;
reg [7:0] [7:0] outrelu;
reg [5:1] [7:0] inmax1,inmax2,inmax3,inmax4,inmax5,inmax6,inmax7,inmax8;
reg enmax;
reg [7:0] [7:0] outmax;
//adds every 4 numbers out of the relu to make 5 in 4 channels
reg [8:0] waitcount=0;
reg [2:0] count1=0,write_count=0;
reg [6:0] count2=0;
reg inmax_flag;
//start from the main control unit
output reg done,maxflagout;
output [7:0] out1,out2,out3,out4,out5,out6,out7,out8;
//outmax may be handled in the main control unit 
convlayer2 convolution(rst,enconv,inconv1,inconv2,inconv3,inconv4,
outconv[0],outconv[1],outconv[2],outconv[3],outconv[4],outconv[5],outconv[6],outconv[7]);

RELUlayer2 relu(outconv[0],outconv[1],outconv[2],outconv[3],outconv[4],outconv[5],outconv[6],outconv[7],
outrelu[0],outrelu[1],outrelu[2],outrelu[3],outrelu[4],outrelu[5],outrelu[6],outrelu[7]);

maxpoolinglayer2 pooling(rst,enmax,inmax1,inmax2,inmax3,inmax4,inmax5,inmax6,inmax7,inmax8,
	outmax[0],outmax[1],outmax[2],outmax[3],outmax[4],outmax[5],outmax[6],outmax[7]);








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
		ns=waiting;
		else 
		ns=idle;
		end 

		waiting: begin
			if(waitcount<2) 
				ns=waiting;
			else if(waitcount>=500 && count1<5)
				ns=conv;
			else if(maxflagin)
				ns=conv;
			else if(count1==5)
				ns=max;
			else 
				ns=waiting;

		end
		conv: begin
		ns=waiting;
		end 
		max: begin
			if(count2<99) begin
			ns=waiting;
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
	  	count1<=0;
		count2<=0;
		inconv1<=0;
		inconv2<=0;
		inconv3<=0;
		inconv4<=0;
  	end

  	  waiting: begin
  	  enconv<=0;
  		enmax<=0;
  		done<=0;
		maxflagout<=0;
  		if(maxflagin && waitcount<=500)begin
  			waitcount<=waitcount+1;
  	  	inconv1<= {inconv1[3],inconv1[2],inconv1[1],inconv1[0],in1};
 	  		inconv2<= {inconv2[3],inconv2[2],inconv2[1],inconv2[0],in2};
 	  		inconv3<= {inconv3[3],inconv3[2],inconv3[1],inconv3[0],in3};
 	  		inconv4<= {inconv4[3],inconv4[2],inconv4[1],inconv4[0],in4};
 				end
 			else if(waitcount>=500) begin
 				waitcount<=waitcount+1;
 				inconv1<= {inconv1[3],inconv1[2],inconv1[1],inconv1[0],8'b0};
 	  		inconv2<= {inconv2[3],inconv2[2],inconv2[1],inconv2[0],8'b0};
 	  		inconv3<= {inconv3[3],inconv3[2],inconv3[1],inconv3[0],8'b0};
 	  		inconv4<= {inconv4[3],inconv4[2],inconv4[1],inconv4[0],8'b0};
 			end

			if(inmax_flag==1) begin
				inmax1[count1]<=outrelu[0];
				inmax2[count1]<=outrelu[1];
				inmax3[count1]<=outrelu[2];
				inmax4[count1]<=outrelu[3];
				inmax5[count1]<=outrelu[4];
				inmax6[count1]<=outrelu[5];
				inmax7[count1]<=outrelu[6];
				inmax8[count1]<=outrelu[7];
				inmax_flag<=0;
			end

  	  end

  		conv: begin
  			count1<=count1+1;
  		  enconv<=1;
  		  enmax<=0;
		inmax_flag<=1;
		maxflagout<=0;
  		  
  	end
  	
  	
  		max: begin	
  		enconv<=0;
  		enmax<=1;
		count1<=0;
		maxflagout<=1;
  		if(count2==99)begin
  			done<=1;
  			count2<=0;
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
assign out5=outmax[4];
assign out6=outmax[5];
assign out7=outmax[6];
assign out8=outmax[7];


endmodule