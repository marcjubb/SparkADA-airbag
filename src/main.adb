pragma SPARK_Mode (On);

with Airbag_System; use Airbag_System;

procedure Main is
begin
   Init;
   loop
      pragma Loop_Invariant (Is_Safe (Status_System));
      Read_Acceleration;
      Monitor_Airbag_System;
      Print_Status;
   end loop;
end Main;
