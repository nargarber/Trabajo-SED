----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2025 17:47:39
-- Design Name: 
-- Module Name: siete_seg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity siete_seg is
    Port ( segments : out STD_LOGIC_VECTOR (6 downto 0);
           digit_rota : in STD_LOGIC_VECTOR (3 downto 0);
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0));
end siete_seg;

architecture Behavioral of siete_seg is
    signal bcd : std_logic_vector(3 downto 0);
begin
--Se seleciona un por defecto > 9 para que en el caso de que se dé no se muestre en el display
bcd <= digit0 when digit_rota = "0001" else
       digit1 when digit_rota = "0010" else
       digit2 when digit_rota = "0100" else
       digit3 when digit_rota = "1000" else
       "1111";
       
--La secuencia en nuestro 7 segmentos es ABCDEFGDp (mirar foto de la documentación), recuerda que es activa a nivel bajo       
with bcd select       
segments <= "1000000" when "0000",  -- 0
            "1111001" when "0001",  -- 1
            "0100100" when "0010",  -- 2
            "0110000" when "0011",  -- 3
            "0011010" when "0100",  -- 4
            "0010010" when "0101",  -- 5
            "0000010" when "0110",  -- 6
            "1111000" when "0111",  -- 7
            "0000000" when "1000",  -- 8
            "0010000" when "1001",  -- 9
            "1111111" when others;  -- all segments OFF (default)

end Behavioral;

