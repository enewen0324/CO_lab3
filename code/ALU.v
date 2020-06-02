//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter
parameter EXE_ADD = 4'b0010;
parameter EXE_SUB = 4'b0110;
parameter EXE_AND = 4'b0000;
parameter EXE_OR  = 4'b0001;
parameter EXE_NOR = 4'b1010;
parameter EXE_SLT = 4'b0111;


//Main function
assign zero_o = (result_o == 0);

always @(*) begin
    case (ctrl_i)
		EXE_ADD: result_o <= src1_i + src2_i;
    	EXE_SUB: result_o <= src1_i - src2_i;
    	EXE_AND: result_o <= src1_i & src2_i;
    	EXE_OR: result_o <= src1_i | src2_i;
    	EXE_NOR: result_o <= ~(src1_i | src2_i);
    	EXE_SLT: result_o <= src1_i < src2_i ? 1 : 0;
      	default: result_o <= 0;
	endcase
end

endmodule





                    
                    