//-----------------------------------------------------------------------------
//
// Title       : decoder_TB
// Design      : VehicleDetectSystem
// Author      : Kjersti
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\VehicleDetectSystem\VehicleDetectSystem\src\decoder_TB.v
// Generated   : Tue Nov 15 10:13:30 2016
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
//{module {decoder_TB}}
module decoder_TB ();

	reg fm0;
	reg reset;
	wire clk;
	wire nrz;
	
	decoder decoderTest (.fm0(fm0), .reset(reset), .clk(clk), .nrz(nrz));
	
	initial begin
		reset = 1'b1;
		#500
		reset = 1'b0;
		#500
		fm0 = 1'b1;//0
		#1000
		fm0 = 1'b0;
		#1000
		fm0 = 1'b1;//1
		#2000
		fm0 = 1'b0;//0
		#1000
		fm0 = 1'b1;
		#1000
		fm0 = 1'b0;//0
		#1000
		fm0 = 1'b1;
		#1000
		fm0 = 1'b0;//1
		#2000
		fm0 = 1'b1;//1
		#2000
		fm0 = 1'b0;//0
		#1000
		fm0 = 1'b1;
		#1000
		fm0 = 1'b0;//1
		#2000
		fm0 = 1'b1;//0
		#1000
		fm0 = 1'b0;
		#1000
		$finish;
		
	end

endmodule
