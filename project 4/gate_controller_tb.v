`timescale 1ns / 1ps

module gate_controller_tb;

    reg clk;
    reg reset;
    reg car_detected;
    reg ticket_valid;
    reg car_passed;
    wire gate_open;
    wire gate_closed;

    parking_gate_fsm dut (
        .clk(clk),
        .reset(reset),
        .car_detected(car_detected),
        .ticket_valid(ticket_valid),
        .car_passed(car_passed),
        .gate_open(gate_open),
        .gate_closed(gate_closed)
    );

    initial begin
        clk = 1'b0;
    end

    always #5 clk = ~clk;

    initial begin
        $dumpfile("gate_controller_tb.vcd");
        $dumpvars(0, gate_controller_tb);

        reset        = 1'b1;
        car_detected = 1'b0;
        ticket_valid = 1'b0;
        car_passed   = 1'b0;

        #20;
        reset = 1'b0;

        // Car arrives and stays detected long enough for the FSM to sample it
        #10;
        car_detected = 1'b1;
        // Valid ticket is presented while FSM is in CHECK_TICKET
        ticket_valid = 1'b1;

        #20;
        car_detected = 1'b0;

        #20;
        ticket_valid = 1'b0;

        // Let FSM move through OPEN_GATE into WAIT_FOR_CAR
        #20;

        // Car passes only after gate has had time to open
        car_passed = 1'b1;

        #20;
        car_passed = 1'b0;

        // Let FSM close gate and return to IDLE
        #30;

        $finish;
    end

endmodule
