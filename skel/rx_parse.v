`timescale 1ns / 1ps

module rx_parse(
   input clk,
   input reset, 
   input rx_dv,
   input [7:0] rx_byte, 
   output reg select, 
   output reg q25, 
   output reg d10,
   output reg [2:0] item
   );

    always @(posedge clk or posedge reset)
    begin
        if (reset) begin
 	    item <= 0;
            select <= 0;
            q25 <= 0;
            d10 <= 0;
        end else begin

//
//  create the select, q25, d10 pulses depending on the input character
//
//  also, if you receive a character between "0" and "7",
//    set item to the correct item number
//	   

        end
    end

endmodule

