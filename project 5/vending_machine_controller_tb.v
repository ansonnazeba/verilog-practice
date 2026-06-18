`timescale 1ns / 1ps

module vending_machine_controller_tb;
    reg clk;
    reg reset;
    reg nickel;
    reg dime;
    reg quarter;

    wire dispense;
    wire return_change;

    vending_machine_fsm dut (
        .clk(clk),
        .reset(reset),
        .nickel(nickel),
        .dime(dime),
        .quarter(quarter),
        .dispense(dispense),
        .return_change(return_change)
    );

    initial begin
        clk = 1'b0;
    end

    always #5 clk = ~clk;
    initial begin
        $dumpfile("vending_machine_controller_tb.vcd");
        $dumpvars(0, vending_machine_controller_tb);

        $display("time\treset\tnickel\tdime\tquarter\tstate\tnext_state\tdispense\treturn_change");
        $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t\t%b",
                 $time, reset, nickel, dime, quarter,
                 dut.state, dut.next_state, dispense, return_change);

        reset   = 1'b1;
        nickel  = 1'b0;
        dime    = 1'b0;
        quarter = 1'b0;

        #20;
        reset = 1'b0;

        $display("\n--- Test 1: quarter only -> expect dispense=1, return_change=0 ---");
         // Test 1: quarter only -> DISPENSE, no change
        #10;
        quarter = 1'b1;
        #10;
        quarter = 1'b0;

        #10;
        $display("CHECK Test 1 at time %0t: dispense=%b return_change=%b", $time, dispense, return_change);

        #20;

        $display("\n--- Test 2: nickel + quarter -> expect dispense=1, return_change=1 ---");
        // Test 2: nickel + quarter -> DISPENSE_CHANGE
        nickel = 1'b1;
        #10;
        nickel = 1'b0;

        #10;
        quarter = 1'b1;
        #10;
        quarter = 1'b0;

        #10;
        $display("CHECK Test 2 at time %0t: dispense=%b return_change=%b", $time, dispense, return_change);

        #20;

        $display("\n--- Test 3: dime + dime + nickel -> expect dispense=1, return_change=0 ---");
        // Test 3: dime + dime + nickel -> DISPENSE, no change
        dime = 1'b1;
        #10;
        dime = 1'b0;

        #10;
        dime = 1'b1;
        #10;
        dime = 1'b0;

        #10;
        nickel = 1'b1;
        #10;
        nickel = 1'b0;

        #10;
        $display("CHECK Test 3 at time %0t: dispense=%b return_change=%b", $time, dispense, return_change);

        #20;

        $display("\n--- Test 4: dime + quarter -> expect dispense=1, return_change=1 ---");
        // Test 4: dime + quarter -> DISPENSE_CHANGE
        dime = 1'b1;
        #10;
        dime = 1'b0;

        #10;
        quarter = 1'b1;
        #10;
        quarter = 1'b0;

        #10;
        $display("CHECK Test 4 at time %0t: dispense=%b return_change=%b", $time, dispense, return_change);

        #40;

        $finish;


    end


endmodule