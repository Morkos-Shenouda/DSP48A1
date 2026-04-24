module mux_pair #(
    parameter isReg=0,
    parameter RSTTYPE="SYNC", // I assumed that reset doesn't work when isReg=0
    parameter width=18
) (
    input clk,
    input rst,
    input ce,
    input [width-1:0] in,
    output [width-1:0] out
);

wire [width-1:0] out_wire;
reg [width-1:0] out_reg;

assign out= (isReg==0)? out_wire : out_reg;

assign out_wire=in;
generate
    if(RSTTYPE=="SYNC") begin
        always @(posedge clk) begin
            if(rst) out_reg<=0;
            else if(ce) out_reg<=in;
        end
    end

    else if(RSTTYPE=="ASYNC") begin
        always @(posedge clk or posedge rst) begin
            if(rst) out_reg<=0;
            else if(ce) out_reg<=in;
        end
    end
endgenerate    

endmodule