`timescale 1ns / 1ps

module led_counter_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg enable;
    wire [3:0] leds;

    // Instantiate the DUT: Device Under Test
    led_counter #(
        .LED_WIDTH(4),
        .COUNT_WIDTH(3)
    ) dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .leds(leds)
    );

    // Clock generation
    initial begin
        $dumpfile("led_counter_tb.vcd");
        $dumpvars(0, led_counter_tb);
        
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        reset = 1;
        enable = 0;

        #20;
        reset = 0;

        #10;
        enable = 1;

        #200;

        enable = 0;

        #30;

        $finish;
    end

endmodule