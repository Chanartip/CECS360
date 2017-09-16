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
module SSG_Driver(clk, rst, count, anode, sseg);

   input         clk, rst;                // 200Hz clock and reset signal
   input  [15:0]    count;                // 16-bit data input
   output [ 3:0]    anode;                // anode selected output
   output [ 6:0]     sseg;                // 7-segment selected output
   
   wire   [ 1:0]  mux_sel;                // multiplex 4-bit from count selection
   wire   [ 3:0]      hex;                // 4-bit from mux to decode to 7-seg
   
   // 4 to 7 bit hex decoder
   //    Recieves 4 bit input in binary from Mux4to1
   //    and converts to 7-bit output for displaying
   //    on 7-segment display
   hex_to7segment ssg0 (.hex(hex),        // 4-bit data input
                        .sseg(sseg)       // 7-bit output represent each segment
                        );
                        
   // LED controler
   //    A finite state machine(FSM) to select
   //    an Anode to display and what segment 
   //    7-segment of each anode to display
   led_controller ssg1(.clk(clk),         // 200Hz clock
                       .reset(rst),       // AISO reset
                       .anode(anode),     // Selected anode output
                       .seg_sel(mux_sel)  // Selected 4-bit to convert
                       );
                       
   // 4 to 1 Multiplexer         
   //    Selecting which 4-bit input from count
   //    to be converted and display on 7-segment
   Mux4to1 ssg2 (.D(count),               // 16-bit input
                 .sel(mux_sel),           // input selection
                 .Q(hex)                  // 7-bit output for 7-segment display
                 );
endmodule
