module mux4(input d0, d1, d2, d3, input s0, s1, output y);
    wire ns0, ns1;
    wire and0, and1, and2, and3;

    // Invert s0 and s1
    not n0(ns0, s0);
    not n1(ns1, s1);

    // AND gates for each combination of inputs and select lines
    and g0(and0, d0, ns1, ns0);  // Select D0
    and g1(and1, d1, ns1, s0);   // Select D1
    and g2(and2, d2, s1, ns0);   // Select D2
    and g3(and3, d3, s1, s0);    // Select D3

    // OR gate to combine the outputs of the AND gates
    or out(y, and0, and1, and2, and3);
endmodule

module tb_mux4;
    reg d0, d1, d2, d3;
    reg s0, s1;
    wire y;

    // Instantiate the multiplexer
    mux4 uut (.d0(d0), .d1(d1), .d2(d2), .d3(d3), .s0(s0), .s1(s1), .y(y));

    initial begin
        // Create the VCD file for waveform analysis
        $dumpfile("mux4.vcd");
        $dumpvars(0, tb_mux4);

        // Display the results in the console
        $monitor("Time %t, d0 = %b, d1 = %b, d2 = %b, d3 = %b, s0 = %b, s1 = %b, y = %b", $time, d0, d1, d2, d3, s0, s1, y);

        // Apply test cases (select different data inputs based on S1 and S0)
        #10 d0 = 1; d1 = 0; d2 = 0; d3 = 0; s0 = 0; s1 = 0;  // Select D0
        #10 d0 = 0; d1 = 1; d2 = 0; d3 = 0; s0 = 0; s1 = 1;  // Select D1
        #10 d0 = 0; d1 = 0; d2 = 1; d3 = 0; s0 = 1; s1 = 0;  // Select D2
        #10 d0 = 0; d1 = 0; d2 = 0; d3 = 1; s0 = 1; s1 = 1;  // Select D3

        // Finish the simulation
        $finish;
    end
endmodule


