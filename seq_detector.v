module seq_det (clk, rst_n, din, dout);
    input clk, rst_n, din;  
    output reg dout;

    reg[2:0] next_state;
    reg[2:0] cur_state;
    // Combinational always block for next state logic
    always @(*) begin
        // Default next state assignment
        next_state = 3'b000;
        dout = 1'b0;

        case (cur_state)
            3'b000: begin
                    dout = 1'b0;
                    if (din)
                    next_state = 3'b001; // Transition to 3'b001 on input_signal
                end

            3'b001:  begin
                        dout = 1'b0;
                        if (!din)
                        next_state = 3'b010;
                        else 
                        next_state = 3'b001;
                    end

            3'b010:  begin
                        dout = 1'b0;
                        if (din)
                        next_state = 3'b011;
                        else 
                        next_state = 3'b000;
                    end
                    
            3'b011:   begin
                        dout = 1'b0;
                        if (din)
                        next_state = 3'b100;
                        else 
                        next_state = 3'b010;
                    end
                    
            3'b100:    begin
                        dout = 1;
                        if (din)
                        next_state = 3'b001;
                        else 
                        next_state = 3'b010;
                    end
            default:  next_state = 3'b000; // Fallback to default state
        endcase
    end

    always @ (posedge clk) begin
    // If reset is asserted, go back to 3'b000 state
    if (!rst_n) begin
        cur_state <= 3'b000;
    // Else transition to the next state
    end else begin
        cur_state <= next_state;
    end
    end

endmodule

