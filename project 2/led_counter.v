module led_counter #(
    parameter LED_WIDTH   = 8,
    parameter COUNT_WIDTH = 24
) (
    input  wire                 clk,
    input  wire                 reset,
    input  wire                 enable,
    output reg  [LED_WIDTH-1:0] leds
);

    // Internal counter used to slow down LED updates
    reg [COUNT_WIDTH-1:0] counter;

    // Combinational signal: high when counter is all 1s
    wire tick;

    // TODO 1:
    // assign tick = ...
    assign tick = (counter == {COUNT_WIDTH{1'b1}});

    // TODO 2:
    // always block triggered on posedge clk or posedge reset
    // if reset:
    //     counter <= 0
    //     leds    <= 0
    // else if enable:
    //     counter <= counter + 1
    //     if tick:
    //         leds <= leds + 1

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            leds <= 0;
        end else if (enable) begin
            c
            if (tick) begin
                leds <= leds + 1'b1;
            end
        end
    end

endmodule