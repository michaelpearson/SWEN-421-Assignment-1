package body Tank with SPARK_Mode => On is

   function Make_Tank(size : Shared_Types.Millilitre_Type; fuel : Shared_Types.Fuel_Type; current_fill : Shared_Types.Millilitre_Type) return Tank_Type is
   begin
      return Tank_Type'(Fuel         => fuel,
                        Size         => size,
                        Current_Fill => current_fill);
   end Make_Tank;

   procedure Add_Fuel_To_Tank(this : in out Tank_Type; amount_to_add : in Shared_Types.Millilitre_Type; amount_added : out Shared_Types.Millilitre_Type; full_sensor_tripped : out Boolean) is
      space_in_tank : Shared_Types.Millilitre_Type := this.Size - this.Current_Fill;
   begin
      if(space_in_tank < amount_to_add) then
         amount_added := (this.Size - this.Current_Fill);
         full_sensor_tripped := true;
      else
         amount_added := amount_to_add;
         full_sensor_tripped := false;
      end if;

      this.Current_Fill := this.Current_Fill + amount_added;
   end Add_Fuel_To_Tank;

end Tank;
