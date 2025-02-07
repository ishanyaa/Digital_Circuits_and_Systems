module sr_latch (
    input S,            // Set input
    input R,            // Reset input
    input enable,       // Asynchronous enable input
    output reg Q,       // Output Q
    output reg Qn       // Output Q (inverted)
);

    // Always block triggered by changes in S, R, or enable
    always @(*) begin
        if (enable) begin
            if (R) begin
                Q = 0;   // Reset the latch
                Qn = 1;  // Inverted output
            end
            else if (S) begin
                Q = 1;   // Set the latch
                Qn = 0;  // Inverted output
            end
            // If neither S nor R are active, hold the current state
        end
    end

endmodule

module test_sr_latch;
    reg S;
    reg R;
    reg enable;
    wire Q;
    wire Qn;

    // Instantiate the sr_latch module
    sr_latch my_latch (.S(S), .R(R), .enable(enable), .Q(Q), .Qn(Qn));

    initial begin
        $dumpfile("sr_latch.vcd"); // VCD file for GTKWave
        $dumpvars(0, test_sr_latch); // Dump all variables for simulation

        // Monitor statement to print the output to the console
        $monitor("Time = %0d : S = %b, R = %b, enable = %b | Q = %b, Qn = %b", 
                  $time, S, R, enable, Q, Qn);

        // Test cases
        enable = 1; S = 0; R = 0; #10; // Hold state
        enable = 1; S = 1; R = 0; #10; // Set latch
        enable = 1; S = 0; R = 0; #10; // Hold state
        enable = 1; S = 0; R = 1; #10; // Reset latch
        enable = 1; S = 0; R = 0; #10; // Hold state
        enable = 0; S = 1; R = 0; #10; // Should not change state
        enable = 1; S = 1; R = 0; #10; // Set latch again
        enable = 1; S = 0; R = 1; #10; // Reset latch
        enable = 0; S = 0; R = 0; #10; // Should not change state
        
        $finish;
    end
endmodule
