`include "async_fifo_gray.sv"
module tb;
parameter WIDTH=16;
parameter DEPTH=16;
reg clk_r,clk_w,rst,wr_en,rd_en;
reg [WIDTH-1:0]wdata;
wire full,empty,underflow,overflow;
wire [WIDTH-1:0]rdata;

reg [8*30:1] test_name;
integer i;

async_fifo #(.WIDTH(WIDTH),.DEPTH(DEPTH)) dut(.*);

initial begin
	clk_w=0;
	forever #5 clk_w=~clk_w;
end
initial begin
	clk_r=0;
	forever #7 clk_r=~clk_r;
end

initial begin
	$value$plusargs("test_name=%s",test_name);
	rst=1;
	wr_en=0;
	rd_en=0;
	wdata=0;
	repeat (2)@(posedge clk_w);
	rst=0;
	
	case(test_name)
		"FULL" : begin
			write_fifo(DEPTH);
		end
		"EMPTY" : begin
			write_fifo(DEPTH);
			read_fifo(DEPTH);
		end
		"OVERFLOW" : begin
			write_fifo(DEPTH+1);
		end
		"UNDERFLOW" : begin
			write_fifo(8);
			read_fifo(9);
		end
	endcase
	#50;
	$finish;
end

task write_fifo(input integer numbers);
begin
	for(i=0;i<numbers;i=i+1) begin
		@(posedge clk_w);
		wdata=$random();
		$display("Write : %0d",wdata);
		wr_en=1;
	end
	@(posedge clk_w);
	wr_en=0;
	wdata=0;
end
endtask

task read_fifo(input integer num);
begin
	for(i=0;i<num;i=i+1) begin
		@(posedge clk_r);
		rd_en=1;
		$display("Read value is %0d",rdata);
	end
	@(posedge clk_r);
	rd_en=0;
end
	$display("");
endtask

endmodule
