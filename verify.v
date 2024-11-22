`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2024 00:08:56
// Design Name: 
// Module Name: verify
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


module verify();
reg clk1,clk2;
reg [3:0]rs1,rs2,rd,func;
reg [7:0]addr;
wire [15:0]zout;
integer k;

main con(clk1,clk2,rd,rs1,rs2,func,addr,zout);

initial
begin
clk1=1'b0; 
clk2=1'b0;
repeat(30)
begin
#5 clk1=1'b1; #5 clk1=1'b0;
#5 clk2=1'b1; #5 clk2=1'b0;
end
end

initial
begin
for(k=0;k<=15;k=k+1)
con.regbank[k]=k;
end

initial
begin

#5 rs1=4'b0011;rs2=4'b0101;func=4'b0000;rd=4'b1010;addr=125;

#60 for(k=125;k<130;k=k+1)
begin
//con.memory[k]=16'b0;
$display("memory[%3d]=%3d",k,con.memory[k]);
end

#500 $finish;
end





endmodule
