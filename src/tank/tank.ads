with Shared_Types;

package Tank with SPARK_Mode => On is
   type Tank_Type is tagged private;

   function Make_Tank(size : Shared_Types.Millilitre_Type; fuel : Shared_Types.Fuel_Type; current_fill : Shared_Types.Millilitre_Type) return Tank_Type with
     Pre'Class => size >= current_fill,
       Post'Class => Make_Tank'Result.Get_Tank_Current_Fill = current_fill and Make_Tank'Result.Get_Tank_Size = size;

   function Get_Fuel_Type(this : in Tank_Type) return Shared_Types.Fuel_Type;

   function Get_Tank_Size(this : in Tank_Type) return Shared_Types.Millilitre_Type with Ghost;
   function Get_Tank_Current_Fill(this : in Tank_Type) return Shared_Types.Millilitre_Type with Ghost;

   -- Adds 1ml of fuel to the tank
   procedure Add_Fuel_To_Tank(this : in out Tank_Type) with
     Pre'Class => this.Get_Tank_Size - this.Get_Tank_Current_Fill > 0,
     Post'Class => this.Get_Tank_Size = this'Old.Get_Tank_Size
       and this.Get_Tank_Current_Fill - this'Old.Get_Tank_Current_Fill = 1;

   function Is_Tank_Full(this : in Tank_Type) return Boolean with
     Post'Class => (Is_Tank_Full'Result and this.Get_Tank_Current_Fill = this.Get_Tank_Size) or (not Is_Tank_Full'Result and this.Get_Tank_Current_Fill < this.Get_Tank_Size);

private
   type Tank_Type is tagged record
      Fuel : Shared_Types.Fuel_Type;
      Size : Shared_Types.Millilitre_Type;
      Current_Fill : Shared_Types.Millilitre_Type;
   end record with Predicate => Size >= Current_Fill;

   function Get_Fuel_Type(this : Tank_Type) return Shared_Types.Fuel_Type is (this.Fuel);
   function Get_Tank_Size(this : Tank_Type) return Shared_Types.Millilitre_Type is (this.Size);
   function Get_Tank_Current_Fill(this : Tank_Type) return Shared_Types.Millilitre_Type is (this.Current_Fill);

   function Is_Tank_Full(this : in Tank_Type) return Boolean is (this.Size = this.Current_Fill);

end Tank;
