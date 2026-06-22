module seven_seg_decoder_tb;
    logic [3:0] count;
    logic [6:0] seg, expected_seg;
    int errors;

    seven_seg_decoder dut(
        .count(count),
        .seg(seg)
    );

    task automatic check_digit(input logic [3:0] digit, input logic [6:0] expected);
        begin
            count = digit;
            expected_seg = expected;
            #1;

            if (seg !== expected_seg) begin
                $display("ERROR digit=%0d: expected=%b got=%b", digit, expected_seg, seg);
                errors++;
            end else begin
                $display("PASS digit=%0d: seg=%b", digit, seg);
            end
        end
    endtask

    initial begin
        $dumpfile("seven_seg_decoder_tb.vcd");
        $dumpvars(0, seven_seg_decoder_tb);

        errors = 0;

        check_digit(4'd0, 7'b1111110);
        check_digit(4'd1, 7'b0110000);
        check_digit(4'd2, 7'b1101101);
        check_digit(4'd3, 7'b1111001);
        check_digit(4'd4, 7'b0110011);
        check_digit(4'd5, 7'b1011011);
        check_digit(4'd6, 7'b1011111);
        check_digit(4'd7, 7'b1110000);
        check_digit(4'd8, 7'b1111111);
        check_digit(4'd9, 7'b1111011);

        // Invalid BCD input should blank the display
        check_digit(4'd10, 7'b0000000);

        if (errors == 0) begin
            $display("TEST PASSED: seven_seg_decoder behaved as expected");
        end else begin
            $display("TEST FAILED: %0d error(s)", errors);
        end

        #10;
        $finish;
    end
endmodule