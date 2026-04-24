module mux_pair_tb #();

parameter width= 18;
reg clk;
reg rst;
reg [width-1:0] in;
wire [width-1:0] out;

mux_pair #(.width(width)) dut (.clk(clk), .rst(rst), .in(in), .out(out));
initial begin
    clk=0;
    forever #10 clk=~clk;
end

initial begin
    rst=1;
    in=1;
    @(negedge clk);
    rst=0;
    in=2;
    @(negedge clk);
    in=3;
    @(negedge clk);

    $stop;
end
    
endmodule