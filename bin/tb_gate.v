module tb_gate;

  reg A, B, C;
  wire Y_and, Y_or;

  // Instantiate the 3-input AND gate
  and u1 (.Y(Y_and), .A(A), .B(B), .C(C));
  
  // Instantiate the 3-input OR gate
  or u2 (.Y(Y_or), .A(A), .B(B), .C(C));

  initial begin
    // Test different combinations of A, B, and C
    $monitor("Time: %0d | A=%b B=%b C=%b | AND Output=%b OR Output=%b", $time, A, B, C, Y_and, Y_or);
    
    // Test 0 0 0
    A = 0; B = 0; C = 0;
    #10;
    
    // Test 0 0 1
    A = 0; B = 0; C = 1;
    #10;

    // Test 0 1 0
    A = 0; B = 1; C = 0;
    #10;

    // Test 0 1 1
    A = 0; B = 1; C = 1;
    #10;

    // Test 1 0 0
    A = 1; B = 0; C = 0;
    #10;

    // Test 1 0 1
    A = 1; B = 0; C = 1;
    #10;

    // Test 1 1 0
    A = 1; B = 1; C = 0;
    #10;

    // Test 1 1 1
    A = 1; B = 1; C = 1;
    #10;
    
    // End simulation
    $finish;
  end

endmodule
