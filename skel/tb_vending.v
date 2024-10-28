`timescale 1ns / 1ps

module tb_vending;
    // Signal declaration
   reg clk;
   reg reset;
   reg tx_start;
   reg [7:0] tx_data1;
   wire [7:0] rx_data1;
   wire	       tx_done1;
   wire	       tx_ready1;
   wire	       UART_RX, UART_TX;
   wire	       rx_dv1;
   reg [7:0]   testdata;
   wire [2:0]  fsm_state;
   wire [6:0]  inv_leds;
   wire [7:0]  enb_leds;

   reg [7:0]   testinput [7:0];
 
    // Clock generation
    always #5 clk = ~clk; // Generate a clock with a period of 10 ns

    // Testbench UART instances
    uart_tx_vlog uart_tx_tb (
        .i_Clock(clk),
        .i_Tx_DV(tx_start),
        .i_Tx_Byte(tx_data1),
        .o_Tx_Serial(UART_RX),
        .o_Tx_Done(tx_done1),
        .o_Tx_Ready(tx_ready1) 
    );

    uart_rx_vlog uart_rx_tb (
        .i_Clock(clk),
        .i_Rx_Serial(UART_TX), 
        .o_Rx_Byte(rx_data1),
        .o_Rx_DV(rx_dv1)
    );

   vending dut0 (
		 // Outputs
		 .inv_leds		(inv_leds[6:0]),
		 .enb_leds		(enb_leds[7:0]),
		 .fsm_state		(fsm_state[2:0]),
		 .UART_TX		(UART_TX),
		 // Inputs
		 .clk			(clk),
		 .reset			(reset),
		 .UART_RX		(UART_RX));

   initial begin
      testinput[0] = "2";
      testinput[1] = "S";
      testinput[2] = "Q";
      testinput[3] = "Q";
      testinput[4] = "D";
      testinput[5] = "D";
      testinput[6] = "Q";
      testinput[7] = "x";
   end      

    initial begin
       clk = 0;
       tx_start = 0;
       reset = 1;
       #11 reset = 0;
       #20;

       for (testdata = 0; testdata <= 7; testdata = testdata + 1) begin
          #20;
	  tx_data1 = testinput[testdata]; 
          #20;
	  
          tx_start = 1; 
          #10 tx_start = 0;
	  $display("SENT: '%c", tx_data1);
          #14000000;
       end 
       
    end


initial
  begin
     #1000;
     forever
       begin
          wait (rx_dv1);
	  $display("RECEIVED: '%c", rx_data1);
          #200;
       end
  end
     
//    initial begin
//       $dumpfile("tb_vending.vcd");
//       $dumpvars(0,tb_vending);
//    end

endmodule
