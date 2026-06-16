module top #(
    parameter DATA_WIDTH = 8,
    parameter KERNEL_SIZE = 3,
    parameter IMAGE_WIDTH = 28,
    parameter IMAGE_HEIGHT = 28
)(
    input clk,
    input rst,
    input data_in,
    output [3:0]prediction,
    output prediction_valid
);

wire byte_done;
wire [7:0]rx_out;

rx RX_DUT (
    .i_Clock(clk),
    .i_Rx_Serial(data_in),
    .o_Rx_DV(byte_done),
    .o_Rx_Byte(rx_out)
);

conv #(
    .DATA_WIDTH(DATA_WIDTH),
    .KERNEL_SIZE(KERNEL_SIZE),
    .IMAGE_WIDTH(IMAGE_WIDTH),
    .IMAGE_HEIGHT(IMAGE_HEIGHT))
CNN_DUT (
    .clk(clk),
    .rst(rst),
    .pixel_in(rx_out),
    .pixel_in_valid(byte_done),
    .prediction(prediction),
    .data_out_valid(prediction_valid)
);

endmodule