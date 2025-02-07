/* Problem 3: Implement an FSM in verilog that detects the input sequence 1101
 on input variable x. The Verilog code should detect the desired input sequence
 every time it occurs, even if embedded in a sequence of bits. When the Verilog
 code detects the desired input sequence and output, Z should be 1; otherwise, Z
 should be zero. On resetting the state machine, your verilog code should return
 to the initial state S0. */

module seq(input clk, reset, x, output reg z);

reg [2:0] s, ns;

parameter s0 = 3'b000;
parameter s1 = 3'b001;
parameter s2 = 3'b010;
parameter s3 = 3'b011;
parameter s4 = 3'b100;

always @(posedge clk or negedge reset) begin
    if (!reset) 
        s <= s0; // Reset state
    else 
        s <= ns; // Next state
end

always @(*) begin
    case (s)
        s0: if (x) ns = s1; else ns = s0;
        s1: if (x) ns = s2; else ns = s0;
        s2: if (x) ns = s3; else ns = s2;
        s3: if (x) ns = s4; else ns = s0;
        s4: ns = s0; // Return to s0 after detection
        default: ns = s0; // Default state
    endcase
end

always @(s) begin
    if (s == s4)
        z = 1; // Output Z = 1 if in state s4 (sequence detected)
    else
        z = 0; // Otherwise, Z = 0
end

endmodule

module tb_seq;
reg clk, reset, x;
wire z;

seq uut (.clk(clk), .reset(reset), .x(x), .z(z));

always begin
    #5 clk = ~clk; // Clock signal toggles every 5 time units
end

initial begin 
    clk = 0; reset = 0; x = 0;

    $dumpfile("seq.vcd");
    $dumpvars(0, tb_seq);

    $monitor("Time %t, x = %b, z = %b", $time, x, z);

    // Apply reset and wait for some time
    reset = 1;  // Apply reset
    #10;
    reset = 0;  // Release reset

    // Test sequence to detect 1101
    // Test 1: Sequence '1101' should trigger Z = 1
    x = 1; #10; // S0 -> S1
    x = 1; #10; // S1 -> S2
    x = 0; #10; // S2 -> S3
    x = 1; #10; // S3 -> S4 (Z = 1)
    #10;

    // Test 2: Sequence '11101' should trigger Z = 1 after overlap
    x = 1; #10; // S0 -> S1
    x = 1; #10; // S1 -> S2
    x = 1; #10; // S2 -> S2
    x = 0; #10; // S2 -> S3
    x = 1; #10; // S3 -> S4 (Z = 1)
    #10;

    // Test 3: Sequence '101' does not trigger Z = 1
    x = 1; #10; // S0 -> S1
    x = 0; #10; // S1 -> S0
    x = 1; #10; // S0 -> S1
    #10;

    // Test 4: Sequence '110' does not trigger Z = 1
    x = 1; #10; // S0 -> S1
    x = 1; #10; // S1 -> S2
    x = 0; #10; // S2 -> S3
    #10;

    // Finish the simulation
    $finish;
end

endmodule






