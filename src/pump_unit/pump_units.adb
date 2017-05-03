with Pumps;
with General_IO;
use all type Pumps.Pump_States;

package body Pump_Units with SPARK_Mode => On is

   procedure Fill_Tank(this : in out Pump_Unit_Type; tank_to_fill : in out Tank.Tank_Type; successful : out Boolean) is
      pump : Pumps.Pump_Type := this.pumps(tank_to_fill.Get_Fuel_Type);
      reserve : Reserves.Reserve_Type := this.reserves(tank_to_fill.Get_Fuel_Type);
   begin

      if pump.Reserve_State /= reserve.Get_Sensor_State then
         if reserve.Get_Sensor_State = NotEmpty then
            pump.Set_Reserve_Sensor(NotEmpty);
         end if;
      end if;

      -- The pump must be in its base state, the reserve must be not empty, the tank must not be full
      if pump.State = Base And reserve.Get_Sensor_State = NotEmpty then

         -- Ready pump for pumping
         pump.Lift_Nozzle;

         -- Transition to the pumping state
         pump.Start_Pumping;

         Fill_Tank_Loop:
         loop
            -- Stop filling tank if tank is full
            exit Fill_Tank_Loop when tank_to_fill.Is_Tank_Full;

            -- Stop filling tank if reserve is empty
            exit Fill_Tank_Loop when reserve.Get_Sensor_State = Empty;

            General_IO.Print_Pumping;

            --Tak 1ml of fule and transfer to tank
            reserve.Take_Fuel;

            -- Add the fule to the tank
            tank_to_fill.Add_Fuel_To_Tank;
         end loop Fill_Tank_Loop;

         pragma Assert(reserve.Get_Sensor_State = Empty Or tank_to_fill.Is_Tank_Full);

         -- If the reserve transitions to empty tell the pump
         if reserve.Get_Sensor_State = Empty then
            pump.Set_Reserve_Sensor(Empty);
         end if;

         -- If the tank has told us it is full, let the pump know
         if tank_to_fill.Is_Tank_Full then
            pump.Tank_Full_Event;
         end if;

         -- If the pump is still pumping (i.e the tank is not full) stop the pump
         if pump.State = Pumping then
            pump.Stop_Pumping;
         end if;

         -- Cleanup
         pump.Replace_Nozzle;
         pump.Pay;

         -- Make sure we propogate the new states of the pump and reserve
         this.pumps(tank_to_fill.Get_Fuel_Type) := pump;
         this.reserves(tank_to_fill.Get_Fuel_Type) := reserve;

         -- Successful result
         successful := true;

         pragma Assert(pump.Reserve_State = reserve.Get_Sensor_State);
      else
         successful := false;
      end if;

   end Fill_Tank;

   function Make_Pump_Unit return Pump_Unit_Type is (Pump_Unit_Type'
                                                       (
                                                                     pumps    => (Pumps.Make_Pump,
                                                                                  Pumps.Make_Pump,
                                                                                  Pumps.Make_Pump),
                                                                     reserves => (Reserves.Make_Reserve(30, Petrol95, 15),
                                                                                  Reserves.Make_Reserve(30, Petrol98, 15),
                                                                                  Reserves.Make_Reserve(30, Diesel, 15))
                                                       )
                                                    );
end Pump_Units;
