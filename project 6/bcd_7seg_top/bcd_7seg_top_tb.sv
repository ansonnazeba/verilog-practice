module bcd_7seg_top_tb;
    logic clk, reset, enable;
    logic [6:0] seg, expected_seg;
    logic [3:0] expected_count;
    int errors;

    bcd_7seg_top dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .seg(seg)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    function automatic logic [6:0] expected_pattern(input logic [3:0] digit);
        begin
            case (digit)
                4'd0: expected_pattern = 7'b1111110;
                4'd1: expected_pattern = 7'b0110000;
                4'd2: expected_pattern = 7'b1101101;
                4'd3: expected_pattern = 7'b1111001;
                4'd4: expected_pattern = 7'b0110011;
                4'd5: expected_pattern = 7'b1011011;
                4'd6: expected_pattern = 7'b1011111;
                4'd7: expected_pattern = 7'b1110000;
                4'd8: expected_pattern = 7'b1111111;
                4'd9: expected_pattern = 7'b1111011;
                default: expected_pattern = 7'b0000000;
            endcase
        end
    endfunction

    task automatic check_output(input string test_name);
        begin
            expected_seg = expected_pattern(expected_count);

            if (seg !== expected_seg) begin
                $display("ERROR %s at time %0t: expected_count=%0d expected_seg=%b got_seg=%b",
                         test_name, $time, expected_count, expected_seg, seg);
                errors++;
            end else begin
                $display("PASS %s at time %0t: expected_count=%0d seg=%b",
                         test_name, $time, expected_count, seg);
            end
        end
    endtask

    initial begin
        $dumpfile("bcd_7seg_top_tb.vcd");
        $dumpvars(0, bcd_7seg_top_tb);

        errors = 0;
        expected_count = 4'd0;
        reset = 1'b1;
        enable = 1'b0;

        #1;
        check_output("after reset");

        @(negedge clk);
        reset = 1'b0;

        @(posedge clk);
        #1;
        check_output("hold after reset release with enable low");

        @(negedge clk);
        enable = 1'b1;

        for (int i = 0; i < 12; i++) begin
            @(posedge clk);
            #1;

            if (expected_count == 4'd9) begin
                expected_count = 4'd0;
            end else begin
                expected_count = expected_count + 4'd1;
            end

            check_output($sformatf("count cycle %0d", i));
        end

        @(negedge clk);
        enable = 1'b0;

        for (int i = 0; i < 3; i++) begin
            @(posedge clk);
            #1;
            check_output($sformatf("hold cycle %0d", i));
        end

        if (errors == 0) begin
            $display("TEST PASSED: bcd_7seg_top behaved as expected");
        end else begin
            $display("TEST FAILED: %0d error(s)", errors);
        end

        #10;
        $finish;
    end
endmodule