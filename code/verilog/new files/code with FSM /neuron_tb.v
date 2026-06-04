module neuron_tb;

localparam DATA_WIDTH = 8;
localparam KERNEL_SIZE = 3;

reg clk;
reg rst;
reg pixel_in_valid;
reg [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0]pixel_in;
reg signed [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0]weight_in;

wire signed [19:0]data_out;
wire data_out_valid;

initial begin
    clk = 0;
    rst = 1;
    pixel_in_valid = 1'b0;
end

reg [DATA_WIDTH-1:0]weight[0:8];
reg [DATA_WIDTH-1:0]pixel[0:8];

initial begin
    $readmemh("weight.hex",weight);
    $readmemh("pixel.hex",pixel);
end

always #5 clk = ~clk;

neuron #(.DATA_WIDTH(DATA_WIDTH),
         .KERNEL_SIZE(KERNEL_SIZE))
neuron_DUT (
         .clk(clk),
         .rst(rst),
         .pixel_in_valid(pixel_in_valid),
         .pixel_in(pixel_in),
         .weight(weight_in),
         .data_out(data_out),
         .data_out_valid(data_out_valid)
);

initial 
begin
    rst = 0;
    #10;
    rst = 1;
    #10;

    @(negedge clk)
    pixel_in = {pixel[0],pixel[1],pixel[2],pixel[3],pixel[4],pixel[5],pixel[6],pixel[7],pixel[8]};
    weight_in = {weight[0],weight[1],weight[2],weight[3],weight[4],weight[5],weight[6],weight[7],weight[8]};
    pixel_in_valid = 1'b1;
    #0;
    @(negedge clk)
    pixel_in_valid = 1'b0;

    #500;
    $finish;
end

initial 
begin
    $dumpfile("dump.vcd");
    $dumpvars(0,neuron_DUT);
end

endmodule