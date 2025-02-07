module mux_4to1 (
    output Y,        // Output of the multiplexer
    input [1:0] S,   // 2-bit select input
    input I0, I1, I2, I3  // 4 data inputs
);

    wire S0_bar, S1_bar;  // Complementary select lines
    wire Y0, Y1, Y2, Y3;  // Intermediate outputs for each input line

    // Generate NOT S0 and NOT S1
    not (S0_bar, S[0]);
    not (S1_bar, S[1]);

    // AND gates for each input
    and (Y0, S1_bar, S0_bar, I0);  // Select I0 if S1=0, S0=0
    and (Y1, S1_bar, S[0], I1);    // Select I1 if S1=0, S0=1
    and (Y2, S[1], S0_bar, I2);    // Select I2 if S1=1, S0=0
    and (Y3, S[1], S[0], I3);      // Select I3 if S1=1, S0=1

    // OR gate to combine all paths
    or (Y, Y0, Y1, Y2, Y3);

endmodule


module tb_mux_4to1;

    reg [1:0] S;    // 2-bit select input
    reg I0, I1, I2, I3; // Data inputs
    wire Y;         // Output of the multiplexer

    // Instantiate the 4-to-1 MUX
    mux_4to1 mux(.Y(Y), .S(S), .I0(I0), .I1(I1), .I2(I2), .I3(I3));

    initial begin

$dumpfile("mux_4to1.vcd");
$dumpvars(0, tb_mux_4to1);


        // Monitor values
        $monitor("Time = %0d | S1 = %b, S0 = %b | I0 = %b, I1 = %b, I2 = %b, I3 = %b | Y = %b", 
                 $time, S[1], S[0], I0, I1, I2, I3, Y);

        // Test case 1: I0 = 1, all other inputs are 0
        I0 = 1; I1 = 0; I2 = 0; I3 = 0; S = 2'b00; #10;
        // Test case 2: I1 = 1, all other inputs are 0
        I0 = 0; I1 = 1; I2 = 0; I3 = 0; S = 2'b01; #10;
        // Test case 3: I2 = 1, all other inputs are 0
        I0 = 0; I1 = 0; I2 = 1; I3 = 0; S = 2'b10; #10;
        // Test case 4: I3 = 1, all other inputs are 0
        I0 = 0; I1 = 0; I2 = 0; I3 = 1; S = 2'b11; #10;

        // Test case 5: All inputs are different
        I0 = 1; I1 = 0; I2 = 1; I3 = 0;
        S = 2'b00; #10;  // Should select I0
        S = 2'b01; #10;  // Should select I1
        S = 2'b10; #10;  // Should select I2
        S = 2'b11; #10;  // Should select I3

        $finish;
    end

endmodule


