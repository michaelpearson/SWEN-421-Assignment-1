with Pumps;
use all type Pumps.Pump_States;

package body Pump_Units with SPARK_Mode => On is

   procedure Fill_Tank(this : in out Pump_Unit_Type; tank_to_fill : in out Tank.Tank_Type; successful : out Boolean) is
      pump : Pumps.Pump_Type := this.pumps(tank_to_fill.Get_Fuel_Type);
      reserve : Reserves.Reserve_Type := this.reserves(tank_to_fill.Get_Fuel_Type);
      reserve_sensor_state : Pumps.Reserve_Sensor_States;
      fuel_taken_from_reserve : Shared_Types.Millilitre_Type;
      fuel_added_to_tank : Shared_Types.Millilitre_Type;
      tank_full : Boolean;
   begin
      if pump.State = Base And pump.Reserve_State = NotEmpty then

         pump.Lift_Nozzle;
         pump.Start_Pumping;

         reserve.Take_Fuel(tank_to_fill.Get_Tank_Size - tank_to_fill.Get_Tank_Size, fuel_taken_from_reserve, reserve_sensor_state);

         pump.Set_Reserve_Sensor(reserve_sensor_state);

         tank_to_fill.Add_Fuel_To_Tank(fuel_taken_from_reserve, fuel_added_to_tank, tank_full);

         pragma Assert(fuel_added_to_tank = fuel_taken_from_reserve);

         if tank_full then
            pump.Tank_Full_Event;
         end if;

         if pump.State = Pumping then
            pump.Stop_Pumping;
         end if;

         pump.Replace_Nozzle;
         pump.Pay;

         this.pumps(tank_to_fill.Get_Fuel_Type) := pump;
         this.reserves(tank_to_fill.Get_Fuel_Type) := reserve;

         successful := true;
      else
         successful := false;
      end if;

   end Fill_Tank;

   procedure Fill_Tank_To(this : Pump_Unit_Type; tank_to_fill : Tank.Tank_Type; amount : Shared_Types.Millilitre_Type) is
   begin
      null;
   end Fill_Tank_To;

   function Make_Pump_Unit return Pump_Unit_Type is (Pump_Unit_Type'
                                                       (
                                                                     pumps    => (Pumps.Make_Pump,
                                                                                  Pumps.Make_Pump,
                                                                                  Pumps.Make_Pump),
                                                                     reserves => (Reserves.Make_Reserve(1000 * 10, Petrol95, 1000 * 10),
                                                                                  Reserves.Make_Reserve(1000 * 10, Petrol98, 1000 * 10),
                                                                                  Reserves.Make_Reserve(1000 * 10, Diesel, 1000 * 10))
                                                       )
                                                    );
end Pump_Units;
