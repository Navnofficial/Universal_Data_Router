`timescale 1ns/1ps

module tb_udru;

reg  [7:0] req;
reg  [7:0] data_in;
reg  [2:0] dest_sel;

wire [2:0] encoded_req;
wire mux_out;
wire [7:0] demux_out;
wire [7:0] decoded_out;

universal_data_router uut (
    .req(req),
    .data_in(data_in),
    .dest_sel(dest_sel),
    .encoded_req(encoded_req),
    .mux_out(mux_out),
    .demux_out(demux_out),
    .decoded_out(decoded_out)
);

initial begin
    $display("Starting Universal Data Router Testbench");
    $dumpfile("tb_urdu.vcd");
    $dumpvars(0, tb_udru);
    $display("Time\treq\tdata\tdest\tenc\tmux\tdemux\tdecoded");

    req = 0; data_in = 8'b10101010; dest_sel = 0;
    #10;

    req = 8'b00010000; dest_sel = 3;
    #10;

    req = 8'b01000000; dest_sel = 5;
    #10;

    req = 8'b00000001; dest_sel = 7;
    #10;

    req = 8'b10000000; dest_sel = 2;
    #10;

    $finish;
end

initial begin
    $monitor("%0t\t%b\t%b\t%d\t%d\t%b\t%b\t%b",
        $time, req, data_in, dest_sel,
        encoded_req, mux_out, demux_out, decoded_out);
end

endmodule