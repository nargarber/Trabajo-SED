----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.04.2025 19:32:21
-- Design Name: 
-- Module Name: contador - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           cuenta : out STD_LOGIC_VECTOR (3 downto 0));
end contador;

architecture Behavioral of contador is
    signal count: unsigned(3 downto 0);
begin

cuenta <= std_logic_vector(count);

process(clk, enable, up, down, reset)
begin
--Se ha hecho suponiendo un reset asíncrono, en caso de ser síncrono el reset debe comprobarse después de ver si estamos en un flanco de subida. Preguntar Rafa
 if (reset = '1') then 
    count <= "0000"; 
 elsif (rising_edge(clk) AND enable = '1') then 
    if (up = '1') then 
        count <=  count + 1;
    elsif (down = '1') then
        count <=  count - 1; 
    end if; 
end if;

end process;

end Behavioral;

