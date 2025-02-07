module priority_encoder_8_to_3 (
    input [7:0] A,            // 8-bit input lines
    output reg [2:0] Y,       // 3-bit output
    output reg valid          // Valid output signal
);

    always @(*) begin
        // Initialize output and valid signal
        Y = 3'b000;   // Default output (invalid case)
        valid = 0;    // Default valid to 0
        
        // Priority encoding logic
        if (A[7]) begin
            Y = 3'b111;  // If input 7 is active
            valid = 1;   // Valid output
        end
        else if (A[6]) begin
            Y = 3'b110;  // If input 6 is active
            valid = 1;   // Valid output
        end
        else if (A[5]) begin
            Y = 3'b101;  // If input 5 is active
            valid = 1;   // Valid output
        end
        else if (A[4]) begin
            Y = 3'b100;  // If input 4 is active
            valid = 1;   // Valid output
        end
        else if (A[3]) begin
            Y = 3'b011;  // If input 3 is active
            valid = 1;   // Valid output
        end
        else if (A[2]) begin
            Y = 3'b010;  // If input 2 is active
            valid = 1;   // Valid output
        end
        else if (A[1]) begin
            Y = 3'b001;  // If input 1 is active
            valid = 1;   // Valid output
        end
        else if (A[0]) begin
            Y = 3'b000;  // If input 0 is active
            valid = 1;   // Valid output
        end
    end

endmodule


module test_priority_encoder_8_to_3;
    reg [7:0] A;
    wire [2:0] Y;
    wire valid;

    // Instantiate the priority_encoder_8_to_3 module
    priority_encoder_8_to_3 my_encoder (.A(A), .Y(Y), .valid(valid));

    initial begin
        $dumpfile("priority_encoder_8_to_3.vcd"); // VCD file for GTKWave
        $dumpvars(0, test_priority_encoder_8_to_3); // Dump all variables for simulation

        // Monitor statement to print the output to the console
        $monitor("Time = %0d : A = %b | Y = %b, valid = %b", 
                  $time, A, Y, valid);

        // Test cases
        A = 8'b00000000; #10; // No active input
        A = 8'b00000001; #10; // Input 0 active
        A = 8'b00000010; #10; // Input 1 active
        A = 8'b00000100; #10; // Input 2 active
        A = 8'b00001000; #10; // Input 3 active
        A = 8'b00010000; #10; // Input 4 active
        A = 8'b00100000; #10; // Input 5 active
        A = 8'b01000000; #10; // Input 6 active
        A = 8'b10000000; #10; // Input 7 active
        A = 8'b11111111; #10; // All inputs active (highest priority is 7)

        $finish;
    end
endmodule

