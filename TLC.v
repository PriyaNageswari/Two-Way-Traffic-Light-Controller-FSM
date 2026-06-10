module TLC(input clk,rst,  output reg [2:0]SR,MR, output reg [7:0]counter);
    // [0] -> GREEN,   [1] -> RED,   [2] -> YELLOW
    reg [1:0]st;
    
    parameter G_R = 2'b00, G_Y = 2'b01, R_G = 2'b10, Y_G = 2'b11;
    // G -> green on small road and, R -> red on main road
    
    always @(posedge clk or posedge rst) begin
        if(rst)
            counter <= 1;
        else begin
            if(counter == 75)
                counter <= 1;
            else counter <= counter + 1; 
        end
    end
    always @(posedge clk or posedge rst)begin
        if(rst)
            st <= G_R;    
        else begin
            case(st)
                G_R : st <= (counter >= 25) ? G_Y : G_R ;
                G_Y : st <= (counter >= 30) ? R_G : G_Y ;
                R_G : st <= (counter >= 70) ? Y_G : R_G ;
                Y_G : st <= (counter >= 75) ? G_R : Y_G ;
                default : st <= G_R;
            endcase
        end
    end
    always @ * begin
        case(st) 
            // [0] -> GREEN,   [1] -> RED,   [2] -> YELLOW
            G_R : begin SR = 3'b001; MR = 3'b010; end
            G_Y : begin SR = 3'b001; MR = 3'b100; end
            R_G : begin SR = 3'b010; MR = 3'b001; end
            Y_G : begin SR = 3'b100; MR = 3'b001; end
        endcase
    end
endmodule
