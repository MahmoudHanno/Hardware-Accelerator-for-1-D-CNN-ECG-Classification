module maincontrol(rst,main_start,clk,maxflagin,out41,out42,out43,out44,out45,out46,out47,out48,out49,out410,out411,out412,out413,out414,out415,out416,done1,done2,done3,done4,
				   start1,start2,start3,start4,seg);


	input rst,main_start,clk,maxflagin;
	input [7:0] out41,out42,out43,out44,out45,out46,out47,out48,out49,out410,out411,out412,out413,out414,out415,out416;
	input done1,done2,done3,done4;
	output reg [7:0] seg;
	reg signed [3:0][7:0] in;
	output reg start1,start2,start3,start4;
	reg en,fc_done;
	reg [1:0]outfin;
	
	
  
 

	fullyconnected x5(rst, clk, en, in, outfin, fc_done);


// 4 states: idle, waiting(takes values for fully connected) , fully connected is working, then classifier

reg [63:0] [7:0] final_mem;
reg [2:0] cs,ns;
reg [1:0]write_count=0;
reg [4:0]final_count=0;
reg [19:0]waitcount=0;
parameter idle=0,waiting=1,fc=2,classifier=3;
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
		if(main_start) 
		ns=waiting;
		else 
		ns=idle;
		end 


		waiting: begin
		if(done4) begin
		ns=fc;
		end
		else begin 
		ns=waiting;
		end
	end 
		fc: begin
			if(fc_done) begin
			ns=classifier;
		end
		else begin
			ns=fc;
		end
	end
		classifier: begin
			ns=idle;

		end

	default: ns=idle;
endcase

end
//output logic 


  always@(posedge clk) begin
  	

  	case(cs)


  		idle: begin
			if(main_start) begin
				start1<=1;
				start2<=1;
				start3<=1;
				start4<=1;
			end else begin
				start1<=0;
				start2<=0;
				start3<=0;
				start4<=0;
			end

		
  	end
  		waiting: begin
			if(main_start) begin
				start1<=1;
				start2<=1;
				start3<=1;
				start4<=1;
			end else begin
				start1<=0;
				start2<=0;
				start3<=0;
				start4<=0;
			end

  	  		if(maxflagin) begin
  	  		write_count<=write_count+1;
  	  		 final_mem[16*write_count]<=out41;
  	  		 final_mem[16*write_count+1]<=out42;
  	  		 final_mem[16*write_count+2]<=out43;
  	  		 final_mem[16*write_count+3]<=out44;
  	  		 final_mem[16*write_count+4]<=out45;
  	  		 final_mem[16*write_count+5]<=out46;
  	  		 final_mem[16*write_count+6]<=out47;
  	  		 final_mem[16*write_count+7]<=out48;
  	  		 final_mem[16*write_count+8]<=out49;
  	  		 final_mem[16*write_count+9]<=out410;
  	  		 final_mem[16*write_count+10]<=out411;
  	  		 final_mem[16*write_count+11]<=out412;
  	  		 final_mem[16*write_count+12]=out413;
  	  		 final_mem[16*write_count+13]<=out414;
  	  		 final_mem[16*write_count+14]<=out415;
  	  		 final_mem[16*write_count+15]<=out416;
			
  	  	end
      //Will probably need to add 1 clock to waitcount

  	end
  		fc: begin
			
  			if(final_count<16 && fc_done==0) begin
  			en<=1;
			final_count<=final_count+1;
  			in[0]=final_mem[final_count*4];
  			in[1]=final_mem[final_count*4+1];
  			in[2]=final_mem[final_count*4+2];
  			in[3]=final_mem[final_count*4+3];
  		end
  		else if(final_count==16) begin
  			en<=0;
			final_count<=0;
  		end
  	end
	classifier: 
  	if(outfin==0) begin
  		seg<=8'b0000_0000;
  		  	end
  	else if(outfin==1) begin
  		seg<=8'b0000_0001;
  	end
  

endcase // cs
end




endmodule