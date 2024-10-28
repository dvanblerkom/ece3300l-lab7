`timescale 1ns / 1ps

module master_fsm(
		  input		   clk,
		  input		   reset,
		  input [7:0]	   item_cost,
		  input		   select,
		  input		   q25,
		  input		   d10,
		  input		   sending,
		  output reg [2:0] fsm_state,
		  output reg [7:0] amount
		  );

   localparam		       WAITSELECTION = 0;
   localparam		       WAITPAYMENT = 1;
   localparam		       GOTQUARTER = 2;
   localparam		       GOTDIME = 3;
   localparam		       DISPENSING = 4;
   localparam		       CHANGERETURN = 5;

   reg [2:0]		       next_state;
   reg [7:0]		       new_amount;

   always @(posedge clk or posedge reset)
     if (reset) begin
	fsm_state <= WAITSELECTION;
	amount <= 0;
     end else begin
	fsm_state <= next_state;
	amount <= new_amount;
     end

   always @(*)
     begin

	case (fsm_state)

// write the cases for the states	  

	endcase // case (fsm_state)
     end
endmodule
   
