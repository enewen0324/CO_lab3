//Subject:     CO project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended
always @(*) begin
    case(data_i[15])
        1'b0: data_o <=  {16'b0000000000000000,data_i};
        1'b1: data_o <= {16'b1111111111111111,data_i};
        default: data_o <=  {16'b0000000000000000,data_i};
    endcase
end

endmodule     
     