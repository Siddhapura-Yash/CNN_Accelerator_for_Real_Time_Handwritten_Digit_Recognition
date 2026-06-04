module neuron #(parameter DATA_WIDTH = 8,
                parameter KERNEL_SIZE = 3)
                (
                    input clk,
                    input rst,
                    input pixel_in_valid,
                    input [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0]pixel_in,
                    input signed [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0]weight,
                    
                    output reg signed [19:0]data_out,
                    output reg data_out_valid
                );

reg [2:0]state;
localparam IDLE = 3'b000,
           MAC = 3'b001,
           OUT = 3'b010;

reg [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0]temp_pixel;
reg signed [KERNEL_SIZE*KERNEL_SIZE*DATA_WIDTH-1:0]temp_weight;

//3 bit counter can reach 8 values so we are using it do multiplication of each term and add
reg [3:0]count;
reg signed [19:0]acc;  //will store each result with accumulation

always@(posedge clk)
begin
    if(!rst)
    begin
        state <= IDLE;
    end
    else 
    begin
        case(state)

        IDLE : begin
            if(pixel_in_valid)
            begin
                state <= MAC;
                count <= 'b0;
                acc <= 'b0;
                temp_pixel <= pixel_in;
                temp_weight <= weight;
                data_out_valid <= 1'b0;
            end
            else 
            begin
                state <= IDLE;
                data_out_valid <= 1'b0;
            end
        end

        MAC : begin
            if(count < 9)
            begin
                acc <= acc + ($signed ({1'b0,temp_pixel[count*DATA_WIDTH +: DATA_WIDTH]}) * ($signed(temp_weight[count*DATA_WIDTH +: DATA_WIDTH])));
                count <= count + 1'b1;
                state <= MAC;
            end
            else if(count == 9)
            begin
                state <= OUT;
                count <= 'b0;
            end
        end

        OUT : begin
            data_out <= acc;
            data_out_valid <= 1'b1;
            state <= IDLE;
        end

        default  : state <= IDLE;
        endcase

    end
end


endmodule