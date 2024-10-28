`timescale 1ns / 1ps

module bcd_to_ascii(
   output [(6*8)-1:0] message, // 6 ascii characters
   input give_change,
   input [11:0] amount_bcd,
   input dispense
   );

//   assign the values to the 6 characters to be output
//
//   these should be the ascii values for the amount on the display
//    
//   also remember to output the characters "PAID" when we are dispensing   
//  
//   the last two characters should be "8'h0D" (carriage return)
//   and "8'h0A" (line feed).
//   

endmodule
   
