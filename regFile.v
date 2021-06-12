module regFile #(
    parameter W = 31, N = 31 //Width = 32, Number of regs = 32
)(
    input           nrst,   //asynchronous reset, low effective
    input           clk,

    input   [4:0]   radd1, 
    input   [4:0]   radd2,

    input           wen,    //write enable
    input   [4:0]   wadd,
    input   [W:0]   wdata,

    output  [W:0]   rs1,    //output register values
    output  [W:0]   rs2
);

reg [W:0] reg_file [0:N]; // the register file
integer i;

always @(posedge clk or negedge nrst) begin 
    if (~nrst) begin
        for (i=0; i<32; i=i+1) begin
            reg_file[i] <= 32'b0;
        end
    end
    else if (wen) begin // not write to reg0
        if(wadd != 5'b0) begin
            reg_file[wadd] <= wdata;
        end
    end
end

assign rs1 = reg_file[radd1];
assign rs2 = reg_file[radd2];

endmodule