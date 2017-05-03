package body Tank with SPARK_Mode => On is

   function Make_Tank(size : Shared_Types.Millilitre_Type; fuel : Shared_Types.Fuel_Type; current_fill : Shared_Types.Millilitre_Type) return Tank_Type is
   begin
      return Tank_Type'(Fuel         => fuel,
                        Size         => size,
                        Current_Fill => current_fill);
   end Make_Tank;

   procedure Add_Fuel_To_Tank(this : in out Tank_Type) is
      space_in_tank : Shared_Types.Millilitre_Type := this.Size - this.Current_Fill;
   begin
      pragma Assert(space_in_tank > 0);

      if(space_in_tank > 0) then
         this.Current_Fill := this.Current_Fill + 1;
      end if;
   end Add_Fuel_To_Tank;

end Tank;
