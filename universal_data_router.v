`timescale 1ns/1ps

module universal_data_router(
    input  [7:0] req,
    input  [7:0] data_in,
    input  [2:0] dest_sel,
    output [2:0] encoded_req,
    output mux_out,
    output [7:0] demux_out,
    output [7:0] decoded_out
);

wire mux_wire;

Priority_encoder enc (
    .req(req),
    .out(encoded_req)
);

mux8to1 mux (
    .in(data_in),
    .sel(encoded_req),
    .out(mux_wire)
);

demux1to8 demux (
    .in(mux_wire),
    .sel(dest_sel),
    .out(demux_out)
);

decoder3to8 dec (
    .in(dest_sel),
    .out(decoded_out)
);

assign mux_out = mux_wire;

endmodule

module Priority_encoder(
    input  [7:0] req,
    output reg [2:0] out
);
always @(*) begin
    casex (req)
        8'b1xxxxxxx: out = 3'd7;
        8'b01xxxxxx: out = 3'd6;
        8'b001xxxxx: out = 3'd5;
        8'b0001xxxx: out = 3'd4;
        8'b00001xxx: out = 3'd3;
        8'b000001xx: out = 3'd2;
        8'b0000001x: out = 3'd1;
        8'b00000001: out = 3'd0;
        default:     out = 3'd0;
    endcase
end
endmodule

module mux8to1(
    input  [7:0] in,
    input  [2:0] sel,
    output reg out
);
always @(*) begin
    case (sel)
        3'd0: out = in[0];
        3'd1: out = in[1];
        3'd2: out = in[2];
        3'd3: out = in[3];
        3'd4: out = in[4];
        3'd5: out = in[5];
        3'd6: out = in[6];
        3'd7: out = in[7];
    endcase
end
endmodule

module demux1to8(
    input  in,
    input  [2:0] sel,
    output reg [7:0] out
);
always @(*) begin
    out = 8'b00000000;
    case (sel)
        3'd0: out[0] = in;
        3'd1: out[1] = in;
        3'd2: out[2] = in;
        3'd3: out[3] = in;
        3'd4: out[4] = in;
        3'd5: out[5] = in;
        3'd6: out[6] = in;
        3'd7: out[7] = in;
    endcase
end
endmodule

module decoder3to8(
    input  [2:0] in,
    output reg [7:0] out
);
always @(*) begin
    out = 8'b00000000;
    case (in)
        3'd0: out[0] = 1'b1;
        3'd1: out[1] = 1'b1;
        3'd2: out[2] = 1'b1;
        3'd3: out[3] = 1'b1;
        3'd4: out[4] = 1'b1;
        3'd5: out[5] = 1'b1;
        3'd6: out[6] = 1'b1;
        3'd7: out[7] = 1'b1;
    endcase
end
endmodule