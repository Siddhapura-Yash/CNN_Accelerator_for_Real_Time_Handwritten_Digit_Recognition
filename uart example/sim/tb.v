module tb;

localparam DATA_WIDTH = 8;
localparam KERNEL_SIZE = 3;
localparam IMAGE_WIDTH = 28;
localparam IMAGE_HEIGHT = 28;
localparam CLKS_PER_BIT = 100;     //100 for 100Mhz

reg clk;
reg rst;
reg data_in;
reg data_in_valid;
wire [3:0] prediction;
wire final_valid;

top #(.DATA_WIDTH(DATA_WIDTH),
        .KERNEL_SIZE(KERNEL_SIZE),
        .IMAGE_WIDTH(IMAGE_WIDTH),
        .IMAGE_HEIGHT(IMAGE_HEIGHT))
DUT (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .prediction(prediction),
    .prediction_valid(final_valid)
);

integer i;

initial 
begin
    clk = 0;
    rst = 1;
    data_in_valid = 0;
end

reg [7:0]weight[0:IMAGE_WIDTH*IMAGE_HEIGHT-1];

initial begin
    $readmemh("my_img.hex",weight);
end

always #5 clk = ~clk;

task send_byte(input [7:0] data);
integer i;
begin

    data_in = 0;
    repeat(CLKS_PER_BIT) @(posedge clk);

    for(i=0;i<8;i=i+1)
    begin
        data_in = data[i];
        repeat(CLKS_PER_BIT) @(posedge clk);
    end

    data_in = 1;
    repeat(CLKS_PER_BIT) @(posedge clk);

end
endtask

initial 
begin
    rst = 0;
    #10
    rst = 1;

    for(i=0; i<IMAGE_HEIGHT*IMAGE_WIDTH; i++)
    begin
        @(negedge clk);
        send_byte(weight[i]);
        data_in_valid = 1'b1;
    end
        @(negedge clk);
        data_in_valid = 1'b0;

        #500000;
        $finish;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb);
end

initial begin
    $monitor("%0t final_valid=%b prediction=%0d", $time, final_valid, prediction);
end

endmodule