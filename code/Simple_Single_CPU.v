//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles

//----------------------ProgramCounter PC
// clk_i
// rst_i
wire[31:0] pc_in_i ;
wire[31:0] pc_out_o;

//----------------------Adder Adder1
wire[31:0] Adder1_src1_i; 
wire[31:0] Adder1_src2_i;     
wire[31:0] Adder1_sum_o;

//----------------------Shift_Left_Two_32 Jump_Shifter(
wire[31:0] Jump_Shifter_data_i;
wire[31:0] Jump_Shifter_data_o;

//----------------------Instr_Memory IM
wire[31:0] pc_addr_i;
wire[31:0] instr_o;

//----------------------MUX_3to1 #(.size(5)) Mux_Write_Reg
wire[4:0] Mux_Write_Reg_src1_i;
wire[4:0] Mux_Write_Reg_src2_i;
wire[4:0] Mux_Write_Reg_src3_i;
wire[1:0] Mux_Write_Reg_select;
wire[4:0] Mux_Write_Reg_o;

//----------------------Reg_File RF
wire[4:0] RSaddr_i; 
wire[4:0] RTaddr_i;  
wire[4:0] RDaddr_i; 
wire[31:0] RDdata_i;
wire RegWrite_i;
wire[31:0] RSdata_o;
wire[31:0] RTdata_o;

//----------------------Decoder Decoder
wire [6-1:0] instr_op_i;
wire [6-1:0] funct_i;
wire         RegWrite_o;
wire [3-1:0] ALU_op_o;//ALUOp
wire         ALUSrc_o;//ALUSrc2
wire [2-1:0] RegDst_o;//RegDst
wire         Branch_o;//Branch
wire [2-1:0] PCsrc_o;
wire         MemWrite_o;
wire         MemRead_o;
wire [2-1:0] MemToReg_o;

//----------------------ALU_Ctrl AC
wire[5:0] AC_funct_i;   
wire[2:0] AC_ALUOp_i;
wire[3:0] AC_ALUCtrl_o;

//----------------------Sign_Extend SE(
wire[15:0] SE_data_i;
wire[31:0] SE_data_o;

//----------------------MUX_2to1 #(.size(32)) Mux_ALUSrc(
wire[31:0] Mux_ALUSrc_src1_i;
wire[31:0] Mux_ALUSrc_src2_i;
wire Mux_ALUSrc_select;
wire[31:0] Mux_ALUSrc_o;

//----------------------ALU ALU(
wire[31:0] ALU_src1_i;
wire[31:0] ALU_src2_i;
wire[3:0] ALU_ctrl_i;
wire[31:0] ALU_result_o;
wire ALU_zero_o;

//----------------------Adder Adder2
wire[31:0] Adder2_src1_i;
wire[31:0] Adder2_src2_i;     
wire[31:0] Adder2_sum_o;

//----------------------Shift_Left_Two_32 Addr_Shifter(
wire[31:0] Addr_Shifter_data_i;
wire[31:0] Addr_Shifter_data_o;

//----------------------MUX_2to1 #(.size(32)) Mux_beq(
wire[31:0] Mux_beq_data0_i;
wire[31:0] Mux_beq_data1_i;
wire Mux_beq_select_i;
wire[31:0] Mux_beq_data_o;

//----------------------MUX_3to1 #(.size(32)) Mux_PC_Source(
wire[31:0] Mux_PC_Source_data0_i;
wire[31:0] Mux_PC_Source_data1_i;
wire[31:0] Mux_PC_Source_data2_i;
wire[1:0]  Mux_PC_Source_select_i;
wire[31:0] Mux_PC_Source_data_o;

//----------------------MUX_3to1 #(.size(32)) Mux_write_data(
wire[31:0] Mux_write_data_data0_i;
wire[31:0] Mux_write_data_data1_i;
wire[31:0] Mux_write_data_data2_i;
wire[1:0]  Mux_write_data_select_i;
wire[31:0] Mux_write_data_data_o;

//----------------------Data_Memory DM(
//clk_i,
wire[31:0] DM_addr_i;
wire[31:0] DM_data_i;
wire DM_MemRead_i;
wire DM_MemWrite_i;
wire[31:0] DM_data_o;


assign pc_in_i = Mux_PC_Source_data_o;//mux_pc
assign Adder1_src1_i = pc_out_o;
assign Adder1_src2_i = 4;
assign Jump_Shifter_data_i = instr_o[25:0];
assign pc_addr_i = pc_out_o;
assign Mux_Write_Reg_src1_i = instr_o[20:16];
assign Mux_Write_Reg_src2_i = instr_o[15:11];
assign Mux_Write_Reg_src3_i = 31;
assign Mux_Write_Reg_select = RegDst_o;
assign RSaddr_i = instr_o[25:21];
assign RTaddr_i = instr_o[20:16];
assign RDaddr_i = Mux_Write_Reg_o;
assign RDdata_i = Mux_write_data_data_o;//MUX_DM
assign RegWrite_i = RegWrite_o;
assign instr_op_i = instr_o[31:26];
assign funct_i = instr_o[5:0];
assign AC_funct_i = instr_o[5:0];
assign AC_ALUOp_i = ALU_op_o;
assign SE_data_i = instr_o[15:0];
assign Mux_ALUSrc_src1_i = RTdata_o;
assign Mux_ALUSrc_src2_i = SE_data_o;
assign Mux_ALUSrc_select = ALUSrc_o;
assign ALU_src1_i = RSdata_o;
assign ALU_src2_i = Mux_ALUSrc_o;
assign ALU_ctrl_i = AC_ALUCtrl_o;
assign Adder2_src1_i = Adder1_sum_o;
assign Adder2_src2_i = Addr_Shifter_data_o; 
assign Addr_Shifter_data_i = SE_data_o;
assign Mux_beq_data0_i = Adder1_sum_o;
assign Mux_beq_data1_i = Adder2_sum_o;
assign Mux_beq_select_i = Branch_o & ALU_zero_o;
assign Mux_PC_Source_data0_i = Mux_beq_data_o;
assign Mux_PC_Source_data1_i = {Adder1_sum_o[31:28],Jump_Shifter_data_o[27:0]};
assign Mux_PC_Source_data2_i = RSdata_o;
assign Mux_PC_Source_select_i = PCsrc_o;
assign DM_addr_i = ALU_result_o;
assign DM_data_i = RTdata_o;
assign DM_MemRead_i = MemRead_o;
assign DM_MemWrite_i = MemWrite_o;
assign Mux_write_data_data0_i = ALU_result_o;
assign Mux_write_data_data1_i = DM_data_o;
assign Mux_write_data_data2_i = Adder1_sum_o;
assign Mux_write_data_select_i = MemToReg_o;


//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
        .rst_i(rst_i),     
        .pc_in_i(pc_in_i),   
        .pc_out_o(pc_out_o) 
        );
	
Adder Adder1(
        .src1_i(Adder1_src1_i),     
        .src2_i(Adder1_src2_i),     
        .sum_o(Adder1_sum_o)    
        );

Shift_Left_Two_32 Jump_Shifter(
        .data_i(Jump_Shifter_data_i),
        .data_o(Jump_Shifter_data_o)
        ); 
	
Instr_Memory IM(
        .pc_addr_i(pc_addr_i),  
        .instr_o(instr_o)    
        );

MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(Mux_Write_Reg_src1_i),
        .data1_i(Mux_Write_Reg_src2_i),
        .data2_i(Mux_Write_Reg_src3_i),
        .select_i(Mux_Write_Reg_select),
        .data_o(Mux_Write_Reg_o)
        );	
		
Reg_File Registers(
        .clk_i(clk_i),      
        .rst_i(rst_i),     
        .RSaddr_i(RSaddr_i),  
        .RTaddr_i(RTaddr_i),  
        .RDaddr_i(RDaddr_i),  
        .RDdata_i(RDdata_i), 
        .RegWrite_i(RegWrite_i),
        .RSdata_o(RSdata_o),  
        .RTdata_o(RTdata_o)   
        );
	
Decoder Decoder( 
        .instr_op_i(instr_op_i),
	.funct_i(funct_i),
	.RegWrite_o(RegWrite_o),
	.ALU_op_o(ALU_op_o),
	.ALUSrc_o(ALUSrc_o),
	.RegDst_o(RegDst_o),
	.Branch_o(Branch_o),
	.PCsrc_o(PCsrc_o),
	.MemWrite_o(MemWrite_o),
	.MemRead_o(MemRead_o),
	.MemToReg_o(MemToReg_o) 
        );

ALU_Ctrl AC(
        .funct_i(AC_funct_i),   
        .ALUOp_i(AC_ALUOp_i),   
        .ALUCtrl_o(AC_ALUCtrl_o) 
        );
	
Sign_Extend SE(
        .data_i(SE_data_i),
        .data_o(SE_data_o)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(Mux_ALUSrc_src1_i),
        .data1_i(Mux_ALUSrc_src2_i),
        .select_i(Mux_ALUSrc_select),
        .data_o(Mux_ALUSrc_o)
        );	
		
ALU ALU(
        .src1_i(ALU_src1_i),
        .src2_i(ALU_src2_i),
        .ctrl_i(ALU_ctrl_i),
        .result_o(ALU_result_o),
        .zero_o(ALU_zero_o)
        );

Adder Adder2(
        .src1_i(Adder2_src1_i),     
        .src2_i(Adder2_src2_i),     
        .sum_o(Adder2_sum_o)      
        );
		
Shift_Left_Two_32 Addr_Shifter(
        .data_i(Addr_Shifter_data_i),
        .data_o(Addr_Shifter_data_o)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_beq(
        .data0_i(Mux_beq_data0_i),
        .data1_i(Mux_beq_data1_i),
        .select_i(Mux_beq_select_i),
        .data_o(Mux_beq_data_o)
        );

MUX_3to1 #(.size(32)) Mux_PC_Source(
        .data0_i(Mux_PC_Source_data0_i),
        .data1_i(Mux_PC_Source_data1_i),
        .data2_i(Mux_PC_Source_data2_i),
        .select_i(Mux_PC_Source_select_i),
        .data_o(Mux_PC_Source_data_o)
        );

MUX_3to1 #(.size(32)) Mux_write_data(
        .data0_i(Mux_write_data_data0_i),
        .data1_i(Mux_write_data_data1_i),
        .data2_i(Mux_write_data_data2_i),
        .select_i(Mux_write_data_select_i),
        .data_o(Mux_write_data_data_o)
        );

Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(DM_addr_i),
	.data_i(DM_data_i),
	.MemRead_i(DM_MemRead_i),
	.MemWrite_i(DM_MemWrite_i),
	.data_o(DM_data_o)
	);	
endmodule
		  


