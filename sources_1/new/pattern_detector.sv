typedef enum logic [2:0] { 
    IDLE,
    S1,
    S10,
    S101
} states;

module Pattern_Detector (
    input logic data_in,clk,data_valid,reset,
    output logic data_out,
    output logic [2:0]state_out
);

states state;
assign data_out =0;
always_ff @( posedge clk or posedge reset ) begin : FSM_block
    if (reset) begin
        state <= IDLE;
    end else if (data_valid ) begin
        unique case (state)
            IDLE: begin state = (data_in)?S1:IDLE; data_out<=0; end
            S1:  begin state = (data_in) ? S1 : S101; data_out<=0; end
            S10: begin state = (data_in) ? S101: IDLE; data_out<=0; end
            S101: if (data_in) begin
                data_out<=1;
                state <=S1;
            end else state<= S10;
            default : state<=IDLE;
        endcase
    end
end
assign state_out =0;
always_ff @( posedge clk ) begin : state_Check
    unique case (state)
        IDLE: state_out<=3'd0;   
        S1  : state_out<=3'd1; 
        S10 : state_out<=3'd2; 
        S101: state_out<=3'd3; 
 
    endcase
end
    
endmodule