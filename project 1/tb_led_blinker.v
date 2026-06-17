`timescale 1ns / 1ps

module tb_led_blinker;

    reg  clk;
    reg  reset;
    wire led;

    led_blinker dut (
        .clk   (clk),
        .reset (reset),
        .led   (led)
    );

    // 10 ns clock period (100 MHz for fast simulation)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("led_blinker.vcd");
        $dumpvars(0, tb_led_blinker);

        // Apply reset
        reset = 1;
        #20;
        reset = 0;

        // Run for enough cycles to see multiple toggles
        // (reduce counter width for simulation speed)
        #5000;
        $finish;
    end

endmodule