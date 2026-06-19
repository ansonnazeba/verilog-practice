module bcd_counter (
    input logic clk,
    input logic reset,
    input logic enable,

    output logic [3:0] count
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'd0;
        end else if (enable) begin
            if (count == 4'd9) begin
                count <= 4'd0;
            end else begin
                count <= count + 4'd1;
            end
        end
    end
endmodule 