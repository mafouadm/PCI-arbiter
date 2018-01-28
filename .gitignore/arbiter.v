
module arbiter (clk,REQ,GNT,GLOBAL_FRAME,GLOBAL_IRDY,GLOBAL_TRDY );
input clk;
input GLOBAL_IRDY,GLOBAL_TRDY,GLOBAL_FRAME;
input  [7:0] REQ;
output reg [7:0] GNT;

wire [7:0] data;
integer wrcount=0;
integer rdcount=0;
reg [7:0] fifo [0:31];
parameter a=8'b00000001, b=8'b00000010, c=8'b00000100, d=8'b00001000, e=8'b00010000, f=8'b00100000, g=8'b01000000, h=8'b10000000;
  reg[7:0] prevRequest; 
reg [7:0] dataIn;
 wire [7:0] dataOut ;
always @(posedge clk)begin
  if(REQ!==prevRequest)
begin

if((REQ[0]==0)&&(REQ[0]!=prevRequest[0]))
begin
fifo[wrcount]<=a;
wrcount=wrcount+1;
prevRequest[0]<=REQ[0];
end
 
 if((REQ[1]==0)&&(REQ[1]!=prevRequest[1]))
begin
fifo[wrcount]<=b;
wrcount=wrcount+1;
prevRequest[1]<=REQ[1];
	
end
 if((REQ[2]==0)&&(REQ[2]!=prevRequest[2]))
begin

fifo[wrcount]<=c;
wrcount=wrcount+1;
	prevRequest[2]<=REQ[2];
end
 if((REQ[3]==0)&&(REQ[3]!=prevRequest[3]))
begin
fifo[wrcount]<=d;
wrcount=wrcount+1;
prevRequest[3]<=REQ[3];
	
end
 if((REQ[4]==0)&&(REQ[4]!=prevRequest[4]))
begin
fifo[wrcount]<=e;
wrcount=wrcount+1;
prevRequest[4]<=REQ[4];
	
end
 else if((REQ[5]==0)&&(REQ[5]!=prevRequest[5]))
begin
fifo[wrcount]<=f;
wrcount=wrcount+1;
prevRequest[5]<=REQ[5];
	
end
 else if((REQ[6]==0)&&(REQ[6]!=prevRequest[6]))
begin
fifo[wrcount]<=g;
wrcount=wrcount+1;
prevRequest[6]<=REQ[6];
	
end
 else if((REQ[7]==0)&&(REQ[7]!=prevRequest[7]))
begin
fifo[wrcount]<=h;
wrcount=wrcount+1;
prevRequest[7]<=REQ[7];
	
end
else
prevRequest<=REQ;
end

else 
begin

if(fifo[rdcount]==a)
begin
if(GLOBAL_FRAME)begin
GNT[0]<=0;
GNT[1]<=1;
GNT[2]<=1;
GNT[3]<=1;
GNT[4]<=1;
GNT[5]<=1;
GNT[6]<=1;
GNT[7]<=1;
rdcount=rdcount+1;
end
end
else if(fifo[rdcount]==b)
begin
 if(GLOBAL_FRAME)begin
GNT[1]<=0;

GNT[0]<=1;
GNT[2]<=1;
GNT[3]<=1;
GNT[4]<=1;
GNT[5]<=1;
GNT[6]<=1;
GNT[7]<=1;
rdcount=rdcount+1;
end
end
else if(fifo[rdcount]==c)
begin
 if(GLOBAL_FRAME)begin
GNT[2]<=0;
GNT[1]<=1;

GNT[0]<=1;

GNT[3]<=1;
GNT[4]<=1;
GNT[5]<=1;
GNT[6]<=1;
GNT[7]<=1;
rdcount=rdcount+1;
end
end

else if(fifo[rdcount]==d)
begin
 if(GLOBAL_FRAME)begin
GNT[3]<=0;
GNT[1]<=1;

GNT[0]<=1;
GNT[2]<=1;
GNT[4]<=1;
GNT[5]<=1;
GNT[6]<=1;
GNT[7]<=1;
rdcount=rdcount+1;
end
end
 else if(fifo[rdcount]==e)
begin
if(GLOBAL_FRAME)begin
GNT[4]<=0;
GNT[1]<=1;

GNT[0]<=1;
GNT[2]<=1;
GNT[3]<=1;

GNT[5]<=1;
GNT[6]<=1;
GNT[7]<=1;
rdcount=rdcount+1;
end
end


 else if(fifo[rdcount]==f)
begin
if(GLOBAL_FRAME)begin
GNT[5]<=0;
GNT[1]<=1;

GNT[0]<=1;
GNT[2]<=1;
GNT[3]<=1;
GNT[4]<=1;
GNT[6]<=1;
GNT[7]<=1;
rdcount=rdcount+1;
end
end



else if(fifo[rdcount]==g)
begin
if(GLOBAL_FRAME)begin
GNT[6]<=0;
GNT[1]<=1;

GNT[0]<=1;
GNT[2]<=1;
GNT[3]<=1;
GNT[4]<=1;
GNT[5]<=1;
GNT[7]<=1;
rdcount=rdcount+1;
end
end


else if(fifo[rdcount]==h)
begin
if(GLOBAL_FRAME)begin
GNT[7]<=0;
GNT[1]<=1;
GNT[0]<=1;
GNT[2]<=1;
GNT[3]<=1;
GNT[4]<=1;
GNT[5]<=1;
GNT[6]<=1;
rdcount=rdcount+1;
end
end
else 
GNT<=8'b11111111;
end
end
initial 
  begin
	prevRequest='hff;
    GNT='hff;

  end




  
endmodule



