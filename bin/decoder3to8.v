// A1 Q4

module decoder3to8(input a2, a1, a0, output y0, y1, y2, y3, y4, y5, y6, y7);
    wire na2, na1, na0;

    // Invert the inputs to create not versions of a2, a1, a0
    not n0(na2, a2);  // na2 = NOT a2
    not n1(na1, a1);  // na1 = NOT a1
    not n2(na0, a0);  // na0 = NOT a0

    // Create AND gates for each output
    and g0(y0, na2, na1, na0);  // 000
    and g1(y1, na2, na1, a0);   // 001
    and g2(y2, na2, a1, na0);   // 010
    and g3(y3, na2, a1, a0);    // 011
    and g4(y4, a2, na1, na0);   // 100
    and g5(y5, a2, na1, a0);    // 101
    and g6(y6, a2, a1, na0);    // 110
    and g7(y7, a2, a1, a0);     // 111
endmodule

module tb_decoder3to8;
    reg a2, a1, a0;
    wire y0, y1, y2, y3, y4, y5, y6, y7;

    // Instantiate the 3-to-8 decoder
    decoder3to8 uut (.a2(a2), .a1(a1), .a0(a0), 
                     .y0(y0), .y1(y1), .y2(y2), .y3(y3),
                     .y4(y4), .y5(y5), .y6(y6), .y7(y7));

    initial begin
        // Create the VCD file for waveform analysis
        $dumpfile("decoder3to8.vcd");
        $dumpvars(0, tb_decoder3to8);

        // Display the results in the console
        $monitor("Time %t, a2 = %b, a1 = %b, a0 = %b, y0 = %b, y1 = %b, y2 = %b, y3 = %b, y4 = %b, y5 = %b, y6 = %b, y7 = %b", 
                 $time, a2, a1, a0, y0, y1, y2, y3, y4, y5, y6, y7);

        // Apply test cases for the decoder inputs
        #10 a2 = 0; a1 = 0; a0 = 0; // Select y0
        #10 a2 = 0; a1 = 0; a0 = 1; // Select y1
        #10 a2 = 0; a1 = 1; a0 = 0; // Select y2
        #10 a2 = 0; a1 = 1; a0 = 1; // Select y3
        #10 a2 = 1; a1 = 0; a0 = 0; // Select y4
        #10 a2 = 1; a1 = 0; a0 = 1; // Select y5
        #10 a2 = 1; a1 = 1; a0 = 0; // Select y6
        #10 a2 = 1; a1 = 1; a0 = 1; // Select y7

        // Finish the simulation
        $finish;
    end
endmodule
