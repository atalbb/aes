`timescale 10ns / 1ps

module KeyGeneration(rc,key,keyout);
    
   input [3:0] rc;
   input [127:0]key;
   output reg [127:0] keyout;
    
    
   always @(rc)
    case (rc)
       4'h0000: keyout=128'h 101112131415161718191a1b1c1d1e1f;
	   4'h0001: keyout=128'h a573c29fa176c498a97fce93a572c09c;
	   4'h0002: keyout=128'h 1651a8cd0244beda1a5da4c10640bade;
	   4'h0003: keyout=128'h ae87dff00ff11b68a68ed5fb03fc1567;
	   4'h0004: keyout=128'h 6de1f1486fa54f9275f8eb5373b8518d;
	   4'h0005: keyout=128'h c656827fc9a799176f294cec6cd5598b;
	   4'h0006: keyout=128'h 3de23a75524775e727bf9eb45407cf39;
	   4'h0007: keyout=128'h 0bdc905fc27b0948ad5245a4c1871c2f;
	   4'h0008: keyout=128'h 45f5a66017b2d387300d4d33640a820a;
	   4'h0009: keyout=128'h 7ccff71cbeb4fe5413e6bbf0d261a7df;
	   4'h000a: keyout=128'h f01afafee7a82979d7a5644ab3afe640;
	   4'h000b: keyout=128'h 2541fe719bf500258813bbd55a721c0a;
	   4'h000c: keyout=128'h 4e5a6699a9f24fe07e572baacdf8cdea;
	   4'h000d: keyout=128'h 24fc79ccbf0979e9371ac23c6d68de36;
	endcase

endmodule
 
