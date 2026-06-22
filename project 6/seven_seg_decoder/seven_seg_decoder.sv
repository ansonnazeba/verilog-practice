module seven_seg_decoder(
    input logic [3:0] count,
    output logic [6:0] seg
);

    always_comb begin
        case (count)
            4'd0: seg = 7'b1111110; // a,b,c,d,e,f on; g off
            4'd1: seg = 7'b0110000; // b,c on
            4'd2: seg = 7'b1101101; // a,b,d,e,g on
            4'd3: seg = 7'b1111001; // a,b,c,d,g on
            4'd4: seg = 7'b0110011; // b,c,f,g on
            4'd5: seg = 7'b1011011; // a,c,d,f,g on
            4'd6: seg = 7'b1011111; // a,c,d,e,f,g on
            4'd7: seg = 7'b1110000; // a,b,c on
            4'd8: seg = 7'b1111111; // all on
            4'd9: seg = 7'b1111011; // a,b,c,d,f,g on
            default: seg = 7'b0000000;
        endcase
    end
endmodule