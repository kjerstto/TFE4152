//-----------------------------------------------------------------------------
//
// Title       : listener
// Design      : VehicleDetectSystem
// Author      : Kjersti
// Company     : NTNU
//
//-----------------------------------------------------------------------------
//
// File        : C:\My_Designs\VehicleDetectSystem\VehicleDetectSystem\src\listener.v
// Generated   : Thu Nov 17 14:22:15 2016
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : Listener receives NRZ data signal, listens for infoEV message
// and outputs interrupt signal if message is found. 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

module listener (reset, nrz ,clk_500kHz, clk_50MHz ,interrupt );

output interrupt ;
reg interrupt ;

input nrz ;
input reset;
input clk_50MHz ;
input clk_500kHz;

reg [2:0] state, next_state;
reg [63:0] sipo;  	 
reg [6:0] count; 

reg rst_lfsr;
reg si_lfsr;
reg out_lfsr;
reg interrupted;

	sipo sipo1 (.dout(sipo), .din(nrz), .clk(clk_500kHz), .reset(reset));
	lfsr lfsr1 (.clk(clk_50MHz), .rst(rst_lfsr), .si(si_lfsr), .out(out_lfsr));
	
	parameter s0_Listening = 3'b000;
	parameter s1_FCSCheck = 3'b001;
	parameter s2_InterpretMsg  = 3'b010;
	parameter s3_Interrupt = 3'b011;

	
	always @ (posedge clk_50MHz or posedge reset)
		if (reset == 1) 
			begin
				state <= s0_Listening;
				interrupt = 1'b0;
			end
		else 
			state <= next_state;
	
	always @ (posedge clk_50MHz)
		if (reset == 1)
			begin
				state <= s0_Listening;
				interrupt = 1'b0;
				interrupted = 1'b0;
			end
		else	
			case (state)
				s0_Listening: //Go to s1 if flags present
					if ((sipo[63:56]==8'b01111110) && (sipo[7:0] == 8'b01111110)) begin
						if (interrupted == 1'b0) begin
							state <= s1_FCSCheck;
							rst_lfsr = 1'b1; //Reset LFSR to prepare for FCSCheck
							count = 55; //Set upper index for interval of SIPO register to be checked in FCSCheck.
							end
						else
							state <= s0_Listening;
						end
					else begin
						state <= s0_Listening;
						interrupted = 1'b0; //Reset "interrupt sent"-flag 
						end
				s1_FCSCheck: //Check FCS field by polynomial division. Go to S2 if pass, S0 if fail. 
					begin 	
					rst_lfsr = 1'b0;
					if(count > 7) begin //Shift SIPO[55:8] into LFSR, bit by bit
						si_lfsr = sipo[count];
						count = count - 1;
						state <= s1_FCSCheck;
						end
					else 
						if(out_lfsr) //LFSR has only zeroes on 49th iteration (FCS pass)
							state <= s2_InterpretMsg;
						else //FCS fail
							state <= s0_Listening;
					end		 
				s2_InterpretMsg: //Check for 01010101
					if (sipo[31:24] == 8'b01010101)	//Emergency Vehicle nearby
						begin
							state <= s3_Interrupt;
							count = 7'b000;	 
						end	
					else //No Emergency Vehicle nearby
						state <= s0_Listening;
				s3_Interrupt: //Send interrupt for 4 FSM cycles
					begin
					count = count + 1;
					if (count < 5)
						begin
							interrupt = 1'b1;
							interrupted = 1'b1;	// Interrupt has been sent for this message
							state <= s3_Interrupt;
						end	
					else
						begin
							interrupt = 1'b0;
							state <= s0_Listening; 
						end	
					end	
			endcase


endmodule
