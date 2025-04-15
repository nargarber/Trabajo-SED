library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity codigo is
    Port ( 
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           resultado : out STD_LOGIC);
end codigo;

architecture codigo_arq of codigo is
begin
resultado <= '1' when (digit3 = "0100" and
                       digit2 = "0011" and
                       digit1 = "0010" and
                       digit0 = "0001") else '0';
end codigo_arq;




