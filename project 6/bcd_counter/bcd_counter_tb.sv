module bcd_counter_tb;
    logic clk, reset, enable;
    logic [3:0] count, expected_count;
    int errors;

    bcd_counter dut(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("bcd_counter_tb.vcd");
        $dumpvars(0, bcd_counter_tb);

        reset = 1'b1;
        enable = 1'b0;

        expected_count = 4'd0;
        errors = 0;

        #1;
        if (count !== expected_count) begin
            $display("ERROR after reset at time %0t: expected=%0d got=%0d", $time, expected_count, count);
            errors++;
        end else begin
            $display("PASS after reset at time %0t: count=%0d", $time, count);
        end

        @(negedge clk);
        reset = 1'b0;

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

            if (count !== expected_count) begin
                $display("ERROR count cycle %0d at time %0t: expected=%0d got=%0d", i, $time, expected_count, count);
                errors++;
            end else begin
                $display("PASS count cycle %0d at time %0t: count=%0d", i, $time, count);
            end
        end

        @(negedge clk);
        enable = 1'b0;

        for (int i = 0; i < 3; i++) begin
            @(posedge clk);
            #1;

            if (count !== expected_count) begin
                $display("ERROR hold cycle %0d at time %0t: expected=%0d got=%0d", i, $time, expected_count, count);
                errors++;
            end else begin
                $display("PASS hold cycle %0d at time %0t: count held at %0d", i, $time, count);
            end
        end

        if (errors == 0) begin
            $display("TEST PASSED: bcd_counter behaved as expected");
        end else begin
            $display("TEST FAILED: %0d error(s)", errors);
        end

        $finish;
    end

endmodule