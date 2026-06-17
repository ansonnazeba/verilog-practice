`timescale 1ns / 1ps

module led_updown_counter_tb;

    reg clk;
    reg reset;
    reg enable;
    reg direction;
    wire [3:0] leds;

    led_updown_counter #(
        .LED_WIDTH(4),
        .COUNT_WIDTH(3)
    ) dut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .direction(direction),
        .leds(leds)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("led_updown_counter_tb.vcd");
        $dumpvars(0, led_updown_counter_tb);

        reset = 1'b1;
        enable = 1'b0;
        direction = 1'b0;

        #20;
        reset = 1'b0;

        #10;
        enable = 1'b1;
        direction = 1'b0;   // count up

        #100;
        direction = 1'b1;   // count down

        #100;
        enable = 1'b0;      // hold

        #30;
        $finish;
    end

endmodule