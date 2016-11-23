//-----------------------------------------------------------------------------
//
// Title       : dff
// Design      : VehicleDetectSystem
// Author      : Kjersti
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\VehicleDetectSystem\VehicleDetectSystem\src\dff.v
// Generated   : Tue Nov 15 10:00:30 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : D flip-flop
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {dff}}
module dff (Q, NQ, D, CK);
	output Q; 
	output NQ;
	input D, CK;
	reg Q;
	
	assign NQ = !Q;
	
	always @(posedge CK)
		Q <= D;

endmodule
