`timescale 100ns/10ns
module RGB2G_tb;

  parameter row = 2048, col = 1153;
  integer   f;
  
  reg             clk, write, start;
  reg       [7:0] mem_in[row*col*3-1:0];
  reg signed[31:0]pixel1;
  reg signed[31:0]pixel2;
  
  wire[7:0]result;
  wire done;
  
  initial
  begin
    $readmemh("image.txt",mem_in);
    f = $fopen("grayimage.txt","w");
  end
  
  initial
  begin
    pixel1 = 0;
    pixel2 = 0;
    clk   = 0;
    start = 0;
    write = 0;
    #0.4 start = ~start;
    #0.2 write = ~write;
  end
  
  RGB2G rg(.data_0(mem_in[pixel2]), .data_1(mem_in[pixel2+1]), .data_2(mem_in[pixel2+2]),
                   .result, .done,
                   .pixel(pixel1), .clk);
  
  always 
  begin 
    #0.2 clk = ~clk; 
  end  
  
  always@(posedge clk)
  begin
    if(start)
      begin
        pixel1 = pixel1 + 1;
	pixel2 = pixel2 + 3;
      end
      
    if(write)
      begin
        $fwrite(f,"%x\n",result);
      end
      
    if(done)
      begin
        $fclose(f);
        write = 0;
      end
  end          
endmodule

