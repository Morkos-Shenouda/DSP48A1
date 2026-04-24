module dsp_tb ();

parameter A0REG=0;
parameter A1REG=1;
parameter B0REG=0;
parameter B1REG=1;
parameter CREG=1;
parameter DREG=1;
parameter MREG=1;
parameter PREG=1;
parameter CARRYINREG=1;
parameter CARRYOUTREG=1;
parameter OPMODEREG=1;
parameter CARRYINSEL="OPMODE5";
parameter B_INPUT= "DIRECT";
parameter RSTTYPE= "SYNC";

reg [17:0] A;
reg [17:0] B;
reg [47:0] C;
reg [17:0] D;
reg CARRYIN;
wire [35:0] M;
wire [47:0] P;
wire CARRYOUT;
wire CARRYOUTF;

reg [17:0] BCIN;

reg clk;
reg [7:0] OPMODE;

reg CEA;
reg CEB;
reg CEC;
reg CECARRYIN;
reg CED;
reg CEM;
reg CEOPMODE;
reg CEP;

reg RSTA;
reg RSTB;
reg RSTC;
reg RSTCARRYIN;
reg RSTD;
reg RSTM;
reg RSTOPMODE;
reg RSTP;

wire [17:0] BCOUT;
reg [47:0] PCIN;
wire [47:0] PCOUT;
    

reg [47:0] p_out_last;
reg carryout_last;
dsp #(
    .A0REG(A0REG),
    .A1REG(A1REG),
    .B0REG(B0REG),
    .B1REG(B1REG),
    .CREG(CREG),
    .DREG(DREG),
    .MREG(MREG),
    .PREG(PREG),
    .CARRYINREG(CARRYINREG),
    .CARRYOUTREG(CARRYOUTREG),
    .OPMODEREG(OPMODEREG),
    .CARRYINSEL(CARRYINSEL),
    .B_INPUT(B_INPUT),
    .RSTTYPE(RSTTYPE)
) dut(
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .CARRYIN(CARRYIN),
    .M(M),
    .P(P),
    .CARRYOUT(CARRYOUT),
    .CARRYOUTF(CARRYOUTF),
    .BCIN(BCIN),
    .clk(clk),
    .OPMODE(OPMODE),
    .CEA(CEA),
    .CEB(CEB),
    .CEC(CEC),
    .CECARRYIN(CECARRYIN),
    .CED(CED),
    .CEM(CEM),
    .CEOPMODE(CEOPMODE),
    .CEP(CEP),
    .RSTA(RSTA),
    .RSTB(RSTB),
    .RSTC(RSTC),
    .RSTCARRYIN(RSTCARRYIN),
    .RSTD(RSTD),
    .RSTM(RSTM),
    .RSTOPMODE(RSTOPMODE),
    .RSTP(RSTP),
    .BCOUT(BCOUT),
    .PCIN(PCIN),
    .PCOUT(PCOUT)
);

initial begin
    clk=0;
    forever #10 clk=~clk;
end

initial begin
    // -----------------------------------------------------------------------------
    // test 2.1 : reset operation
    // -----------------------------------------------------------------------------
    RSTA=1;
    RSTB=1;
    RSTC=1;
    RSTCARRYIN=1;
    RSTD=1;
    RSTM=1;
    RSTOPMODE=1;
    RSTP=1;
    RSTP=1;
    repeat(500) begin
        A=$random;
        B=$random;
        C=$random;
        D=$random;
        CARRYIN=$random;
        BCIN=$random;
        OPMODE=$random;
        CEA=$random;
        CEB=$random;
        CEC=$random;
        CECARRYIN=$random;
        CED=$random;
        CEM=$random;
        CEOPMODE=$random;
        CEP=$random;
        PCIN=$random;
        @(negedge clk);

        if(M!==0 || P!==0 || CARRYOUT!==0 || CARRYOUTF!==0 ||BCOUT!==0 || PCOUT!==0) begin
            $display("Test 2.1 fails. rst has a problem.");
            $stop;
        end
    end

    RSTA=0;
    RSTB=0;
    RSTC=0;
    RSTCARRYIN=0;
    RSTD=0;
    RSTM=0;
    RSTOPMODE=0;
    RSTP=0;
    RSTP=0;

    // -----------------------------------------------------------------------------
    // test 2.2: path 1
    // -----------------------------------------------------------------------------
    CEA=1;
    CEB=1;
    CEC=1;
    CECARRYIN=1;
    CED=1;
    CEM=1;
    CEOPMODE=1;
    CEP=1;

    OPMODE=8'b11011101;
    A=20;
    B=10;
    C=350;
    D=25;
    repeat(500) begin
        BCIN=$random;
        PCIN=$random;
        CARRYIN=$random;
        repeat(4) @(negedge clk);

        if(BCOUT!=='hf || M!=='h12c || P!=='h32 || PCOUT!==P || CARRYOUT!==0 || CARRYOUTF!==CARRYOUT) begin
            $display("test 2.2 fail. Path 1 has a problem");
            $stop;
        end

    end

    // -----------------------------------------------------------------------------
    // test 2.3: path 2
    // -----------------------------------------------------------------------------
    OPMODE=8'b00010000;
    A=20;
    B=10;
    C=350;
    D=25;
    repeat(500) begin
        BCIN=$random;
        PCIN=$random;
        CARRYIN=$random;
        repeat(3) @(negedge clk);
        if(BCOUT!=='h23 || M!=='h2bc || P!==0 || PCOUT!==P || CARRYOUT!==0 || CARRYOUTF!==CARRYOUT) begin
            $display("test 2.3 fail. Path 2 has a problem");
            $stop;
        end
        p_out_last=P;
        carryout_last=CARRYOUT;
    end

    // -----------------------------------------------------------------------------
    // test 2.4: path 3
    // -----------------------------------------------------------------------------
    OPMODE=8'b00001010;
    A=20;
    B=10;
    C=350;
    D=25;
    repeat(500) begin
        BCIN=$random;
        PCIN=$random;
        CARRYIN=$random;
        repeat(3) @(negedge clk);
        if(BCOUT!=='ha || M!=='hc8 || P!==p_out_last || PCOUT!==P || CARRYOUT!==carryout_last || CARRYOUTF!==CARRYOUT) begin
            $display("test 2.4 fail. Path 3 has a problem");
            $stop;
        end
        p_out_last=P;
        carryout_last=CARRYOUT;
    end 

    // -----------------------------------------------------------------------------
    // test 2.5: path 4
    // -----------------------------------------------------------------------------
    OPMODE=8'b10100111;
    A=5;
    B=6;
    C=350;
    D=25;
    PCIN=3000;
    repeat(500) begin
        BCIN=$random;
        CARRYIN=$random;
        repeat(3) @(negedge clk);
        if(BCOUT!=='h6 || M!=='h1e || P!=='hfe6fffec0bb1 || PCOUT!==P || CARRYOUT!==1 || CARRYOUTF!==CARRYOUT) begin
            $display("test 2.5 fail. Path 4 has a problem");
            $stop;
        end
    end 



    $display("TESTS PASSED");
    $stop;
end
endmodule