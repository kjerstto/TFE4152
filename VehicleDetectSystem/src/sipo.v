//-----------------------------------------------------------------------------
//
// Title       : sipo
// Design      : VehicleDetectSystem
// Author      : Kjersti
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : C:\My_Designs\VehicleDetectSystem\VehicleDetectSystem\src\sipo.v
// Generated   : Thu Nov 17 14:26:28 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 64 bit serial in - parallel out register
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {sipo}}
// Parameterized serial-in, parallel-out shift register
module sipo (dout, din, clk, reset); 
	parameter WIDTH = 64;
	output [WIDTH-1:0] dout;
	input din, clk, reset; 
	reg [WIDTH-1:0] dout;
	
	always @(posedge clk or posedge reset)
		if (reset)
			dout <= {WIDTH{1'b0}};
		else
			begin
				dout <= {dout[WIDTH-2:0], din};
			end
endmodule

