// Top-level module
module top_module (input wire a, input wire b, input wire c, 
                   output wire and_out, output wire or_out);

    // Instantiate the 3-input AND gate
    and3 and_gate (
        .a(a),
        .b(b),
        .c(c),
        .y(and_out)
    );

    // Instantiate the 3-input OR gate
    or3 or_gate (
        .a(a),
        .b(b),
        .c(c),
        .y(or_out)
    );

endmodule
