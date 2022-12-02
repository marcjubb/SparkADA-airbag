pragma SPARK_Mode (On);

with AS_IO_Wrapper;  use AS_IO_Wrapper; 


package body Airbag_System is
   
   
   procedure Read_Acceleration is
      V0, V1, T: Integer;
      
   begin
      AS_Put_Line("Please type in velocity0 in metres/hour");
      loop
	 AS_Get(V0,"Please type in an integer");
	 exit when (V0 >-150000) and (V0 < 150000);
	 AS_Put("Please type in a value between -150000 and ");
	 AS_Put(Integer(Maximum_Velocity_Possible));
	 AS_Put_Line("");
      end loop;
      Status_System.Initial_Velocity_Measured := Velocity_Range(V0);
      AS_Put_Line("Please type in velocity1 in metres/hour");
      loop
	 AS_Get(V1,"Please type in an integer");
	 exit when (V1 >-150000) and (V1 < 150000);
	 AS_Put("Please type in a value between 150000 and ");
	 AS_Put(Integer(Maximum_Velocity_Possible));
	 AS_Put_Line("");
      end loop;
      Status_System.Final_Velocity_Measured := Velocity_Range(V1);
      AS_Put_Line("Please type in time of velocity change");
      loop
	 AS_Get(T,"Please type in an integer");
	 exit when (T > 0) and (T <= Maximum_Time_Possible);
	 AS_Put("Please type in a value between 0 and ");
	 AS_Put(Integer(Maximum_Time_Possible));
	 AS_Put_Line("");
      end loop;
      Status_System.Time_Difference_Measured := Time_Range(T);
      Status_System.Acceleration_Measured := Acceleration_Range(getGForce(V0,V1,T));
   end Read_Acceleration;
   
   
   
   function Status_Airbag_System_To_String (Status_Airbag_System  : Status_Airbag_System_Type) return String is
      begin
	 if (Status_Airbag_System = Activated) 
	 then return "Activated";
	 else return "Not_Activated";
	 end if;
      end Status_Airbag_System_To_String;
	
   
   
   procedure Print_Status is
   begin
      AS_Put_Line("");
      AS_Put("Acceleration = ");
      AS_Put(Integer(Status_System.Acceleration_Measured));
      AS_Put_Line("");
      AS_Put("Airbag_System = ");
      AS_Put_Line(Status_Airbag_System_To_String(Status_System.Status_Airbag_System));
   end Print_Status;
   
   
   procedure Monitor_Airbag_System  is
   begin
      if Integer(Status_System.Acceleration_Measured) < Critical_Acceleration 
      then Status_System.Status_Airbag_System := Activated;
      else Status_System.Status_Airbag_System := Not_Activated;
      end if;
   end Monitor_Airbag_System;
   
   
   procedure Init is
   begin
      AS_Init_Standard_Input; 
      AS_Init_Standard_Output;
      Status_System := (                       
                        Initial_Velocity_Measured =>0,
                        Final_Velocity_Measured=>0,
                          Time_Difference_Measured => 0,
                        Acceleration_Measured  => 0,
			Status_Airbag_System => Not_Activated);
   end Init;
   
   
      
end Airbag_System;
	

      
