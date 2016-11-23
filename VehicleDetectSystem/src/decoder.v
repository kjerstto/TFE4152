//-----------------------------------------------------------------------------
//
// Title       : decoder
// Design      : VehicleDetectSystem
// Author      : Kjersti
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : c:\My_Designs\VehicleDetectSystem\VehicleDetectSystem\src\decoder.v
// Generated   : Tue Nov 15 09:45:27 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : Decoder converts FM0 signal to NRZ, and generates clock signal.
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

module decoder ( fm0 ,reset ,nrz ,clk );

output nrz ;
wire nrz ;
output clk ;
wire clk ;

input fm0 ;	
input reset;
wire fm0 ; 
wire a, b, c, d, e, f;
reg delA, delB, delC;



xor xor1 (c, fm0, e);
xor xor2 (clk, a, b);

dff dff1 (.CK(clk), .D(fm0), .Q(d), .NQ(e));
dff dff2 (.CK(clk), .D(c), .Q(), .NQ(f));

assign a = delA;
assign b = delB;
assign nrz = delC;

always @(posedge reset)
	begin
		delA = 1'b0;
		delB = 1'b0;
		delC = 1'b0;
	end

//delay A
always @(fm0)
	delA <= #1500 fm0;

//delay B
always @(d)
	delB <= #1000 d;
	
//delay C
always @(f)
	delC <= #500 f;

endmodule
