//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;   
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg        [4-1:0] aluFunct;

//Parameter

parameter EXE_ADD = 4'b0010;
parameter EXE_SUB = 4'b0110;
parameter EXE_AND = 4'b0000;
parameter EXE_OR  = 4'b0001;
parameter EXE_NOR = 4'b1010;
parameter EXE_SLT = 4'b0111;

parameter add  = 6'h20;
parameter sub  = 6'h22;
parameter _and = 6'h24;
parameter _or  = 6'h25;
parameter slt  = 6'h2a;
parameter jr   = 6'h08;
       
//Select exact operation
always @(*)
		case (funct_i)
			6'b10_0000: aluFunct <= EXE_ADD;
			6'b10_0010: aluFunct <= EXE_SUB;
			6'b10_0100: aluFunct <= EXE_AND;
			6'b10_0101: aluFunct <= EXE_OR;
			6'b10_1010: aluFunct <= EXE_SUB;
			default: aluFunct <= EXE_ADD;
		endcase


always @(*)
		case (ALUOp_i[2:0])
			3'b000: ALUCtrl_o <= EXE_ADD;
			3'b001: ALUCtrl_o <= EXE_SUB;
			3'b101: ALUCtrl_o <= EXE_SLT;
			3'b010: ALUCtrl_o <= aluFunct;
			default: ALUCtrl_o <= EXE_ADD;
		endcase

endmodule     
                    
                    