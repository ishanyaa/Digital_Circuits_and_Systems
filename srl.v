/* Problem 1: Implement a verilog module of an SR latch with asynchronous
 enable and reset. */

module srl(input s, r, en, reset, output reg q, qn);

always @(*) begin
    if (reset) begin
        q = 0;       // Asynchronous reset
        qn = 1;
    end else if (en) begin
        if (s && ~r) begin
            q = 1;   // Set state
            qn = 0;
        end else if (~s && r) begin
            q = 0;   // Reset state
            qn = 1;
        end else if (~s && ~r) begin
            // Hold state
            q = q;
            qn = qn;
        end else begin
            q = 1'bx; // Invalid state
            qn = 1'bx;
        end
    end
end

endmodule

`timescale 1ns / 1ps


module tb_srl;
    reg s, r, en, reset;   // Testbench inputs
    wire q, qn;            // Testbench outputs

    // Instantiate the SR latch module
    srl uut(
        .s(s),
        .r(r),
        .en(en),     // Connect 'en' to the module
        .reset(reset),
        .q(q),
        .qn(qn)
    );

    initial begin
        $dumpfile("srl.vcd");
        $dumpvars(0, tb_srl);

        $monitor("Time = %t | reset = %b | en = %b | s = %b | r = %b | q = %b | qn = %b", 
                  $time, reset, en, s, r, q, qn);

        // Initialize inputs
        reset = 0; en = 0; s = 0; r = 0;

        // Apply asynchronous reset
        #5 reset = 1;
        #5 reset = 0;

        // Enable latch and apply inputs
        #5 en = 1; s = 1; r = 0;  // Set state
        #5 s = 0; r = 1;          // Reset state
        #5 s = 0; r = 0;          // Hold state
        #5 s = 1; r = 1;          // Invalid state

        // Disable latch
        #5 en = 0; s = 1; r = 0;

        // Test asynchronous reset again
        #5 reset = 1;
        #5 reset = 0;

        $finish;
    end

endmodule

