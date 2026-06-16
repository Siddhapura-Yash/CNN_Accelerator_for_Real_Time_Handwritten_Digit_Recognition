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

reg signed [DATA_WIDTH-1:0] w1    [0:143];
reg signed [DATA_WIDTH-1:0] B1    [0:15];

reg signed [DATA_WIDTH-1:0] w2_0  [0:2703];
reg signed [DATA_WIDTH-1:0] w2_1  [0:2703];
reg signed [DATA_WIDTH-1:0] w2_2  [0:2703];
reg signed [DATA_WIDTH-1:0] w2_3  [0:2703];
reg signed [DATA_WIDTH-1:0] w2_4  [0:2703];
reg signed [DATA_WIDTH-1:0] w2_5  [0:2703];
reg signed [DATA_WIDTH-1:0] w2_6  [0:2703];
reg signed [DATA_WIDTH-1:0] w2_7  [0:2703];
reg signed [DATA_WIDTH-1:0] w2_8  [0:2703];
reg signed [DATA_WIDTH-1:0] w2_9  [0:2703];

reg signed [DATA_WIDTH-1:0] B2    [0:9];

initial begin
    $readmemh("W1_int8.txt",   w1);
    $readmemh("B1_int8.txt",   B1);

    $readmemh("W2_int8_0.txt", w2_0);
    $readmemh("W2_int8_1.txt", w2_1);
    $readmemh("W2_int8_2.txt", w2_2);
    $readmemh("W2_int8_3.txt", w2_3);
    $readmemh("W2_int8_4.txt", w2_4);
    $readmemh("W2_int8_5.txt", w2_5);
    $readmemh("W2_int8_6.txt", w2_6);
    $readmemh("W2_int8_7.txt", w2_7);
    $readmemh("W2_int8_8.txt", w2_8);
    $readmemh("W2_int8_9.txt", w2_9);

    $readmemh("B2_int8.txt",   B2);
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

(* ram_style = "block" *)
reg signed [19:0] fmap1  [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap2  [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap3  [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap4  [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap5  [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap6  [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap7  [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap8  [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap9  [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap10 [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap11 [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap12 [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap13 [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap14 [0:675];
(* ram_style = "block" *)
reg signed [19:0] fmap15 [0:675];
(* ram_style = "block" *)
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

(* ram_style = "block" *)
reg signed [19:0] pool_result1[0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result2[0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result3[0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result4[0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result5[0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result6[0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result7[0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result8[0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result9[0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result10 [0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result11 [0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result12 [0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result13 [0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result14 [0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result15 [0:168];
(* ram_style = "block" *)
reg signed [19:0] pool_result16 [0:168];

reg [2:0]  pool_phase;
reg [9:0]  bram_addr;
reg [9:0]  idx_hold;
reg [4:0]  pool_row;
reg [4:0]  pool_col;
reg [7:0]  pool_count;        // single shared counter 
 
reg signed [19:0] top1,    top2,    top3,    top4,    top5,    top6,    top7,    top8;
reg signed [19:0] top9,    top10,   top11,   top12,   top13,   top14,   top15,   top16;

reg signed [19:0] top1_p1, top2_p1, top3_p1, top4_p1, top5_p1, top6_p1, top7_p1, top8_p1;
reg signed [19:0] top9_p1, top10_p1,top11_p1,top12_p1,top13_p1,top14_p1,top15_p1,top16_p1;

reg signed [19:0] bot1,    bot2,    bot3,    bot4,    bot5,    bot6,    bot7,    bot8;
reg signed [19:0] bot9,    bot10,   bot11,   bot12,   bot13,   bot14,   bot15,   bot16;

reg signed [19:0] bot1_p1, bot2_p1, bot3_p1, bot4_p1, bot5_p1, bot6_p1, bot7_p1, bot8_p1;
reg signed [19:0] bot9_p1, bot10_p1,bot11_p1,bot12_p1,bot13_p1,bot14_p1,bot15_p1,bot16_p1;
 
wire [9:0] idx;
assign idx = pool_row * 26 + pool_col;
 
always @(posedge clk) begin
    if (!rst) begin
        pool_phase <= 3'd0;
        pool_count <= 8'd0;
        pool_row   <= 5'd0;
        pool_col   <= 5'd0;
        idx_hold   <= 10'd0;
        bram_addr  <= 10'd0;
    end
    else if (pool_start && pool_count < 169) begin
        case (pool_phase)
 
            3'd0: begin
                bram_addr  <= idx;
                idx_hold   <= idx;
                pool_phase <= 3'd1;
            end

            3'd1: begin
                top1  <= fmap1[bram_addr];   
                top2  <= fmap2[bram_addr];
                top3  <= fmap3[bram_addr];   
                top4  <= fmap4[bram_addr];
                top5  <= fmap5[bram_addr];   
                top6  <= fmap6[bram_addr];
                top7  <= fmap7[bram_addr];   
                top8  <= fmap8[bram_addr];
                top9  <= fmap9[bram_addr];   
                top10 <= fmap10[bram_addr];
                top11 <= fmap11[bram_addr];  
                top12 <= fmap12[bram_addr];
                top13 <= fmap13[bram_addr];  
                top14 <= fmap14[bram_addr];
                top15 <= fmap15[bram_addr];  
                top16 <= fmap16[bram_addr];
                bram_addr  <= idx_hold + 10'd1;
                pool_phase <= 3'd2;
            end
 
            3'd2: begin
                top1_p1  <= fmap1[bram_addr];   
                top2_p1  <= fmap2[bram_addr];
                top3_p1  <= fmap3[bram_addr];   
                top4_p1  <= fmap4[bram_addr];
                top5_p1  <= fmap5[bram_addr];   
                top6_p1  <= fmap6[bram_addr];
                top7_p1  <= fmap7[bram_addr];   
                top8_p1  <= fmap8[bram_addr];
                top9_p1  <= fmap9[bram_addr];   
                top10_p1 <= fmap10[bram_addr];
                top11_p1 <= fmap11[bram_addr];  
                top12_p1 <= fmap12[bram_addr];
                top13_p1 <= fmap13[bram_addr];  
                top14_p1 <= fmap14[bram_addr];
                top15_p1 <= fmap15[bram_addr];  
                top16_p1 <= fmap16[bram_addr];
                bram_addr  <= idx_hold + 10'd26;
                pool_phase <= 3'd3;
            end
 
            3'd3: begin
                bot1  <= fmap1[bram_addr];   
                bot2  <= fmap2[bram_addr];
                bot3  <= fmap3[bram_addr];   
                bot4  <= fmap4[bram_addr];
                bot5  <= fmap5[bram_addr];   
                bot6  <= fmap6[bram_addr];
                bot7  <= fmap7[bram_addr];   
                bot8  <= fmap8[bram_addr];
                bot9  <= fmap9[bram_addr];   
                bot10 <= fmap10[bram_addr];
                bot11 <= fmap11[bram_addr];  
                bot12 <= fmap12[bram_addr];
                bot13 <= fmap13[bram_addr];  
                bot14 <= fmap14[bram_addr];
                bot15 <= fmap15[bram_addr];  
                bot16 <= fmap16[bram_addr];
                bram_addr  <= idx_hold + 10'd27;
                pool_phase <= 3'd4;
            end
 
            3'd4: begin
                bot1_p1  <= fmap1[bram_addr];   
                bot2_p1  <= fmap2[bram_addr];
                bot3_p1  <= fmap3[bram_addr];   
                bot4_p1  <= fmap4[bram_addr];
                bot5_p1  <= fmap5[bram_addr];   
                bot6_p1  <= fmap6[bram_addr];
                bot7_p1  <= fmap7[bram_addr];   
                bot8_p1  <= fmap8[bram_addr];
                bot9_p1  <= fmap9[bram_addr];   
                bot10_p1 <= fmap10[bram_addr];
                bot11_p1 <= fmap11[bram_addr];  
                bot12_p1 <= fmap12[bram_addr];
                bot13_p1 <= fmap13[bram_addr];  
                bot14_p1 <= fmap14[bram_addr];
                bot15_p1 <= fmap15[bram_addr];  
                bot16_p1 <= fmap16[bram_addr];
                pool_phase <= 3'd5;
            end

            3'd5: begin
                pool_result1[pool_count]  <= max4(top1,  top1_p1,  bot1,  bot1_p1);
                pool_result2[pool_count]  <= max4(top2,  top2_p1,  bot2,  bot2_p1);
                pool_result3[pool_count]  <= max4(top3,  top3_p1,  bot3,  bot3_p1);
                pool_result4[pool_count]  <= max4(top4,  top4_p1,  bot4,  bot4_p1);
                pool_result5[pool_count]  <= max4(top5,  top5_p1,  bot5,  bot5_p1);
                pool_result6[pool_count]  <= max4(top6,  top6_p1,  bot6,  bot6_p1);
                pool_result7[pool_count]  <= max4(top7,  top7_p1,  bot7,  bot7_p1);
                pool_result8[pool_count]  <= max4(top8,  top8_p1,  bot8,  bot8_p1);
                pool_result9[pool_count]  <= max4(top9,  top9_p1,  bot9,  bot9_p1);
                pool_result10[pool_count] <= max4(top10, top10_p1, bot10, bot10_p1);
                pool_result11[pool_count] <= max4(top11, top11_p1, bot11, bot11_p1);
                pool_result12[pool_count] <= max4(top12, top12_p1, bot12, bot12_p1);
                pool_result13[pool_count] <= max4(top13, top13_p1, bot13, bot13_p1);
                pool_result14[pool_count] <= max4(top14, top14_p1, bot14, bot14_p1);
                pool_result15[pool_count] <= max4(top15, top15_p1, bot15, bot15_p1);
                pool_result16[pool_count] <= max4(top16, top16_p1, bot16, bot16_p1);
 
                pool_count <= pool_count + 8'd1;
 
                if (pool_col == 5'd24) begin
                    pool_col <= 5'd0;
                    pool_row <= pool_row + 5'd2;
                end else begin
                    pool_col <= pool_col + 5'd2;
                end
 
                pool_phase <= 3'd0;
            end
 
            default: pool_phase <= 3'd0;
 
        endcase
    end
end

//10 FSM each state reads from all 16 pool_result line by line and output of that is applied to all ACC it multiplies it's weight
//read 0 to 168 total values from pool_result

reg flatten_running;
always@(posedge clk)
begin
    if(!rst)
        flatten_running <= 1'b0;
    else if(pool_count == 168)
        flatten_running <= 1'b1;
end

reg [4:0]acc_state;
reg [7:0]acc_count;     //will count 0 to 168 for indexing of pool_result 
reg signed [19:0]pool_value;
reg pool_value_valid;

always@(posedge clk)
begin
    if(!rst)
    begin
        acc_state <= 'b0;
        pool_value_valid <= 'b0;
        acc_count <= 'b0;
    end
    else if(flatten_running)
    begin
    case(acc_state)

        0 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result1[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 1;
            end
        end

        1 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result2[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 2;
            end
        end

        2 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result3[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 3;
            end
        end

        3 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result4[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;                
                acc_state <= 4;
            end
        end

        4 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result5[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 5;
            end
        end

        5 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result6[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 6;
            end
        end

        6 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result7[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 7;
            end
        end

        7 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result8[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;                
                acc_state <= 8;
            end
        end

        8 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result9[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 9;
            end
        end

        9 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result10[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 10;
            end
        end

        10 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result11[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 11;
            end
        end

        11 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result12[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;                
                acc_state <= 12;
            end
        end

        12 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result13[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 13;
            end
        end

        13 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result14[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 14;
            end
        end

        14 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result15[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;
                acc_state <= 15;
            end
        end

        15 : 
        begin
            if(acc_count < 169)
            begin
                pool_value <= pool_result16[acc_count];
                pool_value_valid <= 1'b1;
                acc_count <= acc_count + 1'b1;
            end
            else if(acc_count == 169)
            begin
                pool_value_valid <= 1'b0;
                acc_count <= 'b0;                
                acc_state <= 16;
            end
        end

    endcase
    end
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

integer k;  //track every multiplication so we can exit at right time

always@(posedge clk)
begin
    if(!rst)
    begin
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

        k <= 'b0;
    end
    else if(pool_value_valid && k < 2704)
    begin
        acc0 <= acc0 + ($signed(pool_value)) * ($signed(w2_0[k]));
        acc1 <= acc1 + ($signed(pool_value)) * ($signed(w2_1[k]));
        acc2 <= acc2 + ($signed(pool_value)) * ($signed(w2_2[k]));
        acc3 <= acc3 + ($signed(pool_value)) * ($signed(w2_3[k]));
        acc4 <= acc4 + ($signed(pool_value)) * ($signed(w2_4[k]));
        acc5 <= acc5 + ($signed(pool_value)) * ($signed(w2_5[k]));
        acc6 <= acc6 + ($signed(pool_value)) * ($signed(w2_6[k]));
        acc7 <= acc7 + ($signed(pool_value)) * ($signed(w2_7[k]));
        acc8 <= acc8 + ($signed(pool_value)) * ($signed(w2_8[k]));
        acc9 <= acc9 + ($signed(pool_value)) * ($signed(w2_9[k]));

        k <= k + 1'b1;
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
        dense_start <= (k == 2704);
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