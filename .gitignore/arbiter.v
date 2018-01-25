
module arbiter (clk,REQ,GNT,GLOBAL_FRAME,GLOBAL_IRDY,GLOBAL_TRDY );
input clk;
input GLOBAL_IRDY,GLOBAL_TRDY,GLOBAL_FRAME;
input  [7:0] REQ;
output reg [7:0] GNT;
wire [7:0] dataOut;
reg wr, rd;
reg [7:0] datain;
reg en , rst;
wire EMPTY , FULL;
parameter a=8'b00000001, b=8'b00000010, c=8'b00000100, d=8'b00001000, e=8'b00010000, f=8'b00100000, g=8'b01000000, h=8'b10000000;
  reg[7:0] prevRequest; 
always @(posedge clk)begin
  if(REQ!==prevRequest)
begin
prevRequest<=REQ;
if(REQ[0]==0)
begin
wr<=1;
rd<=0;
datain<=a;

	
end
 
 if(REQ[1]==0)
begin
wr<=1;
rd<=0;
datain<=b;
	
end
 if(REQ[2]==0)
begin
wr<=1;
rd<=0;
datain<=c;
	
end
 if(REQ[3]==0)
begin
wr<=1;
rd<=0;
datain<=d;
	
end
 if(REQ[4]==0)
begin
wr<=1;
rd<=0;
datain<=e;
	
end
 if(REQ[5]==0)
begin
wr<=1;
rd<=0;
datain<=f;
	
end
 if(REQ[6]==0)
begin
wr<=1;
rd<=0;
datain<=g;
	
end
 if(REQ[7]==0)
begin
wr<=1;
rd<=0;
datain<=h;
	
end
end
else 
begin

wr<=0;
rd<=1;
if(dataOut==a)
begin
if(GLOBAL_FRAME)
GNT<=11111110;
end

 if(dataOut==b)
begin
if(GLOBAL_FRAME)
GNT<=11111101;
end
 if(dataOut==c)
begin
if(GLOBAL_FRAME)
GNT<=11111011;
end

 if(dataOut==d)
begin
if(GLOBAL_FRAME)
GNT<=11110111;
end
 if(dataOut==e)
begin
if(GLOBAL_FRAME)
GNT<=11101111;
end


  if(dataOut==f)
begin
if(GLOBAL_FRAME)
GNT<=11011111;
end



 if(dataOut==g)
begin
if(GLOBAL_FRAME)
GNT<=10111111;
end


  if(dataOut==h)
begin
if(GLOBAL_FRAME)
GNT<=01111111;
end


end
end
initial 
  begin

    GNT='hff;
 datain  = 8'h0;

  rd  = 1'b0;

  wr  = 1'b0;

  en  = 1'b0;

  rst  = 1'b1;

  // Wait 100 ns for global reset to finish

  #10;        

  // Add stimulus here

  en  = 1'b1;

  rst  = 1'b1;
  end

FIFObuffer f1( clk,datain,rd,wr,1,dataOut,0,EMPTY,FULL);


  
endmodule



module FIFObuffer( Clk,dataIn,RD, WR,EN, dataOut, Rst,EMPTY,  FULL   ); 

input  Clk, RD,WR,  EN,Rst;

output  EMPTY, FULL;

input   [7:0]    dataIn;

output reg [7:0] dataOut; // internal registers 

reg [2:0]  Count = 0; 

reg [7:0] FIFO [0:7]; 

reg [2:0]  readCounter = 0,writeCounter = 0; 

assign EMPTY = (Count==0)? 1'b1:1'b0; 

assign FULL = (Count==8)? 1'b1:1'b0; 

always @ (posedge Clk) 

begin 

 if (EN==0); 

 else begin 

  if (Rst) begin 

   readCounter = 0; 

   writeCounter = 0; 

  end 

   else if (RD ==1'b1 && Count!=0 && WR==0) begin 

   dataOut  = FIFO[readCounter]; 

   readCounter = readCounter+1; 

  end 

  else if (WR==1'b1 && Count<8) begin
   FIFO[writeCounter]  = dataIn; 

   writeCounter  = writeCounter+1; 

  end 

  else; 

 end 

 if (writeCounter==8) 

  writeCounter=0; 

 else if (readCounter==8) 

  readCounter=0; 

 else;

 if (readCounter > writeCounter) begin 

  Count=readCounter-writeCounter; 

 end 

 else if (writeCounter > readCounter) 

  Count=writeCounter-readCounter; 

 else;

end 

endmodule
