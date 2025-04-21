module async_fifo(clk_w,clk_r,rst,wr_en,wdata,full,overflow,rd_en,rdata,empty,underflow);

parameter WIDTH=16;
parameter DEPTH=16;

input clk_w,clk_r,rst,wr_en,rd_en;
input [WIDTH-1:0]wdata;
output reg full,empty,underflow,overflow;
output reg [WIDTH-1:0]rdata;

reg [WIDTH-1:0]mem[DEPTH-1:0];

reg [3:0] wptr,rptr;
reg [3:0] wptr_g,rptr_g;
reg wr_toggle,rd_toggle;

reg [3:0] wptr_rd_clk,rptr_wr_clk;
reg rd_toggle_wr_clk,wr_toggle_rd_clk;
integer i;
//writing
always @(posedge clk_w)begin
if(rst==1)begin
	//full=0;
	//empty=1;
	underflow=0;
	overflow=0;
	rdata=0;
	wr_toggle=0;
	rd_toggle=0;
	wptr=0;
	rptr=0;
	wptr_rd_clk=0;
	rptr_wr_clk=0;
	rd_toggle_wr_clk=0;
	wr_toggle_rd_clk=0;
	rptr_g=0;
	wptr_g=0;
	for(i=0;i<DEPTH;i=i+1) begin
		mem[i]=0;
	end
end
else begin
	if(wr_en==1)begin
		if(full==0)begin
			mem[wptr]=wdata;
			if(wptr==DEPTH-1) wr_toggle=~wr_toggle;
			wptr=wptr+1;
			wptr_g=b2g(wptr);
		end
		else begin
			overflow=1;
		end
	end
end
end

//reading
always @(posedge clk_r)begin
if(rst==0)begin
	if(rd_en==1)begin
		if(empty==0) begin
			rdata=mem[rptr];
			if(rptr==DEPTH-1) rd_toggle=~rd_toggle;
			rptr=rptr+1;
			rptr_g=b2g(rptr);
		end
		else begin 
			underflow=1;
		end
	end
end
end

always @(posedge clk_r) begin
	wptr_rd_clk <= wptr_g;
	wr_toggle_rd_clk <= wr_toggle;
end

always @(posedge clk_w) begin
	rptr_wr_clk <= rptr_g;
	rd_toggle_wr_clk <= rd_toggle;
end

assign full=(wptr_g==rptr_wr_clk && wr_toggle != rd_toggle_wr_clk) ? 1'b1 : 1'b0;
assign empty=(wptr_rd_clk==rptr_g && wr_toggle_rd_clk == rd_toggle) ? 1'b1 : 1'b0;

function reg [3:0] b2g(input reg[3:0] a);
begin
	b2g[3]=a[3];
	b2g[2]=a[3]^a[2];
	b2g[1]=a[2]^a[1];
	b2g[0]=a[1]^a[0];
end
endfunction


endmodule
