//Q4 A1

module mux_4_1 (input I0, I1, I2, I3, input S0, S1, output Y);
    wire notS0, notS1;
    wire and0, and1, and2, and3;

    // Generate inverted select lines
    not (notS0, S0);
    not (notS1, S1);

    // AND gates for each input
    and (and0, I0, notS1, notS0); // Select I0 when S1S0 = 00
    and (and1, I1, notS1, S0);    // Select I1 when S1S0 = 01
    and (and2, I2, S1, notS0);    // Select I2 when S1S0 = 10
    and (and3, I3, S1, S0);       // Select I3 when S1S0 = 11

    // OR gate to combine the outputs of the AND gates
    or (Y, and0, and1, and2, and3);
endmodule
 

module test_mux_4_1;
    reg I0, I1, I2, I3;
    reg S0, S1;
    wire Y;

    // Instantiate the 4-to-1 multiplexer
    mux_4_1 mux (.I0(I0), .I1(I1), .I2(I2), .I3(I3), .S0(S0), .S1(S1), .Y(Y));

    initial begin
        $dumpfile("mux_4_1.vcd");  // VCD file for GTKWave
        $dumpvars(0, test_mux_4_1); // Dump all variables for simulation

        // Monitor statement to print the output to the console
        $monitor("Time = %0d : S1 = %b, S0 = %b, I0 = %b, I1 = %b, I2 = %b, I3 = %b, Y = %b", 
                  $time, S1, S0, I0, I1, I2, I3, Y);

        // Test cases
        I0 = 1; I1 = 0; I2 = 0; I3 = 1;
        S0 = 0; S1 = 0; #10; // Should select I0 (Y = 1)
        S0 = 1; S1 = 0; #10; // Should select I1 (Y = 0)
        S0 = 0; S1 = 1; #10; // Should select I2 (Y = 0)
        S0 = 1; S1 = 1; #10; // Should select I3 (Y = 1)

        $finish;
    end
endmodule
