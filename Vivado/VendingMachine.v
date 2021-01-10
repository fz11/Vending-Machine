`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Fabricio Zuniga
// Final Project
// VLSI Design
// EE 4513
// Fall 2020
//////////////////////////////////////////////////////////////////////////////////

module VendingMachine //this VM can only accept upto two hundred cents or 2 dollars
(
    input clk, rst, water_en, soda_en, //clock & reset. water_en and soda_en are enable bits that allow user to choose either soda or water bottle if they have enough money for whichever product
    input [2:0] coin_in, //coins from user
    output reg soda, //1.00 dollar
    output reg waterbottle,//50 cents
    output reg [5:0] c_return, //change
    output reg [5:0] current_state  
);
// all possible states for the state diagram, including change values
localparam Wait = 6'b000000, Five = 6'b000001, Ten = 6'b000010, Fifteen = 6'b000011, 
           Twenty = 6'b000100, Twentyfive = 6'b000101, Thirty = 6'b000110, 
           Thirtyfive = 6'b000111, Forty = 6'b001000, Fortyfive = 6'b001001, Fifty = 6'b001010,
           Fiftyfive = 6'b001011, Sixty = 6'b001100, Sixtyfive = 6'b001101, Seventy = 6'b001110,
           Seventyfive = 6'b001111, Eighty = 6'b010000, Eightyfive = 6'b010001, Ninety = 6'b010010, 
           Ninetyfive = 6'b010011, Onehundred = 6'b010100, Onehundredfive = 6'b010101, Onehundredten = 6'b010110,
           Onehundredfifteen = 6'b010111, Onehundredtwenty = 6'b011000, Onehundredtwentyfive = 6'b011001, 
           Onehundredthirty = 6'b011010, Onehundredthirtyfive = 6'b011011, Onehundredforty = 6'b011100, 
           Onehundredfortyfive = 6'b011101, Onehundredfifty = 6'b011101, Onehundredfiftyfive = 6'b011110, 
           Onehundredsixty = 6'b011111, Onehundredsixtyfive = 6'b100000, Onehundredseventy = 6'b100001, 
           Onehundredseventyfive = 6'b100010, Onehundredeighty = 6'b100011,Onehundredeightyfive = 6'b100100,
           Onehundredninety = 6'b100101, Onehundredninetyfive = 6'b100110, Twohundred = 6'b100111;  

//all possible coins to input for coin_in
localparam  NO_C = 3'b000, FIVE_C  = 3'b001, TEN_C = 3'b010, 
            TWENTYFIVE_C = 3'b011, HALFDOLLAR_C = 3'b100,
            DOLLAR_C = 3'b101;

reg [5:0] next_state; //next state


initial //initialize variables
begin
    soda = 0;
    waterbottle = 0;
    c_return = 6'b000000; // will return value based on parameter
    current_state = Wait;
    next_state = Wait;
end
  
 
always @(current_state or coin_in) //always block to determine next state of SM
begin
    case(current_state) //check current_state (from Wait, Five...One Hundred)
    
    Wait: case(coin_in)
            FIVE_C: next_state <= Five; //all possible coin values (Nickel, Dime, Quarter, Half Dollar Coin, Dollar Coin)
            TEN_C: next_state <= Ten;
            TWENTYFIVE_C: next_state <= Twentyfive;
            HALFDOLLAR_C: next_state <= Fifty;
            DOLLAR_C: next_state <= Onehundred;
            default: next_state <= Wait; 
            endcase
   Five: case(coin_in)
            FIVE_C: next_state <= Ten;
            TEN_C: next_state <= Fifteen;
            TWENTYFIVE_C: next_state <= Thirty;
            HALFDOLLAR_C: next_state <= Fiftyfive; 
            DOLLAR_C: next_state <= Onehundredfive;
            default: next_state <= Five; 
            endcase
   Ten: case(coin_in)
            FIVE_C: next_state <= Fifteen;
            TEN_C: next_state <= Twenty;
            TWENTYFIVE_C: next_state <= Thirtyfive;
            HALFDOLLAR_C: next_state <= Sixty; 
            DOLLAR_C: next_state <= Onehundredten;
            default: next_state <= Ten; 
            endcase
   Fifteen: case(coin_in)
            FIVE_C: next_state <= Twenty;
            TEN_C: next_state <= Twentyfive;
            TWENTYFIVE_C: next_state <= Thirtyfive;
            HALFDOLLAR_C: next_state <= Sixtyfive; 
            DOLLAR_C: next_state <= Onehundredfifteen;
            default: next_state <= Fifteen; 
            endcase
   Twenty: case(coin_in)
            FIVE_C: next_state <= Twentyfive;
            TEN_C: next_state <= Thirty;
            TWENTYFIVE_C: next_state <= Thirtyfive;
            HALFDOLLAR_C: next_state <= Seventy; 
            DOLLAR_C: next_state <= Onehundredtwenty;
            default: next_state <= Twenty;
            endcase
   Twentyfive: case(coin_in)
            FIVE_C: next_state <= Thirty;
            TEN_C: next_state <= Thirtyfive;
            TWENTYFIVE_C: next_state <= Forty;
            HALFDOLLAR_C: next_state <= Seventyfive;
            DOLLAR_C: next_state <= Onehundredtwentyfive;
            default: next_state <= Twentyfive; 
            endcase
   Thirty: case(coin_in)
            FIVE_C: next_state <= Thirtyfive;
            TEN_C: next_state <= Forty;
            TWENTYFIVE_C: next_state <= Fiftyfive; 
            HALFDOLLAR_C: next_state <= Eighty; 
            DOLLAR_C: next_state <= Onehundredthirty;
            default: next_state <= Thirty; 
            endcase
   Thirtyfive: case(coin_in)
            FIVE_C: next_state <= Forty;
            TEN_C: next_state <= Fortyfive;
            TWENTYFIVE_C: next_state <= Sixty; 
            HALFDOLLAR_C: next_state <= Eightyfive; 
            DOLLAR_C: next_state <= Onehundredthirtyfive;
            default: next_state <= Thirtyfive; 
            endcase
   Forty: case(coin_in)
            FIVE_C: next_state <= Fortyfive;
            TEN_C: next_state <= Fifty; 
            TWENTYFIVE_C: next_state <= Sixtyfive; 
            HALFDOLLAR_C: next_state <= Ninety; 
            DOLLAR_C: next_state <= Onehundredforty;
            default: next_state <= Forty; 
            endcase
   Fortyfive: case(coin_in)
            FIVE_C: next_state <= Fifty; 
            TEN_C: next_state <= Fiftyfive; 
            TWENTYFIVE_C: next_state <= Seventy; 
            HALFDOLLAR_C: next_state <= Ninetyfive; 
            DOLLAR_C: next_state <= Onehundredfortyfive;
            default: next_state <= Fortyfive; 
            endcase
   Fifty: case(coin_in)
            FIVE_C: next_state <= Fifty; 
            TEN_C: next_state <= Fifty; 
            TWENTYFIVE_C: next_state <= Seventyfive; 
            HALFDOLLAR_C: next_state <= Onehundred; 
            DOLLAR_C: next_state <= Onehundredfifty;
            default: next_state <= Fifty;
            endcase
   Fiftyfive: case(coin_in) 
            FIVE_C: next_state <= Sixty;
            TEN_C: next_state <= Sixtyfive;
            TWENTYFIVE_C: next_state <= Eighty;
            HALFDOLLAR_C: next_state <= Onehundredfive;
            DOLLAR_C: next_state <= Onehundredfiftyfive;
            default: next_state <= Fiftyfive;
            endcase
   Sixty: case(coin_in)
            FIVE_C: next_state <= Sixtyfive;
            TEN_C: next_state <= Seventy;
            TWENTYFIVE_C: next_state <= Eightyfive;
            HALFDOLLAR_C: next_state <= Onehundredten;
            DOLLAR_C: next_state <= Onehundredsixty;
            default: next_state <= Wait;
            endcase
   Sixtyfive:case(coin_in)
            FIVE_C: next_state <= Seventy;
            TEN_C: next_state <= Seventyfive;
            TWENTYFIVE_C: next_state <= Ninety;
            HALFDOLLAR_C: next_state <= Onehundredfifteen;
            DOLLAR_C: next_state <= Onehundredsixtyfive;
            default: next_state <= Wait;
            endcase
   Seventy: case(coin_in)
            FIVE_C: next_state <= Seventyfive;
            TEN_C: next_state <= Eighty;
            TWENTYFIVE_C: next_state <= Ninetyfive;
            HALFDOLLAR_C: next_state <= Onehundredtwenty;
            DOLLAR_C: next_state <= Onehundredseventy;
            default: next_state <= Wait;
            endcase
   Seventyfive: case(coin_in)
            FIVE_C: next_state <= Eighty;
            TEN_C: next_state <= Eightyfive;
            TWENTYFIVE_C: next_state <= Onehundred;
            HALFDOLLAR_C: next_state <= Onehundredtwentyfive;
            DOLLAR_C: next_state <= Onehundredseventyfive;
            default: next_state <= Wait;
            endcase
   Eighty: case(coin_in)
            FIVE_C: next_state <= Eightyfive;
            TEN_C: next_state <= Ninety;
            TWENTYFIVE_C: next_state <= Onehundredfive;
            HALFDOLLAR_C: next_state <= Onehundredthirty;
            DOLLAR_C: next_state <= Onehundredeighty;
            default: next_state <= Wait;
            endcase
   Eightyfive: case(coin_in)
            FIVE_C: next_state <= Ninety;
            TEN_C: next_state <= Ninetyfive;
            TWENTYFIVE_C: next_state <= Onehundredten;
            HALFDOLLAR_C: next_state <= Onehundredthirtyfive;
            DOLLAR_C: next_state <= Onehundredeightyfive;
            default: next_state <= Wait;
            endcase
   Ninety: case(coin_in)
            FIVE_C: next_state <= Ninetyfive;
            TEN_C: next_state <= Onehundred;
            TWENTYFIVE_C: next_state <= Onehundredfifteen;
            HALFDOLLAR_C: next_state <= Onehundredforty;
            DOLLAR_C: next_state <= Onehundredninety;
            default: next_state <= Wait;
            endcase
   Ninetyfive: case(coin_in)
            FIVE_C: next_state <= Onehundred;
            TEN_C: next_state <= Onehundredfive;
            TWENTYFIVE_C: next_state <= Onehundredtwenty;
            HALFDOLLAR_C: next_state <= Onehundredfortyfive;
            DOLLAR_C: next_state <= Onehundredninetyfive;
            default: next_state <= Wait;
            endcase
   Onehundred: case(coin_in)
            NO_C: next_state <= Onehundred;
            FIVE_C: next_state <= Onehundredfive;
            TEN_C: next_state <= Onehundredten;
            TWENTYFIVE_C: next_state <= Onehundredtwentyfive;
            HALFDOLLAR_C: next_state <= Onehundredfifty;
            DOLLAR_C: next_state <= Twohundred;
            default: next_state <= Wait;
            endcase
    default: next_state <= 6'bxxxxxx; // if current_state is neither cases above, set to default
         
    endcase
end

always @(posedge clk, posedge rst) //sequential circuit to update logic behind State Machine
    begin
    if (rst == 1) //reset enabled
        begin
            current_state <= Wait; 
            c_return <= 6'b000000;
            soda <= 0;
            waterbottle <= 0;
        end
    else
        begin
            current_state <= next_state; //update current state from next state
        end
    end

always@(*) //combinational logic, determines 
begin   
    if(current_state >= Fifty && water_en == 1 && soda_en == 0)// This checks when the current_state is at least fifty cents and the water enable is on and soda enable is off, indicating the user wants water, not soda 
        begin
            if(current_state == Fifty) // this will check every state at fifty and so on. It will also determine change based on the current state.
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 end
             if(current_state == Fiftyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Five; //c_return is change 
                 end
             if(current_state == Sixty)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Ten;
                 end
             if(current_state == Sixtyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Fifteen;
                 end
             if(current_state == Seventy)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Twenty;
                 end
             if(current_state == Seventyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Twentyfive;
                 end
             if(current_state == Eighty)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Thirty;
                 end
             if(current_state == Eightyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Thirtyfive;
                 end
             if(current_state == Ninety)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Forty;
                 end
             if(current_state == Ninetyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Fortyfive;
                 end
             if(current_state == Onehundred)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Fifty;
                 end
             if(current_state == Onehundredfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Fiftyfive;
                 end
             if(current_state == Onehundredten)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Sixty;
                 end
            if(current_state == Onehundredfifteen)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Sixtyfive;
                 end
            if(current_state == Onehundredtwenty)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Seventy;
                 end
            if(current_state == Onehundredtwentyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Seventyfive;
                 end
            if(current_state == Onehundredthirty)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Eighty;
                 end
            if(current_state == Onehundredthirtyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Eightyfive;
                 end
            if(current_state == Onehundredforty)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Ninety;
                 end
            if(current_state == Onehundredfortyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Ninetyfive;
                 end
            if(current_state == Onehundredfifty)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundred;
                 end
            if(current_state == Onehundredfiftyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredfive;
                 end
            if(current_state == Onehundredsixty)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredten;
                 end
            if(current_state == Onehundredsixtyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredfifteen;
                 end
            if(current_state == Onehundredseventy)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredtwenty;
                 end
            if(current_state == Onehundredseventyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredtwentyfive;
                 end
            if(current_state == Onehundredeighty)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredthirty;
                 end
            if(current_state == Onehundredeightyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredthirtyfive;
                 end
            if(current_state == Onehundredninety)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredforty;
                 end
            if(current_state == Onehundredninetyfive)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredfortyfive;
                 end
            if(current_state == Twohundred)
                 begin
                 waterbottle = 1; //50 cent water will dispense
                 c_return = Onehundredfifty;
                 end
            
        end
     
     
    if(current_state >= Onehundred && soda_en == 1 && water_en == 0)
        begin
             if(current_state == Onehundred)
                 begin
                 soda = 1; //50 cent soda will dispense
                 end
             if(current_state == Onehundredfive)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Five;
                 end
             if(current_state == Onehundredten)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Ten;
                 end
            if(current_state == Onehundredfifteen)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Fifteen;
                 end
            if(current_state == Onehundredtwenty)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Twenty;
                 end
            if(current_state == Onehundredtwentyfive)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Twentyfive;
                 end
            if(current_state == Onehundredthirty)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Thirty;
                 end
            if(current_state == Onehundredthirtyfive)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Thirtyfive;
                 end
            if(current_state == Onehundredforty)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Forty;
                 end
            if(current_state == Onehundredfortyfive)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Fortyfive;
                 end
            if(current_state == Onehundredfifty)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Fifty;
                 end
            if(current_state == Onehundredfiftyfive)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Fiftyfive;
                 end
            if(current_state == Onehundredsixty)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Sixty;
                 end
            if(current_state == Onehundredsixtyfive)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Sixtyfive;
                 end
            if(current_state == Onehundredseventy)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Seventy;
                 end
            if(current_state == Onehundredseventyfive)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Seventyfive;
                 end
            if(current_state == Onehundredeighty)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Eighty;
                 end
            if(current_state == Onehundredeightyfive)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Eightyfive;
                 end
            if(current_state == Onehundredninety)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Ninety;
                 end
            if(current_state == Onehundredninetyfive)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Ninetyfive;
                 end
            if(current_state == Twohundred)
                 begin
                 soda = 1; //50 cent soda will dispense
                 c_return = Onehundred;
                 end
            
     end  
end       
endmodule
