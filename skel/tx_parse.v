`timescale 1ns / 1ps

module tx_parse(
   input clk, 
   input reset,
   output tx_dv, 
   output [7:0] tx_byte, 
   input tx_ready, 
   input [(6*8)-1:0] message,
   output sending
   );
    
   reg [(6*8)-1:0] saved_message;
   reg [2:0] char_cnt;
   reg prev_tx_ready;

   assign sending = (char_cnt != 0);
   assign tx_dv = (tx_ready && sending);   // set data_valid if we still have characters to send and the TX is ready

   assign tx_byte = saved_message[((char_cnt*8)-1) -: 8];
   
   always @(posedge clk or posedge reset)
     begin
	if (reset) begin
           saved_message <= 0;
           char_cnt <= 0;
           prev_tx_ready <= 0;
	end else begin
           if (sending && (~tx_ready & prev_tx_ready))    // move to next character if we just started sending
             char_cnt <= char_cnt - 1;
           if (~sending && (saved_message != message)) begin  // start sending if the message changed
              char_cnt <= 6;
	      saved_message <= message;
	   end
           prev_tx_ready <= tx_ready;
	end   
     end

endmodule
   
