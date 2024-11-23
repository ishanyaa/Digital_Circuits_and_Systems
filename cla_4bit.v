module cla_4bit(input [3:0] A, input [3:0] B, input Cin, output [3:0] Sum, output Cout);

  wire [3:0] G, P;   // Generate and Propagate signals
  wire [3:0] C;      // Carry signals
  
  // Generate and Propagate calculations
  assign G = A & B;         // Generate: G[i] = A[i] & B[i]
  assign P = A ^ B;         // Propagate: P[i] = A[i] ^ B[i]

  // Carry calculations (using carry look-ahead logic)
  assign C[0] = Cin;  // The first carry is the input carry
  assign C[1] = G[0] | (P[0] & Cin);  // Carry logic for bit 1
  assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);  // Carry logic for bit 2
  assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);  // Carry logic for bit 3

  // Sum calculations
  assign Sum = P ^ C;  // Sum[i] = P[i] ^ C[i]

  // Carry out (final carry out)
  assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);

endmodule


module tb_cla_4bit;
  reg [3:0] A, B;
  reg Cin;
  wire [3:0] Sum;
  wire Cout;

  // Instantiate the CLA module
  cla_4bit uut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
  );

  initial begin
    // Create the dump file for waveform
    $dumpfile("cla_4bit.vcd");
    $dumpvars(0, tb_cla_4bit);

    // Monitor the values
    $monitor("Time: %t, A = %b, B = %b, Cin = %b, Sum = %b, Cout = %b", $time, A, B, Cin, Sum, Cout);

    // Test cases
    A = 4'b0000; B = 4'b0000; Cin = 0; #10;  // 0 + 0 = 0000, Cout = 0
    A = 4'b0101; B = 4'b1010; Cin = 0; #10;  // 5 + 10 = 15, Cout = 0
    A = 4'b1111; B = 4'b1111; Cin = 1; #10;  // 15 + 15 + 1 = 31, Cout = 1
    A = 4'b0011; B = 4'b0101; Cin = 1; #10;  // 3 + 5 + 1 = 9, Cout = 0
    A = 4'b1000; B = 4'b1000; Cin = 0; #10;  // 8 + 8 = 16, Cout = 0
    A = 4'b1111; B = 4'b0001; Cin = 1; #10;  // 15 + 1 + 1 = 17, Cout = 0
    A = 4'b0110; B = 4'b0110; Cin = 1; #10;  // 6 + 6 + 1 = 13, Cout = 0

    $finish;
  end
endmodule
