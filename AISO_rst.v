`timescale 1ns / 1ps
/* ********************************* CECS 360 *********************************
 *    Name:       Chanartip Soonthornwan
 *    Email:      Chanartip.Soonthornwan@gmail.com
 *    Filename:   
 *    Date:       September 8, 2017
 *    Purpose:
 *
 *
 *    Note:
 *
 *    Version:     1.0     Rev date: 9/8/2017
 *
 * ****************************************************************************/
module AISO_rst(clk, rst, rst_s);
   
   input      clk, rst;                 // on-board clock, and AISO reset signal
   output  wire  rst_s;                 // Synchronized reset signal
   reg          q1, q2;                 // registers
   
   always@(posedge clk, posedge rst) 
      if(rst) {q1,q2} <= 2'b0;          // reset
      else    {q1,q2} <= {1'b1, q1};    // q2 gets q1, and q1 get 1'b1
      
   /* 
    * if reset(rst) is HIGH, the output will be HIGH
    * else output will always be LOW
    */
   assign rst_s = ~q2;
   
endmodule
