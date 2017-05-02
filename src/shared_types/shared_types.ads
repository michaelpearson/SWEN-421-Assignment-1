package Shared_Types with SPARK_Mode => On is

   type Fuel_Type is (Petrol95, Petrol98, Diesel);
   subtype Millilitre_Type is Integer range 0..Integer'Last;

end Shared_Types;
