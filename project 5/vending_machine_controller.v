module vending_machine_fsm (
    input wire clk,
    input wire reset,
    input wire nickel,
    input wire dime,
    input wire quarter,
    output reg dispense,
    output reg return_change
);

    // states
    localparam S0 = 3'b000;
    localparam S5 = 3'b001;
    localparam S10 = 3'b010;
    localparam S15 = 3'b011;
    localparam S20 = 3'b100;
    localparam DISPENSE = 3'b101;
    localparam DISPENSE_CHANGE = 3'b110;

    reg [2:0] state;
    reg [2:0] next_state;

    // state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end

    // next_state logic
    always @(*) begin
        next_state = state; // in case no coin is inserted

        case (state)
            S0: begin
                if (nickel) begin
                    next_state = S5;
                end 
                else if (dime) begin
                    next_state = S10;
                end
                else if (quarter) begin
                    next_state = DISPENSE;
                end
            end

            S5: begin
                if (nickel) begin
                    next_state = S10;
                end
                else if (dime) begin
                    next_state = S15;
                end
                else if (quarter) begin
                    next_state = DISPENSE_CHANGE;
                end
            end

            S10 : begin
                if (nickel) begin
                    next_state = S15;
                end
                else if (dime) begin
                    next_state = S20;
                end
                else if (quarter) begin
                    next_state = DISPENSE_CHANGE;
                end
            end

            S15: begin
                if (nickel) begin
                    next_state = S20;
                end
                else if (dime) begin
                    next_state = DISPENSE;
                end
                else if (quarter) begin
                    next_state = DISPENSE_CHANGE;
                end
            end

            S20: begin
                if (nickel) begin
                    next_state = DISPENSE;
                end
                else if (dime) begin
                    next_state = DISPENSE_CHANGE;
                end
                else if (quarter) begin
                    next_state = DISPENSE_CHANGE;
                end
            end

            DISPENSE: begin
                next_state = S0;
            end

            DISPENSE_CHANGE: begin
                next_state = S0;
            end

            default: begin
                next_state = S0;
            end
        endcase
    end

    // output logic
    always @(*) begin
        case (state)
            DISPENSE: begin
                dispense = 1'b1;
                return_change = 1'b0;
            end

            DISPENSE_CHANGE: begin
                dispense = 1'b1;
                return_change = 1'b1;
            end

            default: begin
                dispense = 1'b0;
                return_change = 1'b0;
            end
        endcase
    end
endmodule
