// Testbench for the top module
module testbench;

    // Declare inputs as reg and outputs as wire
    reg a, b, c;
    wire and_out, or_out;

    // Instantiate the top module
    top_module uut (
        .a(a),
        .b(b),
        .c(c),
        .and_out(and_out),
        .or_out(or_out)
    );

    // Initial block for testing
    initial begin
        // Monitor changes
        $monitor("Time = %0t | a = %b, b = %b, c = %b | AND Out = %b | OR Out = %b", 
                 $time, a, b, c, and_out, or_out);
                 
        // Test cases
        a = 0; b = 0; c = 0; #10;
        a = 0; b = 0; c = 1; #10;
        a = 0; b = 1; c = 0; #10;
        a = 0; b = 1; c = 1; #10;
        a = 1; b = 0; c = 0; #10;
        a = 1; b = 0; c = 1; #10;
        a = 1; b = 1; c = 0; #10;
        a = 1; b = 1; c = 1; #10;
        $finish; // End the simulation
    end

endmodule
