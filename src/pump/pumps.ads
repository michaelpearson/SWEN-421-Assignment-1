package Pumps with SPARK_Mode => On is
   type Pump_Type is tagged private;
   type Pump_States is (Base, Ready, StupidPerson, Pumping, Disabled, WaitingOffCradle, WaitingOnCradle, Crash);
   type Reserve_Sensor_States is (Empty, NotEmpty);
   subtype Price_Type is Integer range 0..Integer'Last;

   function Make_Pump return Pump_Type with
     Post'Class => Make_Pump'Result.Reserve_State = NotEmpty;

   procedure Lift_Nozzle(this : in out Pump_Type) with
     Pre'Class => (this.State = Base Or this.State = WaitingOnCradle),
     Post'Class => (((this'Old.State = Base and this.State = Ready) Or (this'Old.State = WaitingOnCradle And this.State = WaitingOffCradle))
                    And Reserve_State_Preserved(this'Old, this));

   procedure Replace_Nozzle(this : in out Pump_Type) with
     Pre'Class => (this.State = Ready Or this.State = Disabled Or this.State = WaitingOffCradle),
     Post'Class => ((this'Old.State = Ready And this.State = Base)
                    Or (this'Old.State = Disabled And this.State = WaitingOnCradle)
                    Or (this'Old.State = WaitingOffCradle And this.State = WaitingOnCradle))
     And Reserve_State_Preserved(this'Old, this);


   procedure Start_Pumping(this : in out Pump_Type) with
     Pre'Class => (this.State = Ready Or this.State = WaitingOffCradle) And this.Reserve_State = NotEmpty,
     Post'Class => this.State = Pumping And Reserve_State_Preserved(this'Old, this),
     Depends => (this => this);

   procedure Stop_Pumping(this : in out Pump_Type) with
     Pre'Class => this.State = Pumping,
     Post'Class => this.State = WaitingOffCradle And Reserve_State_Preserved(this'Old, this);

   procedure Pay(this : in out Pump_Type) with
     Pre'Class => this.State = WaitingOnCradle,
     Post'Class => this.State = Base And Reserve_State_Preserved(this'Old, this);

   procedure Tank_Full_Event(this : in out Pump_Type) with
     Pre'Class => (this.State = WaitingOffCradle Or this.State = Pumping Or this.State = Disabled),
     Post'Class => (this.State = Disabled) And Reserve_State_Preserved(this'Old, this);

   procedure Set_Reserve_Sensor(pump : in out Pump_Type; state : Reserve_Sensor_States) with
     Pre'Class => state = NotEmpty Or (state = Empty And (pump.State = Pumping Or pump.State = Disabled)),
     Post'Class => ((state = NotEmpty And State_Preserved(pump'Old, pump)) Or (state = Empty And (pump.State = Disabled))) And pump.Reserve_State = state;

   function State(this : in Pump_Type) return Pump_States with
     Post'Class => State'Result = this.State;

   function Reserve_State(this : in Pump_Type) return Reserve_Sensor_States with
     Post'Class => Reserve_State'Result = this.Reserve_State;

   function Reserve_State_Preserved(a : in Pump_Type; b : in Pump_Type) return Boolean is (a.Reserve_State = b.Reserve_State) with Ghost;
   function State_Preserved(a : in Pump_Type; b : in Pump_Type) return Boolean is (a.State = b.State) with Ghost;

private
   type Pump_Type is tagged record
      State : Pump_States := Base;
      Price : Price_Type := 1;
      Reserve_State : Reserve_Sensor_States := NotEmpty;
   end record with Dynamic_Predicate => Pump_Type.State /= Crash;

   function State(this : in Pump_Type) return Pump_States is (this.State);
   function Reserve_State(this : in Pump_Type) return Reserve_Sensor_States is (this.Reserve_State);
end Pumps;
