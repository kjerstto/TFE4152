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
	
	assign out = (shift == 16'b0) ? 1'b1 : 1'b0; //out = 1 if LFSR all zeroes

endmodule
