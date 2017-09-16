`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Engineer:   Chanartip Soonthornwan
// Email:      Chanartip.Soonthornwan@gmail.com
// Filename:   hex_to7segment.v
// module:     hex_to7segment
// Date:       September 7, 2016
// Version:    1.0
//
// Purpose:    Converting 4-bit input(hex) to be 7-bit output representing
//             each node on 7-segment display(a,b,c,d,e,f,g)
//
// Note:       The letter 'b' and 'd' will not be capitalized.
//             and '-' will be default or input that's not hex.
//  
// Revision date: June 14, 2017
// Version      : 1.1
// Update       : re-arrange comments and change some variables names.
//
// Revision date: September 16, 2017
// Version      : 1.2
// Update       : change port list from each segment represents(acbdefg)
//                one 7-bit output, and update case statement.
//
////////////////////////////////////////////////////////////////////////////////////
module hex_to7segment(hex, sseg);
   
   input      [3:0]   hex;
   output reg [6:0]  sseg;
   
   always @ (hex) 
      case(hex)                      //abcdefg
         4'h0:    sseg = 7'b0000001; // 0
         4'h1:    sseg = 7'b1001111; // 1
         4'h2:    sseg = 7'b0010010; // 2
         4'h3:    sseg = 7'b0000110; // 3
         4'h4:    sseg = 7'b1001100; // 4
         4'h5:    sseg = 7'b0100100; // 5
         4'h6:    sseg = 7'b0100000; // 6
         4'h7:    sseg = 7'b0001111; // 7
         4'h8:    sseg = 7'b0000000; // 8
         4'h9:    sseg = 7'b0000100; // 9
         4'hA:    sseg = 7'b0001000; // A
         4'hB:    sseg = 7'b1100000; // b
         4'hC:    sseg = 7'b0110001; // C
         4'hD:    sseg = 7'b1000010; // d
         4'hE:    sseg = 7'b0110000; // E
         4'hF:    sseg = 7'b0111000; // F
         default: sseg = 7'b1111110; // -
      endcase

endmodule
