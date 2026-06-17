module parking_gate_fsm (
    input  wire clk,
    input  wire reset,
    input  wire car_detected,
    input  wire ticket_valid,
    input  wire car_passed,
    output reg  gate_open,
    output reg  gate_closed
);
    localparam IDLE = 3'b000;
    localparam CHECK_TICKET = 3'b001;
    localparam OPEN_GATE = 3'b010;
    localparam WAIT_FOR_CAR = 3'b011;
    localparam CLOSE_GATE = 3'b100;

    reg[2:0] state;
    reg[2:0] next_state;

    // - reset puts FSM in IDLE
    // - otherwise state <= next_state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end 
        else begin
            state <= next_state;
        end 
    end

    // - default outputs
    // - default next_state
    // - case(state)
    // - define transitions and outputs
    always @(*) begin
        next_state = state;
        gate_open = 1'b0;
        gate_closed = 1'b1;

        case (state)
            IDLE: begin
                if (car_detected) begin
                    next_state = CHECK_TICKET;
                end
            end

            CHECK_TICKET: begin
                if (ticket_valid) begin
                    next_state = OPEN_GATE;
                end
                else begin
                    next_state = IDLE;
                end
            end

            OPEN_GATE: begin
                next_state = WAIT_FOR_CAR;
                gate_open = 1'b1;
                gate_closed = 1'b0;
            end

            WAIT_FOR_CAR: begin
                gate_open = 1'b1;
                gate_closed = 1'b0;

                if (car_passed) begin
                    next_state = CLOSE_GATE;
                end
            end

            CLOSE_GATE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
                gate_open = 1'b0;
                gate_closed = 1'b1;
            end
        endcase
    end

endmodule