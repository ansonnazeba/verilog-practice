module bcd_7seg_top (
    input logic clk,
    input logic reset,
    input logic enable,
    output logic [6:0] seg
);
    logic [3:0] count;
    bcd_counter bcd_inst (
        .clk(clk), .reset(reset), .enable(enable), .count(count)
    );

    seven_seg_decoder seven_seg_decoder_inst (
        .count(count), .seg(seg)
    );
endmodule