package body Pumps with SPARK_Mode => On is

   function Make_Pump return Pump_Type is
      pump : Pump_Type;
   begin
      return pump;
   end Make_Pump;


   procedure Lift_Nozzle(this : in out Pump_Type) is
   begin
      if this.State = Base then
         this.State := Ready;
      else
         this.State := WaitingOffCradle;
      end if;
   end Lift_Nozzle;


   procedure Replace_Nozzle(this : in out Pump_Type) is
   begin
      null;
   end Replace_Nozzle;

   procedure Start_Pumping(this : in out Pump_Type) is
   begin
      null;
   end Start_Pumping;

   procedure Stop_Pumping(this : in out Pump_Type) is
   begin
      null;
   end Stop_Pumping;

   procedure Pay(this : in out Pump_Type) is
   begin
      null;
   end Pay;

   procedure Set_Full_Sensor(this : in out Pump_Type; is_full : Boolean) is
   begin
      null;
   end Set_Full_Sensor;

   procedure Set_Reserve_Sensor(this : in out Pump_Type; is_full : Boolean) is
   begin
      null;
   end Set_Reserve_Sensor;

end Pumps;
