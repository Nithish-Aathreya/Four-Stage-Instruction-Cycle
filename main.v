`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2024 22:51:14
// Design Name: 
// Module Name: main
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


module main(clk1,clk2,rd,rs1,rs2,func,addr,zout);
input clk1,clk2;
input [3:0]rs1,rs2,rd,func;
input [7:0]addr;
output reg [15:0]zout;

reg [15:0]regbank[15:0];
reg [15:0]memory[255:0];

reg [15:0]l12a,l12b;
reg [3:0]l12rd,l12func;
reg [7:0]l12addr;

reg [15:0]l23z;
reg [3:0]l23rd;
reg [7:0]l23addr;

parameter add=4'b0000,sub=4'b0001,nega=4'b0010;

reg [7:0]l34addr;
reg [15:0]l34z;




always @(posedge clk1)
begin
l12a<=regbank[rs1];
l12b<=regbank[rs2];
l12rd<=rd;
l12func<=func;
l12addr<=addr;
end

always @(posedge clk2)  //stage2
begin
l23rd<=l12rd;
l23addr<=l12addr;
case(l12func)
add: l23z = l12a + l12b;
sub: l23z = l12a - l12b;
nega: l23z = ~l12a;
default:l23z=16'b0;
endcase
end


always @(posedge clk1)  //stage3
begin
l34addr<=l23addr;
l34z<=l23z;
regbank[l23rd]<=l23z;
end

always @(posedge clk2)
begin
memory[l34addr]<=l34z;
zout<=l34z;
end
endmodule