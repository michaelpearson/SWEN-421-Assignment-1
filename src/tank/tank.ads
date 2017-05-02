with Shared_Types;

package Tank with SPARK_Mode => On is
   type Tank_Type is tagged private;


   function Make_Tank(size : Shared_Types.Millilitre_Type; fuel : Shared_Types.Fuel_Type; current_fill : Shared_Types.Millilitre_Type) return Tank_Type with
     Pre'Class => size >= current_fill;

   function Get_Fuel_Type(this : in Tank_Type) return Shared_Types.Fuel_Type;
   function Get_Tank_Size(this : in Tank_Type) return Shared_Types.Millilitre_Type;
   function Get_Tank_Current_Fill(this : in Tank_Type) return Shared_Types.Millilitre_Type;

   procedure Add_Fuel_To_Tank(this : in out Tank_Type; amount_to_add : in Shared_Types.Millilitre_Type; amount_added : out Shared_Types.Millilitre_Type; full_sensor_tripped : out Boolean) with
     Pre'Class => this.Get_Tank_Size >= this.Get_Tank_Current_Fill;

private
   type Tank_Type is tagged record
      Fuel : Shared_Types.Fuel_Type;
      Size : Shared_Types.Millilitre_Type;
      Current_Fill : Shared_Types.Millilitre_Type;
   end record with Predicate => Size >= Current_Fill;

   function Get_Fuel_Type(this : Tank_Type) return Shared_Types.Fuel_Type is (this.Fuel);
   function Get_Tank_Size(this : Tank_Type) return Shared_Types.Millilitre_Type is (this.Size);
   function Get_Tank_Current_Fill(this : Tank_Type) return Shared_Types.Millilitre_Type is (this.Current_Fill);

end Tank;
