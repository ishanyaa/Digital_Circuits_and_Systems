// Structural model for a 3-input AND gate
module and3(input a, b, c, output y); 
  and g1(y, a, b, c); // AND gate instantiation
endmodule

// Testbench for the 3-input AND gate
module tb_and3;
  reg a, b, c;  // Declare input signals as reg  
  wire y;       // Declare output signal as wire

  // Instantiate the and3 module
  and3 uut (.a(a), .b(b), .c(c), .y(y));

  initial begin
    #1;  // Ensure the simulation starts properly

    // Initialize the VCD file for GTKWave
    $dumpfile("and3.vcd");
    $dumpvars(0, tb_and3);

    // Monitor the signal values
    $monitor("Time %t, a = %b, b = %b, c = %b, y = %b", $time, a, b, c, y);

    // Test cases
    #10; a = 1'b0; b = 1'b0; c = 1'b0;
    #10; a = 1'b0; b = 1'b0; c = 1'b1;
    #10; a = 1'b0; b = 1'b1; c = 1'b0;
    #10; a = 1'b0; b = 1'b1; c = 1'b1;
    #10; a = 1'b1; b = 1'b0; c = 1'b0;
    #10; a = 1'b1; b = 1'b0; c = 1'b1;
    #10; a = 1'b1; b = 1'b1; c = 1'b0;
    #10; a = 1'b1; b = 1'b1; c = 1'b1;

    $finish; // End simulation
  end
endmodule
