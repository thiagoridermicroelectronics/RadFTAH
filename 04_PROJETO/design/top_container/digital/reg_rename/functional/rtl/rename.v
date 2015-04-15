‘timescale 1ns/ 10ps

module rename(clock,reset,v1, ArDest1, ArSrc1a, ArSrc1b,v2, ArDest2, ArSrc2a, 
              ArSrc2b,cmtcnt, si, PrDest1, PrSrc1a, PrSrc1b,PrDest2, PrSrc2a, 
              PrSrc2b, StallOut);

  input clock,reset,v1,v2,si;
  input  [2:0] ArDest1,ArSrc1a,ArSrc1b, ArDest2,ArSrc2a,ArSrc2b;
  input [1:0] cmtcnt;
  output reg [3:0] PrDest1, PrSrc1a, PrSrc1b , PrDest2, PrSrc2a, PrSrc2b;
  output  reg StallOut;
  integer reg_to_ren;
  reg [1:10] bitmap;
  reg [1:0] numf;
  reg [3:0] i;
  reg valid1,temp_valid1,valid2,temp_valid2,StallIn,te
  mp_StallIn;
  reg [1:0] CmtCount,temp_CmtCount;
  reg intClk;

  //cam table
  reg [0:7] Cam_tab [1:10];
  reg [0:7] temp_Cam_tab;

  //ROB
  reg [0:15] Rob [1:10];
  reg [0:15]temp_Rob;

  //head pointer;
  integer head;

  //function to calculate the number of free registers
  function [1:0]  num_free;
  begin
    num_free = 2’b00;
    for(i=1;i<=10;i=i+1)
    begin
      if(bitmap[i]==1’b1)
      begin
        num_free = num_free + 1;
      end
    end
  end
  endfunction

  always @(posedge clock)
  begin
    if(reset==1)
    begin
      StallIn<=0;
      valid1<=0;
      valid2<=0;
      CmtCount<=0;
      intClk <=0;
    end
    else begin
      StallIn <= si;
      valid2 <= v2;
      CmtCount <= cmtcnt;
      valid1 <= v1;
      intClk <= !intClk;
    end
  end

  //Initializations
  always @( intClk )
  begin
    if(reset==1)
    begin
      bitmap = 10’b0000000111;
      Cam_tab[1] = 8’b00100011;
      Cam_tab[2] = 8’b01000101;
      Cam_tab[3] = 8’b01100111;
      Cam_tab[4] = 8’b10001001;
      Cam_tab[5] = 8’b10101011;
      Cam_tab[6] = 8’b11001101;
      Cam_tab[7] = 8’b11101111;
      Cam_tab[8] = 8’b00010000;
      Cam_tab[9] = 8’b00010010;
      Cam_tab[10] = 8’b00010100;
      Rob[1] = 16’b0000000000000000;
      Rob[2] = 16’b0000000000000000;
      Rob[3] = 16’b0000000000000000;
      Rob[4] = 16’b0000000000000000;
      Rob[5] = 16’b0000000000000000;
      Rob[6] = 16’b0000000000000000;
      Rob[7] = 16’b0000000000000000;
      Rob[8] = 16’b0000000000000000;
      Rob[9] = 16’b0000000000000000;
      Rob[10] = 16’b0000000000000000;
      StallOut = 0;
      head = -1;
    end
    else if(reset==0 && StallIn!=1’b1)
    begin
      //check if instructions are valid
      //calculate the number of registers to rename.
      reg_to_ren = 0;
      if(valid1==1 && ArDest1 != 3’b000)
      begin
        reg_to_ren = reg_to_ren + 1;
      end
      if(valid2==1 && ArDest2!=3’b000 )
      begin
        reg_to_ren = reg_to_ren + 1;
      end
      numf = num_free();
      if(numf<reg_to_ren)
      begin
        StallOut = 1’b1;
      end
      else
      begin
        StallOut = 0;
        //to rename or not to rename source
        if(ArSrc1a==3’b000 || valid1==0)
        begin
          PrSrc1a = 4’b0000;
        end
        if(ArSrc1b==3’b000 || valid1==0)
        begin
          PrSrc1b = 4’b0000;
        end
        // rename source
        if(valid1==1)
        begin
          for(i=1;i<=10;i=i+1)
          begin
            temp_Cam_tab = Cam_tab[i];
            if((ArSrc1a !=0 ) &&(ArSrc1a==temp_Cam_tab[0:2]) && temp_Cam_tab[7]==1’b1 )
            begin
              PrSrc1a= temp_Cam_tab[3:6];
            end
            if((ArSrc1b !=0) &&(ArSrc1b==temp_Cam_tab[0:2]) && temp_Cam_tab[7]==1’b1 )
            begin
              PrSrc1b = temp_Cam_tab[3:6];
            end
          end
        end
        // to rename or not to rename dest
        if(ArDest1==3’b000 || valid1 ==0)
        begin
          PrDest1 = 4’b0000;
        end
      else  // rename dest
      begin   // invalidate the previous mapping
        for(i=1;i<=10;i=i+1)
        begin
          temp_Cam_tab = Cam_tab[i];
          if((ArDest1==temp_Cam_tab[0:2]) && temp_Cam_tab[7]==1’b1 )
          begin
            Cam_tab[i] ={temp_Cam_tab[0:6], 1’b0};
          end
        end
        for(i=1;(i<=10) &&(bitmap[i]==0);i=i+1)
        begin
        end
        temp_Cam_tab = Cam_tab[i];
        // set logical reg and validate
        Cam_tab[i] = {ArDest1,temp_Cam_tab[3:6],1’b1};
        PrDest1 = temp_Cam_tab[3:6]; // assign phy reg
        bitmap[i] = 0;
      end
      //enter mr rob.

      if(valid1==1)
      begin
        for(i =1;i<=10;i=i+1)
        begin
          temp_Cam_tab = Cam_tab[i];
          temp_Rob = Rob[i];
          Rob[i] = Rob[i]>>1;
          Rob[i] = {temp_Cam_tab[7],temp_Rob[0:14]};
        end
        head = head + 1;
      end
      // done with the first instruction.
      // now the second:
      //to rename or not to rename source
      if(ArSrc2a==3’b000 || valid2==0)
      begin
        PrSrc2a = 4’b0000;
      end
      if(ArSrc2b==3’b000 || valid2==0)
      begin
        PrSrc2b = 4’b0000;
      end
      // rename source
      if(valid2==1)
      begin
        for(i=1;i<=10;i=i+1)
        begin
          temp_Cam_tab = Cam_tab[i];
          if((ArSrc2a!=0) && (ArSrc2a==temp_Cam_tab[0:2]) && temp_Cam_tab[7]==1’b1 )
          begin
            PrSrc2a = temp_Cam_tab[3:6];
          end
          if((ArSrc2b!=0) && (ArSrc2b==temp_Cam_tab[0:2]) && temp_Cam_tab[7]==1’b1 )
          begin
            PrSrc2b = temp_Cam_tab[3:6];
          end
        end
      end
      // to rename or not to rename dest
      if(ArDest2==3’b000 || valid2==0)
      begin
        PrDest2 = 4’b0000;
      end
      else  // rename dest
      begin   // invalidate the previous mapping
        for(i=1;i<=10;i=i+1)
        begin
          temp_Cam_tab = Cam_tab[i];
          if((ArDest1==temp_Cam_tab[0:2]) && temp_Cam_tab[7]==1’b1 )
          begin
            Cam_tab[i] ={temp_Cam_tab[0:6], 1’b0};
          end
        end
        for(i=1;(i<=10) && (bitmap[i]==0);i=i+1)
        begin
        end
        temp_Cam_tab = Cam_tab[i];
        //set logical reg and validate
        Cam_tab[i] = {ArDest2,temp_Cam_tab[3:6],1’b1};
        PrDest2 = temp_Cam_tab[3:6]; // assign phy reg
        bitmap[i] = 0;
      end
      //enter mr rob.
      if(valid2==1)
      begin
        for(i =1;i<=10;i=i+1)
        begin
          temp_Cam_tab = Cam_tab[i];
          temp_Rob = Rob[i];
          Rob[i] = Rob[i]>>1;
          Rob[i] = {temp_Cam_tab[7],temp_Rob[0:14]};
        end
        head = head + 1;
      end
      //do something with the head if greater than 15
      //done with the second instruction
    end
    //do commit here:
    //check the commit count
    if(CmtCount == 2’b01)
    begin
      head = head -1;
      if(head==-1)
      begin
        for(i=1;i<=10;i=i+1)
        begin
          temp_Rob = Rob[i];
          bitmap[i] = bitmap[i] | (!temp_Rob[0]);
        end
      end
      else
      begin
        for(i=1;i<=10;i=i+1)
          begin
            temp_Rob = Rob[i];
            if((temp_Rob[head]==1’b0) &&(temp_Rob[head+1]==1’b1))
            begin
              bitmap[i] = 1;
            end
          end
        end
      end
      else if(CmtCount == 2’b10)
      begin
        head = head -1;
        if(head==-1)
        begin
          for(i=1;i<=10;i=i+1)
          begin
            temp_Rob = Rob[i];
            bitmap[i] = bitmap[i] | (!temp_Rob[0]);
          end
        end
        else
        begin
          for(i=1;i<=10;i=i+1)
          begin
            temp_Rob = Rob[i];
            if((temp_Rob[head]==1’b0) &&(temp_Rob[head+1]==1’b1))
            begin
              bitmap[i] = 1;
            end
          end
        end
        head = head -1;
        if(head==-1)
        begin
          for(i=1;i<=10;i=i+1)
          begin
            temp_Rob = Rob[i];
            bitmap[i] = bitmap[i] | (!temp_Rob[0]);
          end
        end
      else
      begin
        for(i=1;i<=10;i=i+1)
        begin
          temp_Rob = Rob[i];
          if((temp_Rob[head]==1’b0) &&(temp_Rob[head+1]==1’b1))
          begin
            bitmap[i] = 1;
          end
        end
      end
    end
  end //for else
end //for always
endmodule
