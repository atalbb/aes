`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2018 05:55:38 PM
// Design Name: 
// Module Name: aesWrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module aesWrapper(clk,rst,start,data,finalDone
    );
    input clk,start;
    output rst;
    output [127:0]data;
    output finalDone;
    
reg [127:0]data;
reg finalDone;
//define states
parameter s_init = 6'd00;

parameter s_delay0 = 6'd01;
parameter s_delay1 = 6'd02;
parameter s_delay2 = 6'd03;
parameter s_delay3 = 6'd04;

parameter s_block0 = 6'd11;
parameter s_block1 = 6'd12;
parameter s_block2 = 6'd13;
parameter s_block3 = 6'd14;

parameter done = 6'd21;
parameter clkDelay = 6'd50;

//parameter s_r0 = 4'd01;
//parameter s_rx_1 = 4'd02;
//parameter s_rx_2 = 4'd05;
//parameter s_rx_3 = 4'd06;
////    parameter s_last = 4'd03;
//parameter s_done = 4'd04;    
reg [5:0] curr_state;
reg [5:0]count0;
reg [5:0]count1;
reg [5:0]count2;
reg [5:0]count3;



	// Next-State logic
always @(posedge clk or posedge rst) // Changing state on clock edge
	begin
		if (rst)
			curr_state <= s_init;
		else begin
			case (curr_state)
				s_init: begin
                    //Note: Start should stay low at least one clock cycle after reset
                    if (start)
                        curr_state <= s_block0;
                    else
                        curr_state <= s_init;
                     end
            
                s_block0: begin curr_state <= s_delay0; end
                
                s_delay0: begin 
                            if(count0 >= clkDelay)
                                curr_state <= s_block1;
                          end
                
                s_block1: begin curr_state <= s_delay1;end
                
                s_delay1:begin 
                            if(count1 >= clkDelay)
                                curr_state <= s_block2;
                        end
                
                s_block2: begin curr_state <= s_delay2; end
                
                s_delay2: begin 
                             if(count2 >= clkDelay)    
                                curr_state <= s_block3;
                            end
                
                s_block3: begin curr_state <= s_delay3;end
                
                s_delay3:begin 
                            if(count3 >= clkDelay)
                                curr_state <= done;
                          end
                
                done:begin  end
                
				default: begin curr_state <= s_init;end
			endcase
		end
				
	end

	// State execution
	always @(curr_state or count0 or count1 or count2 or count3)
	begin
	
	case (curr_state)
		s_init: begin finalDone = 0;count0 = 0;count1 = 0;count2 = 0;count3 = 1;end 
                       
		s_block0: begin data = 128'h 00112233445566778899aabbccddeeff; end
		
		s_delay0: begin  count0 = count0 + 1;end
		
        s_block1: begin data = 128'h ffeeddccbbaa99887766554433221100;  end
        
        s_delay1: begin count1 = count1 + 1;end
		
		s_block2: begin data = 128'h 0123456789abcdef0123456789abcdef;  end
        
        s_delay2: begin count2 = count2 + 1; end
        
		s_block3: begin data = 128'h fedcba9876543210fedcba9876543210;  end
        
        s_delay3: begin count3 = count3 + 1;end			
        
        done:begin finalDone = 1;  end
				
		
		default: ; //Null
	endcase
	end

endmodule
