// `default_nettype none
module dsp #(
    parameter A0REG=0,
    parameter A1REG=1,
    parameter B0REG=0,
    parameter B1REG=1,
    parameter CREG=1,
    parameter DREG=1,
    parameter MREG=1,
    parameter PREG=1,
    parameter CARRYINREG=1,
    parameter CARRYOUTREG=1,
    parameter OPMODEREG=1,

    parameter CARRYINSEL="OPMODE5",
    parameter B_INPUT= "DIRECT",
    parameter RSTTYPE= "SYNC"
) (
    input [17:0] A,
    input [17:0] B,
    input [47:0] C,
    input [17:0] D,
    input CARRYIN,
    output [35:0] M,
    output [47:0] P,
    output CARRYOUT,
    output CARRYOUTF,

    input [17:0] BCIN,

    input clk,
    input [7:0] OPMODE,

    input CEA,
    input CEB,
    input CEC,
    input CECARRYIN,
    input CED,
    input CEM,
    input CEOPMODE,
    input CEP,

    input RSTA,
    input RSTB,
    input RSTC,
    input RSTCARRYIN,
    input RSTD,
    input RSTM,
    input RSTOPMODE,
    input RSTP,

    output [17:0] BCOUT,
    input [47:0] PCIN,
    output [47:0] PCOUT
);

wire [17:0] A0_reg;
wire [17:0] A1_reg;
wire [17:0] B0_reg;
wire [17:0] B1_Reg;
wire [47:0] C_reg;
wire [17:0] D_reg;
wire [35:0] M_reg;
wire [47:0] P_reg;
wire CARRYIN_reg;
wire CARRYOUT_reg;
wire [7:0] opmode_reg;

wire [17:0] Bin;
wire [17:0] pre_adder_subtracter;
wire [47:0] post_adder_subtracter;
wire CARRYOUT_post_adder_subtracter;
wire CARRYIN_mux;
wire [47:0] x_out;
wire [47:0] z_out;
wire [35:0] multiplier_out;

assign CARRYIN_mux= (CARRYINSEL=="CARRYIN")? CARRYIN_reg : (CARRYINSEL=="OPMODE5")? opmode_reg[5]: 0;
assign Bin= (B_INPUT=="DIRECT")? B : (B_INPUT=="CASCADE")? BCIN : 0;
mux_pair #(
    .isReg(A0REG),
    .RSTTYPE(RSTTYPE),
    .width(18)
) A0_mux_reg(
    .clk(clk),
    .rst(RSTA),
    .ce(CEA),
    .in(A),
    .out(A0_reg)
);

mux_pair #(
    .isReg(A1REG),
    .RSTTYPE(RSTTYPE),
    .width(18)
) A1_mux_reg(
    .clk(clk),
    .rst(RSTA),
    .ce(CEA),
    .in(A0_reg),
    .out(A1_reg)
);

mux_pair #(
    .isReg(B0REG),
    .RSTTYPE(RSTTYPE),
    .width(18)
) B0_mux_reg(
    .clk(clk),
    .rst(RSTB),
    .ce(CEB),
    .in(Bin),
    .out(B0_reg)
);

mux_pair #(
    .isReg(B1REG),
    .RSTTYPE(RSTTYPE),
    .width(18)
) B1_mux_reg(
    .clk(clk),
    .rst(RSTB),
    .ce(CEB),
    .in(pre_adder_subtracter),
    .out(B1_Reg)
);

mux_pair #(
    .isReg(CREG),
    .RSTTYPE(RSTTYPE),
    .width(48)
) C_mux_reg(
    .clk(clk),
    .rst(RSTC),
    .ce(CEC),
    .in(C),
    .out(C_reg)
);

mux_pair #(
    .isReg(DREG),
    .RSTTYPE(RSTTYPE),
    .width(18)
) D_mux_reg(
    .clk(clk),
    .rst(RSTD),
    .ce(CED),
    .in(D),
    .out(D_reg)
);


mux_pair #(
    .isReg(MREG),
    .RSTTYPE(RSTTYPE),
    .width(36)
) M_mux_reg(
    .clk(clk),
    .rst(RSTM),
    .ce(CEM),
    .in(multiplier_out),
    .out(M_reg)
);

mux_pair #(
    .isReg(PREG),
    .RSTTYPE(RSTTYPE),
    .width(48)
) P_mux_reg(
    .clk(clk),
    .rst(RSTP),
    .ce(CEP),
    .in(post_adder_subtracter),
    .out(P_reg)
);

mux_pair #(
    .isReg(CARRYINREG),
    .RSTTYPE(RSTTYPE),
    .width(1)
) CARRYIN_mux_reg(
    .clk(clk),
    .rst(RSTCARRYIN),
    .ce(CECARRYIN),
    .in(CARRYIN),
    .out(CARRYIN_reg)
);

mux_pair #(
    .isReg(CARRYOUTREG),
    .RSTTYPE(RSTTYPE),
    .width(1)
) CARRYOUT_mux_reg(
    .clk(clk),
    .rst(RSTCARRYIN),
    .ce(CECARRYIN),
    .in(CARRYOUT_post_adder_subtracter),
    .out(CARRYOUT_reg)
);


mux_pair #(
    .isReg(OPMODEREG),
    .RSTTYPE(RSTTYPE),
    .width(8)
) OPMODE_mux_reg(
    .clk(clk),
    .rst(RSTOPMODE),
    .ce(CEOPMODE),
    .in(OPMODE),
    .out(opmode_reg)
);


assign pre_adder_subtracter=    (opmode_reg[4]==0)? B0_reg : 
                                (opmode_reg[6]==0)? D_reg+B0_reg :
                                                    D_reg-B0_reg;

assign multiplier_out= A1_reg * B1_Reg;
assign M=multiplier_out;

assign x_out=   (opmode_reg[1:0]==0)? 0:
                (opmode_reg[1:0]==1)? M_reg:
                (opmode_reg[1:0]==2)? P_reg:
                                    {D[11:0],A[17:0],B[17:0]};
assign z_out=   (opmode_reg[3:2]==0)? 0:
                (opmode_reg[3:2]==1)? PCIN:
                (opmode_reg[3:2]==2)? P_reg:
                                    C_reg;

assign {CARRYOUT_post_adder_subtracter, post_adder_subtracter} =
    (opmode_reg[7]==0)? x_out+z_out:
                        z_out-(x_out+CARRYIN_mux);

assign CARRYOUT=CARRYOUT_reg;
assign CARRYOUTF=CARRYOUT;

assign BCOUT=B1_Reg;
assign P=P_reg;
assign PCOUT=P;
                                    

endmodule