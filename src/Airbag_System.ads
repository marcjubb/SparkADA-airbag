pragma SPARK_Mode (On);

with SPARK.Text_IO; use SPARK.Text_IO;

package Airbag_System is

   Maximum_Velocity_Possible     : constant Integer := 300_000;
   Maximum_Acceleration_Possible : constant Integer := 300_000;
   Maximum_Time_Possible         : constant Integer := 1_000;
   Critical_Acceleration         : constant Integer := -35_303;

   type Acceleration_Range is
     new Integer range -300_000 .. Maximum_Acceleration_Possible;

   type Velocity_Range is
     new Integer range -300_000 .. Maximum_Velocity_Possible;
   type Time_Range is new Integer range 0 .. Maximum_Time_Possible;

   type Status_Airbag_System_Type is (Activated, Not_Activated);

   type Status_System_Type is record
      Initial_Velocity_Measured : Velocity_Range;
      Final_Velocity_Measured   : Velocity_Range;
      Time_Difference_Measured  : Time_Range;
      Acceleration_Measured     : Acceleration_Range;
      Status_Airbag_System      : Status_Airbag_System_Type;
   end record;

   Status_System : Status_System_Type;

   procedure Read_Acceleration with
      Global  => (In_Out => (Standard_Output, Standard_Input, Status_System)),
      Depends => (Standard_Output => (Standard_Output, Standard_Input),
       Standard_Input => Standard_Input,
       Status_System  => (Status_System, Standard_Input));

   function Status_Airbag_System_To_String
     (Status_Airbag_System : Status_Airbag_System_Type) return String;

   procedure Print_Status with
      Global  => (In_Out => Standard_Output, Input => Status_System),
      Depends => (Standard_Output => (Standard_Output, Status_System));

   function Is_Safe (Status : Status_System_Type) return Boolean is
     (if Integer (Status.Acceleration_Measured) < Critical_Acceleration then
        Status.Status_Airbag_System = Activated
      else Status.Status_Airbag_System = Not_Activated);

   procedure Monitor_Airbag_System with
      Global  => (In_Out => Status_System),
      Depends => (Status_System => Status_System),
      Post    => Is_Safe (Status_System);

   procedure Init with
      Global  => (Output => (Standard_Output, Standard_Input, Status_System)),
      Depends => ((Standard_Output, Standard_Input, Status_System) => null),
      Post    => Is_Safe (Status_System);

   function getGForce (V0, V1, T : Integer) return Integer is
     ((V1 - V0) / (T)) with
   Pre => (T > 0 and V0 > -150000 and V0 < 150000 and V1 > -150000 and V1 < 150000);

end Airbag_System;
