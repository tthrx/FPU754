`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:25:07 07/31/2015 
// Design Name: 
// Module Name:    fmul_pipline0 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fmul_pipline0(
    input clk,
    input rst,

    input       do_fmul,
    input[31:0] a,
    input[31:0] b,

    //s1, exp9, significand32
    output[41:0] x0,
    output[41:0] y0,
    output valid
);

////////////////////////////////////////////////////////////
reg       rX0_s;
reg[8:0]  rX0_exponent;
reg[31:0] rX0_significand;

reg       rY0_s;
reg[8:0]  rY0_exponent;
reg[31:0] rY0_significand;

reg _valid;

////////////////////////////////////////////////////////////
always@(posedge clk)
begin
    if (rst) begin
        rX0_s           <= 0;
        rX0_exponent    <= 0;
        rX0_significand <= 0;
    end
    else if (do_fmul) begin
        if (a[30:0] != 31'h0) begin
            rX0_s           <= a[31];
            rX0_exponent    <= {1'b0, a[30:23]};
            rX0_significand <= {8'h0, 1'b1, a[22:0]};
        end
        else begin
            rX0_s           <= 0;
            rX0_exponent    <= 0;
            rX0_significand <= 0;
        end
    end
    else begin
        rX0_s           <= rX0_s;
        rX0_exponent    <= rX0_exponent;
        rX0_significand <= rX0_significand;
    end
end

always@(posedge clk)
begin
    if (rst) begin
        rY0_s           <= 0;
        rY0_exponent    <= 0;
        rY0_significand <= 0;
    end
    else if (do_fmul) begin
        if (b[30:0] != 31'h0) begin
            rY0_s           <= b[31];
            rY0_exponent    <= {1'b0, b[30:23]};
            rY0_significand <= {8'h0, 1'b1, b[22:0]};
        end
        else begin
            rY0_s           <= 0;
            rY0_exponent    <= 0;
            rY0_significand <= 0;
        end
    end
    else begin
        rY0_s           <= rY0_s;
        rY0_exponent    <= rY0_exponent;
        rY0_significand <= rY0_significand;
    end
end

////////////////////////////////////////////////////////////
always@(posedge clk)
begin
    if (rst)
        _valid <= 1'b0;
    else if (do_fmul)
        _valid <= 1'b1;
    else
        _valid <= 1'b0;
end

assign x0[41:0] = {rX0_s, rX0_exponent[8:0], rX0_significand[31:0]};
assign y0[41:0] = {rY0_s, rY0_exponent[8:0], rY0_significand[31:0]};
assign valid = _valid;


endmodule
