with IO; use IO;

package body Pumps with SPARK_Mode => On is

   -- Create a new instance of a pump in its default state.
   -- The default state is the ready state with fuel in the reserve & the sensor not triggered
   function Make_Pump return Pump_Type is
      pump : Pump_Type;
   begin
      return pump;
   end Make_Pump;


   -- Called when the use lifts the nozzle of the pump.
   -- This causes the following transitions:
   -- - Base -> Ready
   -- - WaitingOnCradle -> WaitingOffCradle
   -- - Other -> Crash
   procedure Lift_Nozzle (this : in out Pump_Type) is
      Starting_State : Pump_States := this.State;
   begin
      if this.State = Base then
         this.State := Ready;
      elsif this.State = WaitingOnCradle then
         this.State := WaitingOffCradle;
      else
         this.State := Crash;
      end if;
      Print_Transition (Starting_State, this.State);
   end Lift_Nozzle;

   -- Called when the user puts the nozzle back onto the pump.
   -- This causes the following transitions:
   -- - Ready -> Base
   -- - Disabled -> Waiting On Cradle
   -- - Waiting Off Cradle -> Waiting On Cradle
   -- - Other -> Crash
   procedure Replace_Nozzle (this : in out Pump_Type) is
      Starting_State : Pump_States := this.State;
   begin
      if this.State = Ready then
         this.State := Base;
      elsif this.State = Disabled then
         this.State := WaitingOnCradle;
      elsif this.State = WaitingOffCradle then
         this.State := WaitingOnCradle;
      else
         this.State := Crash;
      end if;
      Print_Transition (Starting_State, this.State);
   end Replace_Nozzle;

   -- Called when the user beings pumping fuel.
   -- This causes the following transitions:
   -- - Ready -> Pumping
   -- - Waiting Off Cradle -> Pumping
   -- - Other -> Crash
   procedure Start_Pumping (this : in out Pump_Type) is
      Starting_State : Pump_States := this.State;
   begin
      if (this.State = Ready Or this.State = WaitingOffCradle) And this.Reserve_State = NotEmpty then
         this.State := Pumping;
      else
         this.State := Crash;
      end if;
      Print_Transition (Starting_State, this.State);
   end Start_Pumping;

   -- Called when the use chooses stops pumping fuel.
   -- Causes the following transitions:
   -- - Pumping -> WaitingOffCradle
   -- - Other -> Crash
   procedure Stop_Pumping (this : in out Pump_Type) is
      Starting_State : Pump_States := this.State;
   begin
      if this.State = Pumping then
         this.State := WaitingOffCradle;
      else
         this.State := Crash;
      end if;
      Print_Transition (Starting_State, this.State);
   end Stop_Pumping;

   -- Called when the user decides to pay for pumped fuel.
   -- Causes the following transitions:
   -- - WaitingOnCradle -> Base
   -- - Other -> Crash
   procedure Pay (this : in out Pump_Type) is
      Starting_State : Pump_States := this.State;
   begin
      if this.State = WaitingOnCradle then
         this.State := Base;
      else
         this.State := Crash;
      end if;
      Print_Transition (Starting_State, this.State);
   end Pay;

   -- Called when the nozzle reports that that the tank is full.
   -- Causes the following transitions:
   -- - WaitingOffCradle -> Disabled
   -- - Pumping -> Disabled
   -- - Disabled -> Disabled
   -- - Ready -> StupidPerson (Rational is that they took the nozzle off and put it straight into a full tank)
   -- - Other -> Crash
   procedure Tank_Full_Event (this : in out Pump_Type) is
      Starting_State : Pump_States := this.State;
   begin
      if this.State = WaitingOffCradle Or this.State = Pumping Or this.State = Disabled then
         this.State := Disabled;
      elsif this.State = Ready then
         this.State := StupidPerson;
      else
         this.State := Crash;
      end if;
      Print_Transition (Starting_State, this.State);
   end Tank_Full_Event;

   -- Called when the reserve sensor updates the system on it's status.
   -- Note there is a requirement that the system is updated as soon as the reserve is empty and
   -- no subsequent events are received.
   -- This causes the following transitions when the new status is full:
   -- - Pumping -> Disabled
   -- - Disabled -> Disabled
   -- - Other -> Crash
   procedure Set_Reserve_Sensor (pump : in out Pump_Type; state : Reserve_Sensor_States) is
      Starting_State : Pump_States := pump.State;
   begin
      if state = Empty then
         if pump.State = Pumping Or pump.State = Disabled then
            pump.State := Disabled;
         else
            pump.State := Crash;
         end if;
         Print_Transition (Starting_State, pump.State);
      end if;
   end Set_Reserve_Sensor;

end Pumps;
