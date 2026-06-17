module led_blinker (
    input  wire clk,
    input  wire reset,
    output reg  led
);

    reg [23:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 24'd0;
            led     <= 1'b0;
        end else begin
            counter <= counter + 1'b1; // incrementing 24-bit counter

            if (counter == 24'd0)
                led <= ~led;
        end
    end

endmodule