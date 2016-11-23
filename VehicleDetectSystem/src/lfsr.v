//-----------------------------------------------------------------------------
//
// Title       : lfsr
// Design      : VehicleDetectSystem
// Author      : Kjersti
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\VehicleDetectSystem\VehicleDetectSystem\src\lfsr.v
// Generated   : Tue Nov 22 19:23:32 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : Linear feedback shift register (LFSR) 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {lfsr}}
module lfsr ( si , out, clk, rst);

//I/O ports
output out ;
wire out ;	

input clk;
input rst;
input si ; 

//internal signals and registers
reg [15:0] shift; 

always @(posedge clk) begin
	if(rst == 1) begin
		shift <= 16'b0;
		end
	else begin 
		shift <= shift >> 1;
		shift[10] <= (shift[0] ^ si) ^ shift[11];
		shift[3]  <= (shift[0] ^ si) ^ shift[4];
		shift[15] <= (shift[0] ^ si);
		end
	end	
	
	assign out = (shift == 16'b0) ? 1'b1 : 1'b0;


	
	
	
//	xor x1 (d10, d15, out[11]); 
//	xor x2 (d3, d15, out[4]);
//	xor x3 (d15, si, out[0]);
//
//    dff dff15 (.Q(out[15]), .NQ(), .D(d15), .CK(clk));
//	dff dff14 (.Q(out[14]), .NQ(), .D(q15), .CK(clk));
//	dff dff13 (.Q(out[13]), .NQ(), .D(q14), .CK(clk));
//	dff dff12 (.Q(out[12]), .NQ(), .D(q13), .CK(clk));
//	dff dff11 (.Q(out[11]), .NQ(), .D(q12), .CK(clk));
//	dff dff10 (.Q(out[10]), .NQ(), .D(d10), .CK(clk));
//	dff dff9 (.Q(out[9]), .NQ(), .D(q10), .CK(clk));
//	dff dff8 (.Q(out[8]), .NQ(), .D(q9), .CK(clk));
//	dff dff7 (.Q(out[7]), .NQ(), .D(q8), .CK(clk));
//	dff dff6 (.Q(out[6]), .NQ(), .D(q7), .CK(clk));
//	dff dff5 (.Q(out[5]), .NQ(), .D(q6), .CK(clk));
//	dff dff4 (.Q(out[4]), .NQ(), .D(q5), .CK(clk));
//	dff dff3 (.Q(out[3]), .NQ(), .D(d3), .CK(clk));
//	dff dff2 (.Q(out[2]), .NQ(), .D(q3), .CK(clk));
//	dff dff1 (.Q(out[1]), .NQ(), .D(q2), .CK(clk));
//	dff dff0 (.Q(out[0]), .NQ(), .D(q1), .CK(clk));
	


endmodule
