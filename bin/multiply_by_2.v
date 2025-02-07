module multiply_by_2 (
    input [3:0] A,      // 4-bit input
    output reg [4:0] Y  // 5-bit output to accommodate the result (4 bits + 1 bit for carry)
);

    always @(*) begin
        Y = A << 1;      // Left shift A by 1 to multiply by 2
    end

endmodule



//Test Bench 

module tb_multiply_by_2;

    reg [3:0] A;         // 4-bit input
    wire [4:0] Y;        // 5-bit output

    // Instantiate the multiplier
    multiply_by_2 multiplier(.A(A), .Y(Y));

    initial begin
$dumpfile("multiply_by_2.vcd");
$dumpvars(0, tb_multiply_by_2);


        // Monitor values
        $monitor("Time = %0d | A = %b | Y = %b", $time, A, Y);

        // Test various values of A
        A = 4'b0000; #10; // A = 0
        A = 4'b0001; #10; // A = 1
        A = 4'b0010; #10; // A = 2
        A = 4'b0011; #10; // A = 3
        A = 4'b0100; #10; // A = 4
        A = 4'b1000; #10; // A = 8
        A = 4'b1111; #10; // A = 15

        $finish;
    end

endmodule
