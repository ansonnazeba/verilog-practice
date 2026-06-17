module led_updown_counter #(
    parameter LED_WIDTH = 8,
    parameter COUNT_WIDTH = 24
) (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire direction,
    output reg [LED_WIDTH - 1: 0] leds
);

reg[COUNT_WIDTH - 1: 0] counter;
wire tick;

assign tick = (counter == {COUNT_WIDTH{1'b1}});

always @(posedge clk or posedge reset) begin
    // TODO: handle reset first
    if (reset) begin
        counter <= {COUNT_WIDTH{1'b0}};
        leds <= {LED_WIDTH{1'b0}};
    end

    // TODO: if enable is high, increment counter
    else if (enable) begin
        counter <= counter + 1'b1; 
        if (tick)  begin
            if (direction == 1'b0) begin
                leds <= leds + 1'b1;
            end 
            else begin
                leds <= leds - 1'b1;
            end
        end
    end
    else if (!enable) begin
        counter <= {COUNT_WIDTH{1'b0}};
    end
end

endmodule