`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Fabricio Zuniga
// Final Project
// VLSI Design
// EE 4513
// Fall 2020
//////////////////////////////////////////////////////////////////////////////////

module Test();
reg clock, reset, wen, sen;
reg [2:0] coins;
wire sohda, water;
wire [5:0] change;
wire [5:0] state;

localparam  NO_COIN = 3'b000, NICKEL  = 3'b001, DIME = 3'b010, 
            QUARTER = 3'b011, HALFDOLLAR = 3'b100,
            DOLLAR = 3'b101;
            
VendingMachine test(clock, reset, wen, sen, coins, sohda, water, change, state); 

initial
begin
    clock = 0;
    reset = 0;
    wen = 0;
    sen = 0;
end

always 
#10 clock =!clock;

initial 
begin
coins = HALFDOLLAR; //50 cents
wen = 1; //dispense water, no change
#25
reset = 1; //reset
coins = NO_COIN;
wen = 0;
#25
reset = 0;

coins = DOLLAR; //100 cents or 1 dollar
sen = 1; //dispense soda, no change
#25
reset = 1; // reset
coins = NO_COIN;
sen = 0;
#25
reset = 0; 

coins = DOLLAR; //100 cents
#25
coins = QUARTER; // 25 cents 
wen = 1; //dispense water, change is 75 cents
#25
reset = 1;
coins = NO_COIN;
wen = 0;
#25
reset = 0;

coins = DOLLAR;
#25
coins = NO_COIN;
#25
coins = DOLLAR; // 2 dollars, dispense soda, change is 1 dollar
sen = 1;
#25
reset = 1;
coins = NO_COIN;
sen = 0;
#25
reset = 0;


coins = NICKEL;
#25
coins = NO_COIN;
#25
coins = NICKEL;
sen = 1; //10 cents, should not dispense soda
#25
reset = 1;
coins = NO_COIN;
sen = 0;
#25
reset = 0;

coins = QUARTER;
#25
coins = NO_COIN;
#25
coins = QUARTER;
#25
coins = NO_COIN;
#25
coins = QUARTER;
#25
coins = NO_COIN;
#25
coins = QUARTER; // 1 dollar, soda dispensed, no change
sen = 1;
#25
reset = 1;
coins = NO_COIN;
sen = 0;
#25
reset = 0;

coins = DIME;
#25
coins = NO_COIN;
#25
coins = DIME;
#25
coins = NO_COIN;
#25
coins = DIME;
#25
coins = NO_COIN;
#25
coins = DIME;
#25
coins = NO_COIN;
#25
coins = DIME; //50 cents, water bottle dispense, no change
wen = 1;
#25
reset = 1;
coins = NO_COIN;
wen = 0;
#25
reset = 0;


end

endmodule
