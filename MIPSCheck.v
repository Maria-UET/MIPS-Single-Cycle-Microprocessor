`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:41:26 12/21/2016 
// Design Name: 
// Module Name:    MIPSCheck 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MIPSCheck(input [4:0] user_addr, input user,  rst, clk);
	
	wire [5:0] func, opcode;
	wire [1:0] pc_sel;
	wire [2:0] alu_sel;
	MIPS_CTRL ctrl(pc_sel, r1_addr_sel, w_addr_sel, w_data_sel, alu_in_sel, alu_sel,pc_en, reg_w_en, dmem_w_en, user, opcode, func, is_zero);							

	MIPS_dataPath dataPath (user_disp, func, opcode, is_zero , user_addr, pc_sel, r1_addr_sel, w_addr_sel, w_data_sel, alu_in_sel, alu_sel,pc_en, reg_w_en, dmem_w_en,clk,rst);	
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:57:43 12/18/2016 
// Design Name: 
// Module Name:    MIPS_CTRL 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MIPS_CTRL( pc_sel, r1_addr_sel, w_addr_sel, w_data_sel, alu_in_sel, alu_sel,pc_en, reg_w_en, dmem_w_en, user, opcode, func, is_zero);
	 output reg [1:0] pc_sel;
    output reg r1_addr_sel;
    output reg w_addr_sel;
    output reg w_data_sel;
    output reg [2:0] alu_sel; 
    output reg alu_in_sel;
	 output reg pc_en;
    output reg reg_w_en;
    output reg dmem_w_en;
    input user,is_zero;
    input [5:0] opcode;
    input [5:0] func;
	 
	 initial
	 begin
	 pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b0; pc_en=0; reg_w_en=0; dmem_w_en=0;
	 end
		
	 
	always@(user, opcode, func,is_zero)
	begin
	//R Type: add, sub, or, xor, and, sltu,slt,jr.
	//I Type: addi, ori, andi, slti, lw, sw, beq, bneq.
	//J Type: j.
		if(user==1)
		begin
		pc_sel=2'b0; r1_addr_sel=1; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b0; pc_en=0; reg_w_en=0; dmem_w_en=0;
		end 
		
		else if(opcode==6'b0)//You are dealing with R type
		begin
			case (func)
			6'h20 : begin pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b000; pc_en=1; reg_w_en=1; dmem_w_en=0; end
			6'h22 : begin pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b001; pc_en=1; reg_w_en=1; dmem_w_en=0; end
			6'h25 : begin pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b010; pc_en=1; reg_w_en=1; dmem_w_en=0; end
			6'h26 : begin pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b011; pc_en=1; reg_w_en=1; dmem_w_en=0; end
			6'h24 : begin pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b100; pc_en=1; reg_w_en=1; dmem_w_en=0; end
			6'h2B : begin pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b101; pc_en=1; reg_w_en=1; dmem_w_en=0; end
			6'h2A : begin pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b110; pc_en=1; reg_w_en=1; dmem_w_en=0; end
			6'h8 :  begin pc_sel=2'b1; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b111; pc_en=1; reg_w_en=0; dmem_w_en=0; end
			default: begin pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b000; pc_en=0; reg_w_en=0; dmem_w_en=0;end
			endcase
		end
		
		else if(opcode==6'h8)//addi
		begin//w_addr_sel has problem
		pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=1; w_data_sel=0; alu_in_sel=1; alu_sel=3'b0; pc_en=1; reg_w_en=1; dmem_w_en=0;
		end
		
		else if(opcode==6'hD)//orri
		begin
		pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=1; w_data_sel=0; alu_in_sel=1; alu_sel=3'b010; pc_en=1; reg_w_en=1; dmem_w_en=0;
		end
		
		else if(opcode==6'hC)//andi
		begin
		pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=1; w_data_sel=0; alu_in_sel=1; alu_sel=3'b100; pc_en=1; reg_w_en=1; dmem_w_en=0;
		end
		
		else if(opcode==6'hA)//slti
		begin//slti
		pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=1; w_data_sel=0; alu_in_sel=1; alu_sel=3'b110; pc_en=1; reg_w_en=1; dmem_w_en=0;
		end
		
		else if(opcode==6'h23)//lw
		begin//lw
		pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=1; w_data_sel=1; alu_in_sel=1; alu_sel=3'b0; pc_en=1; reg_w_en=1; dmem_w_en=0;
		end
		
		else if(opcode==6'h2B)
		begin//sw
		pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=1; alu_sel=3'b0; pc_en=1; reg_w_en=0; dmem_w_en=1;
		end
		
		else if(opcode==6'h4)
		begin//beq
			if(is_zero==1'b1)
			begin
				pc_sel=2'b10; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b1; pc_en=1; reg_w_en=0; dmem_w_en=0;
			end
			else
			begin
				pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b1; pc_en=1; reg_w_en=0; dmem_w_en=0;
			end
		end
		
		else if(opcode==6'h5)
		begin//bneq
			if(is_zero==1'b0)
			begin
				pc_sel=2'b10; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b1; pc_en=1; reg_w_en=0; dmem_w_en=0;
			end
			else
			begin
				pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b1; pc_en=1; reg_w_en=0; dmem_w_en=0;
			end
		end
		
		else if(opcode==6'h2)//J type
		begin
		pc_sel=2'b11; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b0; pc_en=1; reg_w_en=0; dmem_w_en=0;
		end 
		
		
		else
		begin
		pc_sel=2'b0; r1_addr_sel=0; w_addr_sel=0; w_data_sel=0; alu_in_sel=0; alu_sel=3'b0; pc_en=0; reg_w_en=0; dmem_w_en=0;
		end
	end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:19:24 12/20/2016 
// Design Name: 
// Module Name:    MIPS_dataPath 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MIPS_dataPath(user_disp, func, opcode, is_zero, user_addr, pc_sel, r1_addr_sel, w_addr_sel, w_data_sel, alu_in_sel, alu_sel,pc_en, reg_w_en, dmem_w_en,clk,rst);
    output [31:0] user_disp;
	 output [5:0] func, opcode;
	 output is_zero;
    input [4:0] user_addr;
	 input [1:0] pc_sel;
	 input r1_addr_sel,w_addr_sel,w_data_sel,alu_in_sel, pc_en, reg_w_en, dmem_w_en, clk, rst;
	 input [2:0] alu_sel;
	 wire [31:0] subtract_out;
	 wire [4:0] r1,r2,r3;
	 wire [15:0] imm;
	 wire [25:0] C;
	 wire [31:0] instruct;
	 wire [31:0] count,pc_in ;
	 wire [31:0] data0,data1,alu_out,data0_out, w_data;
	 wire [4:0] r_addr1, w_addr;
	 wire [31:0] datamem_out;
	 
	 
	 assign user_disp=data1;
	 //Breaking down the instruction
	 IM instructionMemory (instruct, count, rst, clk);
	 assign opcode=instruct[31:26];
	 assign r1=instruct[25:21];
	 assign r2=instruct[20:16];
	 assign r3=instruct[15:11];//instruct[10:6]:shamt is not used
	 assign func=instruct[5:0];
	 assign imm=instruct[15:0];
	 assign C=instruct[25:0];
	 
	 
	 
	 //mux for PC
	 mux_4x1 #(32) pc_mux (pc_in, {count[31:28],C, 2'b0} ,{16'b0, imm} , data1, count, pc_sel[1], pc_sel[0]);
	 
	//Counter word addressible 
	 PC programCounter (count, pc_in, pc_en, rst,clk);
	 
	 //
	 mux_2x1 #(5) r1_reg_mux (r_addr1, user_addr, r1, r1_addr_sel); 
	 mux_2x1 #(5) w_reg_mux (w_addr, r2, r3, w_addr_sel); 
	 mux_2x1 #(32) wd_reg_mux (w_data , datamem_out, alu_out, w_data_sel); 
	 RegFile registerFile (data1, data0, r_addr1, r2, w_addr, w_data , reg_w_en, rst, clk);
	 
	 //ALU 
	 mux_2x1 #(32) alu_in_mux (data0_out, {16'b0,imm}, data0,alu_in_sel);
	 ALU alu(alu_out, data1, data0_out, alu_sel);
	  
	 DM dataMemory (datamem_out, alu_out, data0, dmem_w_en, rst, clk);

	 subtractor subtract(subtract_out, data1,data0);	  	 //is_zero comparator
	 Comparator comparetoZero(is_zero,subtract_out);
	 
endmodule

module subtractor(out,in1,in0);
input [31:0] in1, in0;
output reg [31:0] out;
	always@(in1,in0)
	begin
		out=in1-in0;
	end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:00:02 12/18/2016 
// Design Name: 
// Module Name:    IM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IM(instruct, count, rst, clk);
    output reg [31:0] instruct;
    input [31:0] count;
	 input rst,clk;
	 //256 instructions of 32 bit each
	 reg [31:0] instructFile [255:0];
	 initial instruct =32'b0;
	 
	 initial begin
	 $readmemb("D:/Xilinx/LabProjectsandPractice/Lab10try1/instructMem.txt",instructFile);
	 end

	 always@ (posedge clk)
	 begin
		if(rst)
			instruct<=32'b0;
		else
			instruct<=instructFile[count];
	end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:32:50 12/17/2016 
// Design Name: 
// Module Name:    mux_4x1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux_4x1(y, x3, x2, x1, x0, s1, s0);
	 parameter bits=4;
    output [bits-1:0] y;
    input [bits-1:0] x3;
    input [bits-1:0] x2;
    input [bits-1:0] x1;
    input [bits-1:0] x0;
    input s1;
    input s0;
	 assign y =(s1==1&s0==1?x3:s1==1&s0==0?x2:s1==0&s0==1?x1:x0);
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:43:59 12/18/2016 
// Design Name: 
// Module Name:    PC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module PC(out, in, pc_en, rst,clk);
    output [31:0] out;
    input [31:0] in;
	 input rst,clk,pc_en;
	 reg [31:0] pc_count;
	 initial pc_count=0; 
	 
	 assign out=pc_count;
	 always@(posedge clk)
	 begin
		if(rst)
		begin
		pc_count=0;
		end
		else if(pc_en)
		begin
		pc_count=in+1;
		end
	 end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:35:22 12/17/2016 
// Design Name: 
// Module Name:    mux_2x1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux_2x1(y,x1, x0,s);
	parameter bits=4;
    output [bits-1:0] y;
    input [bits-1:0] x1;
    input [bits-1:0] x0;
    input s;
	 assign y =(s==1?x1:x0);
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:26:22 12/17/2016 
// Design Name: 
// Module Name:    RegFile 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module RegFile(data1, data0, r_addr1, r_addr0, w_addr, w_data, w_en, rst, clk);
//5 bit address for 32, 32 bit locations.
    output reg [31:0] data1;
    output reg [31:0] data0;
    input [4:0] r_addr1;
    input [4:0] r_addr0;
    input [4:0] w_addr;
    input [31:0] w_data;
    input w_en,rst,clk;
	 reg [31:0] regFile [31:0];
	 
	 initial begin
	 $readmemb("D:/Xilinx/LabProjectsandPractice/Lab10try1/RegFileMem.txt",regFile,0,31);
	 end
	 
	 always@(posedge clk)
	 begin
		if(rst)
		begin
			data1<=regFile[0];
			data0<=regFile[0];
		end
	   else if(w_en)
		begin
			regFile[w_addr]<=w_data;
		end
		else
		begin
			data1<=regFile[r_addr1];
			data0<=regFile[r_addr0];
		end
	end
	
endmodule 
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:12:52 12/18/2016 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU(out, in1, in0, sel);
// 32 bit input and 32 bit inputs with 3 bit selection of 7 functions
	 output reg [31:0] out;
    input [31:0]in1;
    input [31:0] in0;
    input [2:0] sel;
	 always@(sel,in1,in0)
	 begin 
		case(sel)
		0: out<=in1+in0;//add, addi
		1: out<=in1-in0;
		2: out<=in1|in0;//or, ori
		3: out<=in1^in0;//xor
		4: out<=in1&in0;//and, andi
		5: out<=( (in1<in0)?1:0 );// sltu
		6: begin //slt, slti
				if(in1[31])
				begin
					if(in0[31])
					begin
						out<=(in1>in0)?1:0;
					end
					else 
					out<=1;
				end
				else
				begin
					if(in0[31])
					begin 
						out<=0;
					end
					else
					begin
						out<=(in1<in0)?1:0;
					end
				 end
			end
		default: out<=32'b0;
		endcase
	end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:18:35 12/20/2016 
// Design Name: 
// Module Name:    DM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DM(data_out, addr, data, w_en, rst, clk);
    output reg [31:0] data_out;
    input [31:0] addr;
    input [31:0] data;
    input w_en;
    input rst;
    input clk;
	 //256 data values of of 32 bit each
	 reg [31:0] dataFile [255:0];
	 initial data_out<=32'b0;
	 
	 initial begin
	 $readmemb("D:/Xilinx/LabProjectsandPractice/Lab10try1/dataMem.txt",dataFile);
	 end
	 always@(posedge clk)
	 begin
		if(rst)
			data_out<=0;
		else if(w_en)
			dataFile[addr]<=data;
		else
			data_out<=dataFile[addr];
	 end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:32:14 12/21/2016 
// Design Name: 
// Module Name:    Comparator 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Comparator(is_zero, value);
    output reg is_zero;
    input [31:0] value;
	 
	 always@(value)
	 begin
	 if (value==32'b0)
		is_zero=1'b1;
		else 
		is_zero=1'b0;
	end

endmodule
