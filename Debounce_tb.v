`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:10:23 09/15/2017
// Design Name:   Debounce
// Module Name:   C:/Users/Whitepaper/OneDrive/2017Fall_CSULB/CECS 360 Integrated Circuit Design/Projects/Project1_count_on_7seg/Debounce_tb.v
// Project Name:  Project1_count_on_7seg
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Debounce
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Debounce_tb;

	// Inputs
	reg clk;
	reg rst;
	reg tick;
	reg db_in;

	// Outputs
	wire db_out;

	// Instantiate the Unit Under Test (UUT)
	Debounce uut (
		.clk(clk), 
		.rst(rst), 
		.tick(tick), 
		.db_in(db_in), 
		.db_out(db_out)
	);

   always #5 clk = ~clk;
   always #10 tick = ~tick;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		tick = 0;
		db_in = 0;

		// Wait 100 ns for global reset to finish
		#5 rst = 0; db_in = 1;
      #70 db_in = 1;
      #70 db_in = 0;
      #70 db_in = 1;
      #100
		// Add stimulus here
      $finish;


	end
      
endmodule

