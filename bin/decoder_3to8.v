module decoder_3to8 (
    input [2:0] A,   // 3-bit input
    output [7:0] Y   // 8-bit output
);
    wire A0_bar, A1_bar, A2_bar; // Complementary signals

    // Generate NOT A0, NOT A1, and NOT A2
    not (A0_bar, A[0]);
    not (A1_bar, A[1]);
    not (A2_bar, A[2]);

    // AND gates for each output
    and (Y[0], A2_bar, A1_bar, A0_bar);  // Y0 = !A2 & !A1 & !A0
    and (Y[1], A2_bar, A1_bar, A[0]);     // Y1 = !A2 & !A1 & A0
    and (Y[2], A2_bar, A[1], A0_bar);     // Y2 = !A2 & A1 & !A0
    and (Y[3], A2_bar, A[1], A[0]);        // Y3 = !A2 & A1 & A0
    and (Y[4], A[2], A1_bar, A0_bar);     // Y4 = A2 & !A1 & !A0
    and (Y[5], A[2], A1_bar, A[0]);        // Y5 = A2 & !A1 & A0
    and (Y[6], A[2], A[1], A0_bar);        // Y6 = A2 & A1 & !A0
    and (Y[7], A[2], A[1], A[0]);          // Y7 = A2 & A1 & A0

endmodule


//Test Bench

module tb_decoder_3to8;

	reg[2:0] A;
	wire[7:0] Y;


decoder_3to8 decoder(.A(A), .Y(Y));

initial begin

$monitor("Time = %0d | A = %b | Y = %b", $time, A, Y);

A = 3'b000; #10 
A = 3'b100; #10 
A = 3'b010; #10 
A = 3'b110; #10 
A = 3'b000; #10 
A = 3'b011; #10 
A = 3'b001; #10 
A = 3'b111; #10 
A = 3'b010; #10 

$finish;

end

endmodule