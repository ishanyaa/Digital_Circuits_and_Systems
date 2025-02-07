// 3-input AND Gate using structural modeling
module and_gate (
    input a,
    input b,
    input c,
    output y
);
    wire ab_and; // Intermediate wire for AND operation

    // Instantiate two 2-input AND gates
    and u1 (ab_and, a, b); // AND gate for a and b
    and u2 (y, ab_and, c); // AND gate for ab_and and c
endmodule

// 3-input OR Gate using structural modeling
module or_gate (
    input a,
    input b,
    input c,
    output y
);
    wire ab_or; // Intermediate wire for OR operation

    // Instantiate two 2-input OR gates
    or u1 (ab_or, a, b); // OR gate for a and b
    or u2 (y, ab_or, c); // OR gate for ab_or and c
endmodule

// Testbench to verify the gates
module testbench;
    reg a, b, c;
    wire and_out, or_out;

    // Instantiate the AND gate
    and_gate u1 (
        .a(a),
        .b(b),
        .c(c),
        .y(and_out)
    );

    // Instantiate the OR gate
    or_gate u2 (
        .a(a),
        .b(b),
        .c(c),
        .y(or_out)
    );

    initial begin
$dumpfile("gates.vcd"); // Create VCD file
    $dumpvars(0, testbench); // Dump all variables in the testbench
        // Monitor outputs
        $monitor("Time: %0t | a: %b, b: %b, c: %b | AND Output: %b | OR Output: %b", $time, a, b, c, and_out, or_out);
        
        // Test cases
        a = 0; b = 0; c = 0; #10;
        a = 0; b = 0; c = 1; #10;
        a = 0; b = 1; c = 0; #10;
        a = 0; b = 1; c = 1; #10;
        a = 1; b = 0; c = 0; #10;
        a = 1; b = 0; c = 1; #10;
        a = 1; b = 1; c = 0; #10;
        a = 1; b = 1; c = 1; #10;

        // End simulation
        $finish;
    end
endmodule
