module ff_pos (d, clk, rst_n, q);
input d, clk, rst_n;
output reg q;

always @(posedge clk) 
begin
    if(!rst_n)
        q <= 0;
    else 
    q <= d
end

endmodule

module ff_neg_asy (d, clk, rst_n, q);

input d, clk, rst_n;
output reg q;

always @(negedge clk or negedge rst_n)
begin
    if (!rst_n)
    q <= 1'b0
    else
    q<=d;
end

endmodule


module ff (d, clk, ce, q);

input d, clk, ce;
output reg q;

always @(posedge clk)
    begin
    if(ce) q<= d;
    else q <= q;
    end
endmodule

module register(clk, d, ce, pre, q);

input clk, ce, pre;
input [3:0] d;
output reg [3:0] q;

always @(posedge clk) 
begin
    if(ce) q <= d;
    else if(pre) q<=4'b1111;
en

endmodule

module latch (d, q, en);

input d, en;
output reg q;

always @(en or d)
begin
  if(en) q<= d;
end
endmodule

module fsm (clk, rest, x1, outp);
input clk, rest, x1;
output reg outp;

reg [1:0] state;
reg [1:0] next_state;
parameter s1 = 2'b00;
parameter s2 = 2'b01;
parameter s3 = 2'b10;
parameter s4 = 2'b11;

always @(posedge clk or posedge rest)
begin
    if(rest) state <= s1;
    else state <= next_state;
end

always @(state, x1)
begin
    outp <= 0;
    case(state)
        s1: if(x1 = 1'b1) next_state = s2; else next_state = s3;
        s2: next_state = s3;
        s3: next_state = s4;
        s4: next_state = s1; outp <= 1;
        default: next_state = s1;
    endcase
end

endmodule

module counter (clk, clr, q);
input clk, clr;
output [3:0]reg q;

always @(posedge clk or posedge clr)
begin
    if(clr) q<= 4'b0000;
    else q <= q + 1'b1;
end

endmodule

module counter(d, clk, load, q);
input clk, clr;
input [3:0] d; 
output reg [3:0] q;

always @(posedge clk or posedge load) 
begin
    if(load) q <= d;
    else q + 1'b1; 
end

endmodule

module shift(clk, si, so);

input clk, si;
output reg so;

reg [7:0] temp;

always @(posedge clk)
begin
    tmp <= tmp << 1;
    tmp[0] <= si;
end

assign so = tmp[7];

endmodule

module shift(clk, ce, si, so);
input clk, ce, si;
output reg so;

reg [7:0] temp;

always @(negedge clk)
begin
    if(ce) begin
        temp <= temp << 1;
        temp[0] <= si;
    end
end

assign so = temp[7];

endmodule

module shift (clk, s, si, so);
input clk, s, si;
output so;
reg [7:0] temp;

always @(clk) 
begin
    if(s) temp <= 8'b11111111;
    else temp <= {temp[6:0], si};
end

assign so = tmp[7]; 
endmodule

module mult(clk, a, b, mult);
input clk;
input [17:0] a;
input [17:0] b;
output reg [35:0] mult;

reg [17:0] a_in;
reg [17:0] b_in;
wire [35:0] mult_res;
reg [35:0] pipe1, pipe2, pipe3;

assign mult_res = a_in * b_in;

always @(posedge clk)
begin
    a_in <= a;
    b_in <= b;
    pipe1 <= mult__res;
    pipe2 <= pipe1;
    pipe3 <= pipe2;
    mult <= pipe3;
end

endmodule

module mult(clk, a, b, mult);

input clk;
input [17:0] a, b;
output reg [35:0] mult;

reg [17:0] a_in, b_in;
reg [35:0] mult_res;
reg [35:0] pipe_1, pipe_2, pipe_3;
reg [35:0] pipe_regs [4:0];

assign mult_res <= a_in * b_in;

always @(posedge clk)
begin
    a_in <= a;
    b_in <= b;
    // mult_res <= a_in * b_in;
    // pipe_1 <= mult_res;
    // pipe_2 <= pipe_1;
    // pipe_3 <= pipe_2;
    // mult <= pipe_3;
    {mult, pipe_regs[4], pipe_regs[3], pipe_regs[2], pipe_regs[1], pipe_regs[0]} <= {
        pipe_regs[4], pipe_regs[3],  pipe_regs[2], pipe_regs[1], pipe_regs[0], mult_res};           
end

endmodule

module raminfr (clk, en, we, addr, di, do);
begin
    input clk, we, en;
    input [4:0] addr;
    input [3:0] di;
    output reg [3:0] do;

    reg [3:0] RAM [31:0];
    
    always@(posedge clk)
    begin
        if(en) 
        begin
            if(we) 
            begin
                RAM[addr] <= di;  
            end
            do <= RAM[addr];
        end
    end
end