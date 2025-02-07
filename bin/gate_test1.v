// 3-input AND gate module
module and3 (output Y, input A, B, C);
  and (Y, A, B, C);
endmodule

// 3-input OR gate module
module or3 (output Y, input A, B, C);
  or (Y, A, B, C);
endmodule

// Testbench to test both AND and OR gates
module tb_gate;

  reg A, B, C;
  wire Y_and, Y_or;

  // Instantiate the 3-input AND gate
  and3 u1 (.Y(Y_and), .A(A), .B(B), .C(C));
  
  // Instantiate the 3-input OR gate
  or3 u2 (.Y(Y_or), .A(A), .B(B), .C(C));

  initial begin

    $dumpfile("gate_test.vcd");  // Create a dumpfile for GTKWave
    $dumpvars(0, tb_gate); 

    // Monitor changes
    $monitor("Time: %0d | A=%b B=%b C=%b | AND Output=%b OR Output=%b", $time, A, B, C, Y_and, Y_or);
    
    // Apply test vectors
    A = 0; B = 0; C = 0; #10;
    A = 0; B = 0; C = 1; #10;
    A = 0; B = 1; C = 0; #10;
    A = 0; B = 1; C = 1; #10;
    A = 1; B = 0; C = 0; #10;
    A = 1; B = 0; C = 1; #10;
    A = 1; B = 1; C = 0; #10;
    A = 1; B = 1; C = 1; #10;
    
    $finish;
  end

endmodule
