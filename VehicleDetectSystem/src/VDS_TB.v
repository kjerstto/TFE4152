//-----------------------------------------------------------------------------
//
// Title       : VDS_TB
// Design      : VehicleDetectSystem
// Author      : Kjersti
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\VehicleDetectSystem\VehicleDetectSystem\src\VDS_TB.v
// Generated   : Mon Nov 21 12:39:21 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : Testbench for complete digital part of Vehicle Detect System
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ns

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {VDS_TB}}
module VDS_TB ();  
	//inputs
	reg fm0; //decoder
	reg reset; //decoder and listener
	reg clk_50MHz; //listener
	reg clk_fm0;
	
	//outputs
	wire interrupt;	//listener
	wire clk_500kHz; //decoder
	wire nrz; //decoder
	
	
	parameter flag		= 8'b01111110;
	parameter address 	= 8'b11111111; 
	parameter mac 		= 8'b10000000;
	parameter llc		= 8'b00000011;
	parameter infoT		= 8'b01010101;
	parameter infoF		= 8'b00110110;
	parameter FCST		= 16'b0010111111111010;
	parameter FCSF		= 16'b0011011110010010;
	parameter fm0_pre   = 16'b1011010010110100;
	parameter preamble  = 8'b01010101; //8 bit preamble
	parameter infoN 	= {flag, address, mac, llc, infoF, FCST, flag}; //64 bit
	parameter infoEV 	= {flag, address, mac, llc, infoT, FCST, flag};
	parameter wrongFCS 	= {flag, address, mac, llc, infoT, FCSF, flag};
	
	integer count; 
	reg [447:0] fm0_msg;
	reg [2:0] outputTB;
	integer k;
	parameter s0_reset = 3'b000, s1_preamble = 3'b001, s2_infoN = 3'b010, s3_infoEV = 3'b011, s4_wrongFCS = 3'b100;
	
	decoder decoderTest (.fm0(fm0), .reset(reset), .clk(clk_500kHz), .nrz(nrz));
	listener listenerTest (.nrz(nrz), .reset(reset), .clk_50MHz(clk_50MHz), .clk_500kHz(clk_500kHz), .interrupt(interrupt));
	
	function [447:0] bitsToFM0;	//convert 224 bits nrz seq to 448 bit FM0 seq
		input [223:0] nrzBits; //224 bit nrz sequence
		integer i;
		begin
			for(i = 447; i >= 0; i = i - 2) begin
				if(i == 447)
					bitsToFM0[i] = 1'b1;
				else
					bitsToFM0[i] = !bitsToFM0[i+1];
				
				if(nrzBits[(i-1)/2] == 1'b1)
					bitsToFM0[i-1] = bitsToFM0[i];
				else
					bitsToFM0[i-1] = !bitsToFM0[i];	
			end
		end
	endfunction
	
		
	
	initial //input stimulus 
		begin
			clk_50MHz = 0;
			clk_fm0 = 0;
			reset = 1;
			fm0_msg = bitsToFM0({preamble, infoN, preamble, infoEV, preamble, wrongFCS, preamble});
			//[447:432]preamble, [431:304]infoN, [303:288]preamble, [287:160]infoEV, [159:144]preamble, 
			//[143:16]wrongFCS, [15:0]preamble
			#1000
			reset = 0;
			//state = s0_reset;
			
		end
		
	always @(posedge clk_fm0)begin
		if(reset == 1) 
			begin
			fm0 = 1'b0;
			count = 447;
			outputTB <= s0_reset;
			end
		else 
			begin
			fm0 = fm0_msg[count];
			count = count - 1;
			if((count > 303) && (count < 432))
				outputTB <= s2_infoN;
			else if((count > 159) && (count < 288))
				outputTB <= s3_infoEV;
			else if((count > 15) && (count < 144))
				outputTB <= s4_wrongFCS;
			else
				outputTB <= s1_preamble;
			end
	end 
		
		
//	always @(state)begin //change fm0 output according to state
//		case(state)
//			s0_reset:
//				assign fm0_msg = bitsToFM0({flag, address, mac, llc, infoF, FCST, flag});
//			s1_preamble:
//				assign fm0_msg = bitsToFM0({flag, address, mac, llc, infoF, FCST, flag});
//			s2_infoN:
//				assign fm0_msg = bitsToFM0({flag, address, mac, llc, infoF, FCST, flag});
//			s3_infoEV:
//				assign fm0_msg = bitsToFM0({flag, address, mac, llc, infoT, FCST, flag});
//			s4_wrongFCS:
//				assign fm0_msg = bitsToFM0({flag, address, mac, llc, infoT, FCSF, flag});
//		endcase
//	end
		
//	always @(posedge clk_fm0) begin
//		case(state)//send fm0 output
//			s0_reset: begin
//				reset = 1'b1;
//				state = s1_preamble;
//				count = 15;	 
//				end
//			s1_preamble: begin
//				reset = 1'b0;
//				fm0 = fm0_pre[count];
//				if (count > 0) begin
//					state = s1_preamble;
//					count = count - 1;
//					end
//				else begin
//					state = s2_infoN;
//					count = 127;
//				end
//				end
//			s2_infoN: begin
//				fm0 = fm0_msg[count];
//				if (count > 0) begin
//					state = s2_infoN;
//					count = count - 1;
//					end
//				else begin
//					state = s3_infoEV;
//					count = 127;
//				end	 
//				end
//			s3_infoEV: begin
//				fm0 = fm0_msg[count];
//				if (count > 0) begin
//					state = s3_infoEV;
//					count = count - 1;
//					end
//				else begin
//					state = s4_wrongFCS;
//					count = 127;
//				end
//				end
//			s4_wrongFCS: begin
//				fm0 = fm0_msg[count];
//				if (count > 0) begin
//					state = s4_wrongFCS;
//					count = count - 1;
//					end
//				else begin
//					state = s1_preamble;
//					count = 15;
//				end	
//				end
//			endcase
//	end
		
		
	always begin//clock generation 50MHz
		#10 clk_50MHz = !clk_50MHz;
	end	
	
	always begin //clock generation fm0
		#500 clk_fm0 = !clk_fm0;
	end
	
endmodule
