module conv #(parameter DATA_WIDTH = 8,
             parameter KERNEL_SIZE = 3,
             parameter IMAGE_WIDTH = 28,
             parameter IMAGE_HEIGHT = 28)(
                input clk,
                input rst,
                input [DATA_WIDTH-1:0]pixel_in,
                input pixel_in_valid,
                output reg [3:0] prediction,
                output reg final_valid
             );

wire [DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]control_out;
wire control_out_valid;

control_logic #(.DATA_WIDTH(DATA_WIDTH),
                .KERNEL_SIZE(KERNEL_SIZE),
                .IMAGE_WIDTH(IMAGE_WIDTH))
line_buffer_DUT (
                .clk(clk),
                .rst(rst),
                .data_in(pixel_in),
                .data_in_valid(pixel_in_valid),
                .data_out(control_out),
                .data_out_valid(control_out_valid)
);

/*
wire [DATA_WIDTH-1:0]pixels[0:8];

genvar p;
generate
    for(p=0; p<9; p=p+1)
    begin
        assign pixels[p] = control_out[p*DATA_WIDTH +: DATA_WIDTH];
    end
endgenerate
*/

reg signed [DATA_WIDTH-1:0] w1 [0:143];
reg signed [DATA_WIDTH-1:0] B1 [0:15];
reg signed [DATA_WIDTH-1:0] w2 [0:27039];
reg signed [DATA_WIDTH-1:0] B2 [0:9];

initial begin
    $readmemh("W1_int8.txt", w1);
    $readmemh("B1_int8.txt", B1);
    $readmemh("W2_int8.txt", w2);
    $readmemh("B2_int8.txt", B2);
end

wire signed [19:0] result1;
wire signed [19:0] result2;
wire signed [19:0] result3;
wire signed [19:0] result4;
wire signed [19:0] result5;
wire signed [19:0] result6;
wire signed [19:0] result7;
wire signed [19:0] result8;
wire signed [19:0] result9;
wire signed [19:0] result10;
wire signed [19:0] result11;
wire signed [19:0] result12;
wire signed [19:0] result13;
wire signed [19:0] result14;
wire signed [19:0] result15;
wire signed [19:0] result16;

wire result1_valid;
wire result2_valid;
wire result3_valid;
wire result4_valid;
wire result5_valid;
wire result6_valid;
wire result7_valid;
wire result8_valid;
wire result9_valid;
wire result10_valid;
wire result11_valid;
wire result12_valid;
wire result13_valid;
wire result14_valid;
wire result15_valid;
wire result16_valid;

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac1 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[0],  w1[1],  w1[2],  w1[3],  w1[4],  w1[5],  w1[6],  w1[7],  w1[8]}),
    .data_in_valid(control_out_valid),
    .data_out(result1),
    .data_out_valid(result1_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac2 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[9],  w1[10], w1[11], w1[12], w1[13], w1[14], w1[15], w1[16], w1[17]}),
    .data_in_valid(control_out_valid),
    .data_out(result2),
    .data_out_valid(result2_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac3 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[18], w1[19], w1[20], w1[21], w1[22], w1[23], w1[24], w1[25], w1[26]}),
    .data_in_valid(control_out_valid),
    .data_out(result3),
    .data_out_valid(result3_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac4 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[27], w1[28], w1[29], w1[30], w1[31], w1[32], w1[33], w1[34], w1[35]}),
    .data_in_valid(control_out_valid),
    .data_out(result4),
    .data_out_valid(result4_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac5 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[36], w1[37], w1[38], w1[39], w1[40], w1[41], w1[42], w1[43], w1[44]}),
    .data_in_valid(control_out_valid),
    .data_out(result5),
    .data_out_valid(result5_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac6 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[45], w1[46], w1[47], w1[48], w1[49], w1[50], w1[51], w1[52], w1[53]}),
    .data_in_valid(control_out_valid),
    .data_out(result6),
    .data_out_valid(result6_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac7 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[54], w1[55], w1[56], w1[57], w1[58], w1[59], w1[60], w1[61], w1[62]}),
    .data_in_valid(control_out_valid),
    .data_out(result7),
    .data_out_valid(result7_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac8 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[63], w1[64], w1[65], w1[66], w1[67], w1[68], w1[69], w1[70], w1[71]}),
    .data_in_valid(control_out_valid),
    .data_out(result8),
    .data_out_valid(result8_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac9 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[72], w1[73], w1[74], w1[75], w1[76], w1[77], w1[78], w1[79], w1[80]}),
    .data_in_valid(control_out_valid),
    .data_out(result9),
    .data_out_valid(result9_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac10 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[81], w1[82], w1[83], w1[84], w1[85], w1[86], w1[87], w1[88], w1[89]}),
    .data_in_valid(control_out_valid),
    .data_out(result10),
    .data_out_valid(result10_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac11 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[90], w1[91], w1[92], w1[93], w1[94], w1[95], w1[96], w1[97], w1[98]}),
    .data_in_valid(control_out_valid),
    .data_out(result11),
    .data_out_valid(result11_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac12 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[99], w1[100], w1[101], w1[102], w1[103], w1[104], w1[105], w1[106], w1[107]}),
    .data_in_valid(control_out_valid),
    .data_out(result12),
    .data_out_valid(result12_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac13 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[108], w1[109], w1[110], w1[111], w1[112], w1[113], w1[114], w1[115], w1[116]}),
    .data_in_valid(control_out_valid),
    .data_out(result13),
    .data_out_valid(result13_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac14 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[117], w1[118], w1[119], w1[120], w1[121], w1[122], w1[123], w1[124], w1[125]}),
    .data_in_valid(control_out_valid),
    .data_out(result14),
    .data_out_valid(result14_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac15 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[126], w1[127], w1[128], w1[129], w1[130], w1[131], w1[132], w1[133], w1[134]}),
    .data_in_valid(control_out_valid),
    .data_out(result15),
    .data_out_valid(result15_valid)
);

mac #(.DATA_WIDTH(DATA_WIDTH), 
      .KERNEL_SIZE(KERNEL_SIZE))
mac16 (
    .clk(clk),
    .rst(rst),
    .data_in(control_out),
    .weight({w1[135], w1[136], w1[137], w1[138], w1[139], w1[140], w1[141], w1[142], w1[143]}),
    .data_in_valid(control_out_valid),
    .data_out(result16),
    .data_out_valid(result16_valid)
);

reg [9:0]count;

always@(posedge clk)
begin
    if(!rst)
    begin
        count <= 'b0;
    end
    else if(result16_valid)
    begin
        count <= count + 1'b1;
    end
end

reg signed [19:0] fmap1  [0:675];
reg signed [19:0] fmap2  [0:675];
reg signed [19:0] fmap3  [0:675];
reg signed [19:0] fmap4  [0:675];
reg signed [19:0] fmap5  [0:675];
reg signed [19:0] fmap6  [0:675];
reg signed [19:0] fmap7  [0:675];
reg signed [19:0] fmap8  [0:675];
reg signed [19:0] fmap9  [0:675];
reg signed [19:0] fmap10 [0:675];
reg signed [19:0] fmap11 [0:675];
reg signed [19:0] fmap12 [0:675];
reg signed [19:0] fmap13 [0:675];
reg signed [19:0] fmap14 [0:675];
reg signed [19:0] fmap15 [0:675];
reg signed [19:0] fmap16 [0:675];

reg [9:0] count1;
reg [9:0] count2;
reg [9:0] count3;
reg [9:0] count4;
reg [9:0] count5;
reg [9:0] count6;
reg [9:0] count7;
reg [9:0] count8;
reg [9:0] count9;
reg [9:0] count10;
reg [9:0] count11;
reg [9:0] count12;
reg [9:0] count13;
reg [9:0] count14;
reg [9:0] count15;
reg [9:0] count16;

reg signed [19:0]debug_fmap;
reg signed [19:0]debug_result1;
reg signed [DATA_WIDTH-1:0]debug_B1;

//relu activation filter is checking while storing so we don't have to do ReLU again
always @(posedge clk)
begin
    if(!rst)
    begin
        count1  <= 10'd0;
        count2  <= 10'd0;
        count3  <= 10'd0;
        count4  <= 10'd0;
        count5  <= 10'd0;
        count6  <= 10'd0;
        count7  <= 10'd0;
        count8  <= 10'd0;
        count9  <= 10'd0;
        count10 <= 10'd0;
        count11 <= 10'd0;
        count12 <= 10'd0;
        count13 <= 10'd0;
        count14 <= 10'd0;
        count15 <= 10'd0;
        count16 <= 10'd0;
    end
    else
    begin
        if(result1_valid)
        begin
            fmap1[count1] <= (((result1 + ($signed(B1[0])))  > 0)) ? (result1 + ($signed(B1[0])))  : 'b0;
            count1 <= count1 + 1'b1;
            
            debug_result1 <= (result1);
            debug_B1 <= 1'b1;
            debug_fmap <= (((result1 + ($signed(B1[0])))  > 0)) ? (result1 + ($signed(B1[0])))  : 'b0;
        end

        if(result2_valid)
        begin
            fmap2[count2] <= ((result2 + ($signed(B1[1])))  > 0) ? (result2 + ($signed(B1[1])))  : 'b0;
            count2 <= count2 + 1'b1;
        end

        if(result3_valid)
        begin
            fmap3[count3] <= ((result3 + ($signed(B1[2])))  > 0) ? (result3 + ($signed(B1[2])))  : 'b0;
            count3 <= count3 + 1'b1;
        end

        if(result4_valid)
        begin
            fmap4[count4] <= ((result4 + ($signed(B1[3])))  > 0) ? (result4 + ($signed(B1[3])))  : 'b0;
            count4 <= count4 + 1'b1;
        end

        if(result5_valid)
        begin
            fmap5[count5] <= ((result5 + ($signed(B1[4])))  > 0) ? (result5 + ($signed(B1[4])))  : 'b0;
            count5 <= count5 + 1'b1;
        end

        if(result6_valid)
        begin
            fmap6[count6] <= ((result6 + ($signed(B1[5])))  > 0) ? (result6 + ($signed(B1[5])))  : 'b0;
            count6 <= count6 + 1'b1;
        end

        if(result7_valid)
        begin
            fmap7[count7] <= ((result7 + ($signed(B1[6])))  > 0) ? (result7 + ($signed(B1[6])))  : 'b0;
            count7 <= count7 + 1'b1;
        end

        if(result8_valid)
        begin
            fmap8[count8] <= ((result8 + ($signed(B1[7])))  > 0) ? (result8 + ($signed(B1[7])))  : 'b0;
            count8 <= count8 + 1'b1;
        end

        if(result9_valid)
        begin
            fmap9[count9] <= ((result9 + ($signed(B1[8])))  > 0) ? (result9 + ($signed(B1[8])))  : 'b0;
            count9 <= count9 + 1'b1;
        end

        if(result10_valid)
        begin
            fmap10[count10] <= ((result10 + ($signed(B1[9]))) > 0) ? (result10 + ($signed(B1[9]))) : 'b0;
            count10 <= count10 + 1'b1;
        end

        if(result11_valid)
        begin
            fmap11[count11] <= ((result11 + ($signed(B1[10]))) > 0) ? (result11 + ($signed(B1[10]))) : 'b0;
            count11 <= count11 + 1'b1;
        end

        if(result12_valid)
        begin
            fmap12[count12] <= ((result12 + ($signed(B1[11]))) > 0) ? (result12 + ($signed(B1[11]))) : 'b0;
            count12 <= count12 + 1'b1;
        end

        if(result13_valid)
        begin
            fmap13[count13] <= ((result13 + ($signed(B1[12]))) > 0) ? (result13 + ($signed(B1[12]))) : 'b0;
            count13 <= count13 + 1'b1;
        end

        if(result14_valid)
        begin
            fmap14[count14] <= ((result14 + ($signed(B1[13]))) > 0) ? (result14 + ($signed(B1[13]))) : 'b0;
            count14 <= count14 + 1'b1;
        end

        if(result15_valid)
        begin
            fmap15[count15] <= ((result15 + ($signed(B1[14]))) > 0) ? (result15 + ($signed(B1[14]))) : 'b0;
            count15 <= count15 + 1'b1;
        end

        if(result16_valid)
        begin
            fmap16[count16] <= ((result16 + ($signed(B1[15]))) > 0) ? (result16 + ($signed(B1[15]))) : 'b0;
            count16 <= count16 + 1'b1;
        end
    end
end

function signed [19:0] max4;
    input signed [19:0] a0,a1,a2,a3;
    begin
        if(a0 >= a1 && a0 >= a2 && a0 >= a3)
        begin
            max4 = a0;
        end
        else if(a1 >= a0 && a1 >= a2 && a1 >= a3)
        begin
            max4 = a1;
        end
        else if(a2 >= a0 && a2 >= a1 && a2 >= a3)
        begin 
            max4 = a2;
        end
        else
        begin
            max4 = a3;
        end
    end
endfunction

//delaying one cycle so it can be pass to the pooling layer cuz storing map block is sequential so it would take one cycle to store then we can start our pooling
reg pool_start;
always@(posedge clk)
begin
    if(!rst)
    begin
        pool_start <= 'b0;
    end
    else if(count16 == 676)
    begin
        pool_start <= 1'b1;
    end
    else
    begin
        pool_start <= 1'b0;
    end
end

reg signed [19:0] pool_result1[0:168];
reg signed [19:0] pool_result2[0:168];
reg signed [19:0] pool_result3[0:168];
reg signed [19:0] pool_result4[0:168];
reg signed [19:0] pool_result5[0:168];
reg signed [19:0] pool_result6[0:168];
reg signed [19:0] pool_result7[0:168];
reg signed [19:0] pool_result8[0:168];
reg signed [19:0] pool_result9[0:168];
reg signed [19:0] pool_result10 [0:168];
reg signed [19:0] pool_result11 [0:168];
reg signed [19:0] pool_result12 [0:168];
reg signed [19:0] pool_result13 [0:168];
reg signed [19:0] pool_result14 [0:168];
reg signed [19:0] pool_result15 [0:168];
reg signed [19:0] pool_result16 [0:168];

reg [7:0] pool_count1;
reg [7:0] pool_count2;
reg [7:0] pool_count3;
reg [7:0] pool_count4;
reg [7:0] pool_count5;
reg [7:0] pool_count6;
reg [7:0] pool_count7;
reg [7:0] pool_count8;
reg [7:0] pool_count9;
reg [7:0] pool_count10;
reg [7:0] pool_count11;
reg [7:0] pool_count12;
reg [7:0] pool_count13;
reg [7:0] pool_count14;
reg [7:0] pool_count15;
reg [7:0] pool_count16;

reg [4:0] pool_row;
reg [4:0] pool_col;

wire [9:0] idx;
assign idx = pool_row*26 + pool_col;

reg signed[19:0] debug_pool_result;
reg signed [19:0]f1,f2,f3,f4;
reg [7:0]debug_pool_count;

always@(posedge clk)
begin
    if(!rst)
    begin
        pool_count1  <= 8'd0;
        pool_count2  <= 8'd0;
        pool_count3  <= 8'd0;
        pool_count4  <= 8'd0;
        pool_count5  <= 8'd0;
        pool_count6  <= 8'd0;
        pool_count7  <= 8'd0;
        pool_count8  <= 8'd0;
        pool_count9  <= 8'd0;
        pool_count10 <= 8'd0;
        pool_count11 <= 8'd0;
        pool_count12 <= 8'd0;
        pool_count13 <= 8'd0;
        pool_count14 <= 8'd0;
        pool_count15 <= 8'd0;
        pool_count16 <= 8'd0;

        pool_row <= 5'd0;
        pool_col <= 5'd0;
    end
    else if(pool_start && pool_count1 < 169)
    begin

        pool_result1[pool_count1] <= max4(fmap1[idx], fmap1[idx+1], fmap1[idx+26], fmap1[idx+27]);
        pool_count1 <= pool_count1 + 1;
        debug_pool_result <= max4(fmap1[idx], fmap1[idx+1], fmap1[idx+26], fmap1[idx+27]);
        f1 <= fmap1[idx];
        f2 <= fmap1[idx+1];
        f3 <= fmap1[idx+26];
        f4 <= fmap1[idx+27];
        debug_pool_count <= pool_count1;
        // debug_flatten1 <= max4(fmap1[idx], fmap1[idx+1], fmap1[idx+26], fmap1[idx+27]);

        pool_result2[pool_count2] <= max4(fmap2[idx], fmap2[idx+1], fmap2[idx+26], fmap2[idx+27]);
        pool_count2 <= pool_count2 + 1;

        pool_result3[pool_count3] <= max4(fmap3[idx], fmap3[idx+1], fmap3[idx+26], fmap3[idx+27]);
        pool_count3 <= pool_count3 + 1;

        pool_result4[pool_count4] <= max4(fmap4[idx], fmap4[idx+1], fmap4[idx+26], fmap4[idx+27]);
        pool_count4 <= pool_count4 + 1;

        pool_result5[pool_count5] <= max4(fmap5[idx], fmap5[idx+1], fmap5[idx+26], fmap5[idx+27]);
        pool_count5 <= pool_count5 + 1;

        pool_result6[pool_count6] <= max4(fmap6[idx], fmap6[idx+1], fmap6[idx+26], fmap6[idx+27]);
        pool_count6 <= pool_count6 + 1;

        pool_result7[pool_count7] <= max4(fmap7[idx], fmap7[idx+1], fmap7[idx+26], fmap7[idx+27]);
        pool_count7 <= pool_count7 + 1;

        pool_result8[pool_count8] <= max4(fmap8[idx], fmap8[idx+1], fmap8[idx+26], fmap8[idx+27]);
        pool_count8 <= pool_count8 + 1;

        pool_result9[pool_count9] <= max4(fmap9[idx], fmap9[idx+1], fmap9[idx+26], fmap9[idx+27]);
        pool_count9 <= pool_count9 + 1;

        pool_result10[pool_count10] <= max4(fmap10[idx], fmap10[idx+1], fmap10[idx+26], fmap10[idx+27]);
        pool_count10 <= pool_count10 + 1;

        pool_result11[pool_count11] <= max4(fmap11[idx], fmap11[idx+1], fmap11[idx+26], fmap11[idx+27]);
        pool_count11 <= pool_count11 + 1;

        pool_result12[pool_count12] <= max4(fmap12[idx], fmap12[idx+1], fmap12[idx+26], fmap12[idx+27]);
        pool_count12 <= pool_count12 + 1;

        pool_result13[pool_count13] <= max4(fmap13[idx], fmap13[idx+1], fmap13[idx+26], fmap13[idx+27]);
        pool_count13 <= pool_count13 + 1;

        pool_result14[pool_count14] <= max4(fmap14[idx], fmap14[idx+1], fmap14[idx+26], fmap14[idx+27]);
        pool_count14 <= pool_count14 + 1;

        pool_result15[pool_count15] <= max4(fmap15[idx], fmap15[idx+1], fmap15[idx+26], fmap15[idx+27]);
        pool_count15 <= pool_count15 + 1;

        pool_result16[pool_count16] <= max4(fmap16[idx], fmap16[idx+1], fmap16[idx+26], fmap16[idx+27]);
        pool_count16 <= pool_count16 + 1;

        //we are supposed to skip lines which has been used while comprison so stride = 2
        if(pool_col == 24)
        begin
            pool_col <= 0;
            pool_row <= pool_row + 2;
        end
        else
        begin
            pool_col <= pool_col + 2;
        end
    end
end

reg flatten_running;
always@(posedge clk)
begin
    if(!rst)
        flatten_running <= 1'b0;
    else if(pool_count16 == 168)
        flatten_running <= 1'b1;
    else if(i >= 169)
        flatten_running <= 1'b0;
end

reg [54079:0]flatten;
reg [19:0]debug_flatten1;

// assign debug_flatten = max4(fmap1[0], fmap1[0+1], fmap1[0+26], fmap1[0+27]);

integer i;

always @(posedge clk) begin
    if(!rst) begin
        i <= 0;
        flatten <= 'b0;
        debug_flatten1 <= 'b0;
    end
    else if(flatten_running && i < 169) begin
        flatten[(0*169+i)*20  +: 20] <= pool_result1[i];
        debug_flatten1 <= pool_result1[i];
        flatten[(1*169+i)*20  +: 20] <= pool_result2[i];
        flatten[(2*169+i)*20  +: 20] <= pool_result3[i];
        flatten[(3*169+i)*20  +: 20] <= pool_result4[i];
        flatten[(4*169+i)*20  +: 20] <= pool_result5[i];
        flatten[(5*169+i)*20  +: 20] <= pool_result6[i];
        flatten[(6*169+i)*20  +: 20] <= pool_result7[i];
        flatten[(7*169+i)*20  +: 20] <= pool_result8[i];
        flatten[(8*169+i)*20  +: 20] <= pool_result9[i];
        flatten[(9*169+i)*20  +: 20] <= pool_result10[i];
        flatten[(10*169+i)*20 +: 20] <= pool_result11[i];
        flatten[(11*169+i)*20 +: 20] <= pool_result12[i];
        flatten[(12*169+i)*20 +: 20] <= pool_result13[i];
        flatten[(13*169+i)*20 +: 20] <= pool_result14[i];
        flatten[(14*169+i)*20 +: 20] <= pool_result15[i];
        flatten[(15*169+i)*20 +: 20] <= pool_result16[i];

        i <= i + 1;
    end
end

reg fc_running;
always@(posedge clk)
begin
    if(!rst)
        fc_running <= 1'b0;
    else if(i == 169)
        fc_running <= 1'b1;
    else if(k >= 2704)
        fc_running <= 1'b0;
end

reg signed [47:0] acc0 = 'b0;
reg signed [47:0] acc1 = 'b0;
reg signed [47:0] acc2 = 'b0;
reg signed [47:0] acc3 = 'b0;
reg signed [47:0] acc4 = 'b0;
reg signed [47:0] acc5 = 'b0;
reg signed [47:0] acc6 = 'b0;
reg signed [47:0] acc7 = 'b0;
reg signed [47:0] acc8 = 'b0;
reg signed [47:0] acc9 = 'b0;

reg signed [47:0] debug_acc;

integer k;
always @(posedge clk) 
begin
    if(!rst) begin
        k <= 0;
        acc0 <= 'b0;
        acc1 <= 'b0;
        acc2 <= 'b0;
        acc3 <= 'b0;
        acc4 <= 'b0;
        acc5 <= 'b0;
        acc6 <= 'b0;
        acc7 <= 'b0;
        acc8 <= 'b0;
        acc9 <= 'b0;
        debug_acc <= 'b0;
    end
    else if(fc_running && k < 2704)
    begin
        debug_acc <= debug_acc + $signed(flatten[k*20 +: 20]) * w2[0*2704 + k];
        acc0 <= acc0 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[0*2704 + k]));
        acc1 <= acc1 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[1*2704 + k]));
        acc2 <= acc2 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[2*2704 + k]));
        acc3 <= acc3 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[3*2704 + k]));
        acc4 <= acc4 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[4*2704 + k]));
        acc5 <= acc5 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[5*2704 + k]));
        acc6 <= acc6 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[6*2704 + k]));
        acc7 <= acc7 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[7*2704 + k]));
        acc8 <= acc8 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[8*2704 + k]));
        acc9 <= acc9 + ($signed(flatten[k*20 +: 20])) * ($signed(w2[9*2704 + k]));

        k <= k + 1;
    end
end

reg dense_start;
always@(posedge clk)
begin
    if(!rst)
    begin
        dense_start <= 1'b0;
    end
    else
    begin
        dense_start <= (fc_running && k == 2704);
    end
end

reg signed [47:0] dense_out0;
reg signed [47:0] dense_out1;
reg signed [47:0] dense_out2;
reg signed [47:0] dense_out3;
reg signed [47:0] dense_out4;
reg signed [47:0] dense_out5;
reg signed [47:0] dense_out6;
reg signed [47:0] dense_out7;
reg signed [47:0] dense_out8;
reg signed [47:0] dense_out9;

always@(posedge clk)
begin
    if(!rst)
    begin
        dense_out0 <= 'b0;
        dense_out1 <= 'b0;
        dense_out2 <= 'b0;
        dense_out3 <= 'b0;
        dense_out4 <= 'b0;
        dense_out5 <= 'b0;
        dense_out6 <= 'b0;
        dense_out7 <= 'b0;
        dense_out8 <= 'b0;
        dense_out9 <= 'b0;
        final_valid <= 1'b0;
    end
    else if(dense_start)
    begin
        dense_out0 <= acc0 + ($signed(B2[0]));
        dense_out1 <= acc1 + ($signed(B2[1]));
        dense_out2 <= acc2 + ($signed(B2[2]));
        dense_out3 <= acc3 + ($signed(B2[3]));
        dense_out4 <= acc4 + ($signed(B2[4]));
        dense_out5 <= acc5 + ($signed(B2[5]));
        dense_out6 <= acc6 + ($signed(B2[6]));
        dense_out7 <= acc7 + ($signed(B2[7]));
        dense_out8 <= acc8 + ($signed(B2[8]));
        dense_out9 <= acc9 + ($signed(B2[9]));
        final_valid <= 1'b1;
    end
    else
    begin
        final_valid <= 1'b0;
    end
end

reg signed [47:0] max_val;

always @(*) begin
    prediction = 4'd0;
    max_val    = dense_out0;

    if (dense_out1 > max_val) begin
        max_val = dense_out1;
        prediction = 4'd1;
    end

    if (dense_out2 > max_val) begin
        max_val = dense_out2;
        prediction = 4'd2;
    end

    if (dense_out3 > max_val) begin
        max_val = dense_out3;
        prediction = 4'd3;
    end

    if (dense_out4 > max_val) begin
        max_val = dense_out4;
        prediction = 4'd4;
    end

    if (dense_out5 > max_val) begin
        max_val = dense_out5;
        prediction = 4'd5;
    end

    if (dense_out6 > max_val) begin
        max_val = dense_out6;
        prediction = 4'd6;
    end

    if (dense_out7 > max_val) begin
        max_val = dense_out7;
        prediction = 4'd7;
    end

    if (dense_out8 > max_val) begin
        max_val = dense_out8;
        prediction = 4'd8;
    end

    if (dense_out9 > max_val) begin
        max_val = dense_out9;
        prediction = 4'd9;
    end
end

endmodule