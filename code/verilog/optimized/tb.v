/*
things to do 

make reg for all the bias so it will not read from multiple ports more than 2 

*/
module tb;

localparam DATA_WIDTH = 8;
localparam KERNEL_SIZE = 3;
localparam IMAGE_WIDTH = 28;
localparam IMAGE_HEIGHT = 28;

reg clk;
reg rst;
reg [DATA_WIDTH-1:0]data_in;
reg data_in_valid;
wire [3:0] prediction;
wire final_valid;

conv    #(.DATA_WIDTH(DATA_WIDTH),
        .KERNEL_SIZE(KERNEL_SIZE),
        .IMAGE_WIDTH(IMAGE_WIDTH),
        .IMAGE_HEIGHT(IMAGE_HEIGHT))
DUT (
    .clk(clk),
    .rst(rst),
    .pixel_in(data_in),
    .pixel_in_valid(data_in_valid),
    .prediction(prediction),
    .final_valid(final_valid)
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

initial 
begin
    rst = 0;
    #10
    rst = 1;

    for(i=0; i<IMAGE_HEIGHT*IMAGE_WIDTH; i++)
    begin
        @(negedge clk);
        data_in = weight[i];
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