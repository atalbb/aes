`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/07/2017 05:11:14 PM
// Design Name: 
// Module Name: ciphertextAddrCounter
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


module expandedKeyAddrCounter(input wire clk,
                            input wire rst,
                            input wire enable,
                            output reg valid,
                            output reg [7:0]addr                           
    );
reg [1:0]flag;
parameter N = 59; // Number of 32 bits words in expanded key - 1

    
always@(posedge clk or negedge rst) begin
    if(!rst)begin
        flag <= 0;
        valid <= 0;
        addr <= 0;
    end else begin
        if(enable)begin
            if(flag == 0)begin
                valid <= 1; 
                flag <= 1;
            end else if(flag == 1)begin
                if(addr < N)begin
                    addr <= addr + 1;
                end else begin
                    flag <= 2;
                    valid <= 0;                    
                end
            end                        
        end else begin
            if(flag == 2)begin   
                addr <= 0;
                valid <= 0;
                flag  <= 0;
            end
        end
    end
end

endmodule