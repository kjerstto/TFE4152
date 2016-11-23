//-----------------------------------------------------------------------------
//
// Title       : lfsr2
// Design      : VehicleDetectSystem
// Author      : Kjersti
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\VehicleDetectSystem\VehicleDetectSystem\src\lfsr2.v
// Generated   : Wed Nov 23 11:26:08 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {lfsr2}}
module lfsr2 ( si , out, clk, rst);

//I/O ports
output [15:0]out ;
reg [15:0] out ;	

input clk;
input rst;
input si ; 

	always @(posedge clk)begin
		if(reset) begin //set all registers to 0
			
			end
		else begin //shift in data through si
		
		end
	end	

	
	xor x1 (d10, d15, out[11]); 
	xor x2 (d3, d15, out[4]);
	xor x3 (d15, si, out[0]);

    dff dff15 (.Q(out[15]), .NQ(), .D(d15), .CK(clk));
	dff dff14 (.Q(out[14]), .NQ(), .D(d14), .CK(clk));
	dff dff13 (.Q(out[13]), .NQ(), .D(d13), .CK(clk));
	dff dff12 (.Q(out[12]), .NQ(), .D(d12), .CK(clk));
	dff dff11 (.Q(out[11]), .NQ(), .D(d11), .CK(clk));
	dff dff10 (.Q(out[10]), .NQ(), .D(d10), .CK(clk));
	dff dff9 (.Q(out[9]), .NQ(), .D(d9), .CK(clk));
	dff dff8 (.Q(out[8]), .NQ(), .D(d8), .CK(clk));
	dff dff7 (.Q(out[7]), .NQ(), .D(d7), .CK(clk));
	dff dff6 (.Q(out[6]), .NQ(), .D(d6), .CK(clk));
	dff dff5 (.Q(out[5]), .NQ(), .D(d5), .CK(clk));
	dff dff4 (.Q(out[4]), .NQ(), .D(d4), .CK(clk));
	dff dff3 (.Q(out[3]), .NQ(), .D(d3), .CK(clk));
	dff dff2 (.Q(out[2]), .NQ(), .D(d2), .CK(clk));
	dff dff1 (.Q(out[1]), .NQ(), .D(d1), .CK(clk));
	dff dff0 (.Q(out[0]), .NQ(), .D(d0), .CK(clk));
	


endmodule
