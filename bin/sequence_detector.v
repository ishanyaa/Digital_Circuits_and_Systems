module sequence_detector (
    input wire clk,          // Clock signal
    input wire reset,        // Reset signal
    input wire x,           // Input signal
    output reg Z            // Output signal
);

    // State encoding
    parameter S0 = 3'b000,  // Initial state
              S1 = 3'b001,  // State after receiving '1'
              S2 = 3'b010,  // State after receiving '11'
              S3 = 3'b011,  // State after receiving '110'
              S4 = 3'b100;  // State after receiving '1101'

    reg [2:0] current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;  // Reset to initial state
        else
            current_state <= next_state;  // Move to the next state
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (x) ? S1 : S0;      // If x=1, go to S1; else stay in S0
            S1: next_state = (x) ? S2 : S0;      // If x=1, go to S2; else go back to S0
            S2: next_state = (x) ? S3 : S0;      // If x=1, go to S3; else go back to S0
            S3: next_state = (x) ? S4 : S0;      // If x=1, go to S4; else go back to S0
            S4: next_state = (x) ? S2 : S0;      // After detecting 1101, go back to S2 if next x is 1; else go back to S0
            default: next_state = S0;            // Default case
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            Z <= 0;  // Reset output to 0
        else
            Z <= (current_state == S4) ? 1 : 0;  // Set Z to 1 if in state S4
    end

endmodule


module sequence_detector (
    input wire clk,          // Clock signal
    input wire reset,        // Reset signal
    input wire x,           // Input signal
    output reg Z            // Output signal
);

    // State encoding
    parameter S0 = 3'b000,  // Initial state
              S1 = 3'b001,  // State after receiving '1'
              S2 = 3'b010,  // State after receiving '11'
              S3 = 3'b011,  // State after receiving '110'
              S4 = 3'b100;  // State after receiving '1101'

    reg [2:0] current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;  // Reset to initial state
        else
            current_state <= next_state;  // Move to the next state
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (x) ? S1 : S0;      // If x=1, go to S1; else stay in S0
            S1: next_state = (x) ? S2 : S0;      // If x=1, go to S2; else go back to S0
            S2: next_state = (x) ? S3 : S0;      // If x=1, go to S3; else go back to S0
            S3: next_state = (x) ? S4 : S0;      // If x=1, go to S4; else go back to S0
            S4: next_state = (x) ? S2 : S0;      // After detecting 1101, go back to S2 if next x is 1; else go back to S0
            default: next_state = S0;            // Default case
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            Z <= 0;  // Reset output to 0
        else
            Z <= (current_state == S4) ? 1 : 0;  // Set Z to 1 if in state S4
    end

endmodule


    // VCD dump for GTKWave
    initial begin
        $dumpfile("sequence_detector.vcd"); // Specify the dump file name
        $dumpvars(0, tb_sequence_detector);  // Dump all variables in the test bench
    end

endmodule

