package Pumps with SPARK_Mode => On is
   type Pump_Type is tagged private;
   type Pump_States is (Base, Ready, StupidPerson, Pumping, Disabled, WaitingOffCradle, WaitingOnCradle);
   subtype Price_Type is Integer range 0..Integer'Last;


   function Make_Pump return Pump_Type;

   procedure Lift_Nozzle(this : in out Pump_Type) with
     Pre => this.State = Base Or this.State = WaitingOnCradle,
     Post => (this'Old.State = Base and this.State = Ready) Or (this'Old.State = WaitingOnCradle And this.State = WaitingOffCradle);

   procedure Replace_Nozzle(this : in out Pump_Type);
   procedure Start_Pumping(this : in out Pump_Type);
   procedure Stop_Pumping(this : in out Pump_Type);
   procedure Pay(this : in out Pump_Type);

   procedure Set_Full_Sensor(this : in out Pump_Type; is_full : Boolean);
   procedure Set_Reserve_Sensor(this : in out Pump_Type; is_full : Boolean);

   function State(this : in Pump_Type) return Pump_States;
private
   type Pump_Type is tagged record
      State : Pump_States := Base;
      Price : Price_Type := 1;
   end record;

   function State(this : in Pump_Type) return Pump_States is (this.State);

end Pumps;
