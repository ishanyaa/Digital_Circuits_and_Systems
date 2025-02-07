//Assignment 1 Q3

module HS(input x, y, output b, d);

wire nx;  // Negated x (NOT x)

    not g1(nx, x);       // NOT gate to invert x
    and g2(b, nx, y);    // AND gate for the borrow output (b)
    xor g3(d, x, y);     // XOR gate for the sum output (d)
endmodule


module tb_HS;
reg x,y;
wire b, d;

HS uut ( .x(x), .y(y), .b(b), .d(d));

initial begin 

        $dumpfile("HS.vcd");   
        $dumpvars(0, tb_HS);

$monitor("Time %t, x = %b, y=%b, b = %b, d = %d", $time, x, y, b, d);

# 10; x = 0; y = 0;
# 10; x = 0; y = 1; 
# 10; x = 1; y = 0; 
# 10; x = 1; y = 1; 

$finish;
end 
endmodule

