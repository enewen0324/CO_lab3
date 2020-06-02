//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	funct_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	PCsrc_o,
	MemWrite_o,
	MemRead_o,
	MemToReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
input  [6-1:0] funct_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;//ALUOp
output         ALUSrc_o;//ALUSrc2
output [2-1:0] RegDst_o;//RegDst
output         Branch_o;//Branch
output [2-1:0] PCsrc_o;
output         MemWrite_o;
output         MemRead_o;
output [2-1:0] MemToReg_o;




//Internal Signals //-----------------reg
wire         RegWrite_o;
wire [3-1:0] ALU_op_o;//ALUOp
wire         ALUSrc_o;//ALUSrc2
wire [2-1:0] RegDst_o;//RegDst
wire         Branch_o;//Branch
wire [2-1:0] PCsrc_o;
wire         MemWrite_o;
wire         MemRead_o;
wire [2-1:0] MemToReg_o;

//Parameter
parameter addi = 6'h08;
parameter slti = 6'h0a;
parameter beq  = 6'h04;
parameter lw   = 6'h23;
parameter sw   = 6'h2b;
parameter jal  = 6'h03;
parameter j    = 6'h02;
parameter typeR= 6'h00;

parameter add  = 6'h20;
parameter sub  = 6'h22;
parameter _and = 6'h24;
parameter _or  = 6'h25;
parameter slt  = 6'h2a;
parameter jr   = 6'h08;



//Main function
assign PCsrc_o[1:0]= (instr_op_i == j || instr_op_i == jal )?2'b01: (instr_op_i == typeR && funct_i == jr)?2'b10:2'b0;
assign Branch_o = (instr_op_i == beq)?1'b1:1'b0;
assign RegWrite_o = (instr_op_i == sw || instr_op_i == beq || instr_op_i == j ||(instr_op_i == typeR && funct_i == jr))?1'b0:1'b1;
assign RegDst_o = (instr_op_i == lw  ||  instr_op_i ==  addi || instr_op_i == slti )?2'b0: (instr_op_i == jal)?2'b10:2'b01;
assign MemRead_o = (instr_op_i == lw)?1'b1:1'b0;
assign MemWrite_o = (instr_op_i == sw)?1'b1:1'b0;
assign MemToReg_o = (instr_op_i == lw)?2'b01:(instr_op_i == jal)?2'b10:2'b0;
assign ALUSrc_o=(instr_op_i == lw)?1'b1:
				   (instr_op_i == sw)?1'b1:
				   (instr_op_i == addi)?1'b1:
				   (instr_op_i == slti)?1'b1:1'b0;
assign ALU_op_o[2:0] = 
		(instr_op_i == typeR)? 3'b010:
		(instr_op_i == beq)? 3'b001: 
		(instr_op_i == slti )? 3'b101: 3'b000;


endmodule





                    
                    