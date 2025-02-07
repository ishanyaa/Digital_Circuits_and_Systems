module encoder_4_to_2 (
    input [3:0] A,            // 4-bit input
    output reg [1:0] Y,       // 2-bit output
    output reg valid          // Valid output signal
);

    always @(*) begin
        case (A)
            4'b0000: begin
                Y = 2'b00;   // No active input
                valid = 0;   // Invalid output
            end
            4'b0001: begin
                Y = 2'b00;   // Input 0 active
                valid = 1;   // Valid output
            end
            4'b0010: begin
                Y = 2'b01;   // Input 1 active
                valid = 1;   // Valid output
            end
            4'b0100: begin
                Y = 2'b10;   // Input 2 active
                valid = 1;   // Valid output
            end
            4'b1000: begin
                Y = 2'b11;   // Input 3 active
                valid = 1;   // Valid output
            end
            default: begin
                Y = 2'b00;   // Default case for invalid inputs
                valid = 0;   // Invalid output
            end
        endcase
    end

endmodule


module test_encoder_4_to_2;
    reg [3:0] A;
    wire [1:0] Y;
    wire valid;

    // Instantiate the encoder_4_to_2 module
    encoder_4_to_2 my_encoder (.A(A), .Y(Y), .valid(valid));

    initial begin
        $dumpfile("encoder_4_to_2.vcd"); // VCD file for GTKWave
        $dumpvars(0, test_encoder_4_to_2); // Dump all variables for simulation

        // Monitor statement to print the output to the console
        $monitor("Time = %0d : A = %b | Y = %b, valid = %b", 
                  $time, A, Y, valid);

        // Test cases
        A = 4'b0000; #10; // No active input
        A = 4'b0001; #10; // Input 0 active
        A = 4'b0010; #10; // Input 1 active
        A = 4'b0100; #10; // Input 2 active
        A = 4'b1000; #10; // Input 3 active
        A = 4'b0011; #10; // Invalid case (multiple inputs active)
        A = 4'b1100; #10; // Invalid case (multiple inputs active)

        $finish;
    end
endmodule

