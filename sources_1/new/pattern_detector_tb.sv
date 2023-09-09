class Randgen;
rand bit num;
    function new();
        
    endfunction //new()
endclass //Randgen

module bin_tb ();
timeunit 1ns/1ps;
logic data_in,clk,data_valid,reset,data_out;
logic [2:0] state_out;

Pattern_Detector dut(.*);
assign clk=1;
initial forever begin
    data_valid=1;
    #10
    clk <= ~clk;
end

Randgen R_in= new();  

initial begin
    #30;
    repeat(50) @(posedge clk) begin
        #2;
        data_in=R_in.num;
        reset=0;
        R_in.randomize();
    end 
    #10 data_in = 1;reset=0;
    #10 data_in = 1;reset=1;
    $finish();

    

end



endmodule