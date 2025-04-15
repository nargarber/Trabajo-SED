LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY rebotes IS
  GENERIC(
    N  :  INTEGER := 21); -- tamano contador (20 bits dan 10.5ms con reloj de 100Mhz)
  PORT(
    clk : IN  STD_LOGIC;  --input clock
    i   : IN  STD_LOGIC;  --input signal to be rebotesd
    o   : OUT STD_LOGIC); --output signal
END rebotes;

ARCHITECTURE rebotes_arq OF rebotes IS
  SIGNAL biestables: STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";              --input flip flops
  SIGNAL reinicia  : STD_LOGIC := '0';                                  --sync reset to zero
  SIGNAL cuenta    : STD_LOGIC_VECTOR(N-1 DOWNTO 0) := (OTHERS => '0'); --counter output
BEGIN

  reinicia <= biestables(0) xor biestables(1);   --determina cuando se reinicia o cuenta el contador
  
  PROCESS(clk)
  BEGIN
    IF(clk'EVENT and clk = '1') THEN
      biestables(0) <= i;

      -- rellenar aquí

  END PROCESS;
END rebotes_arq;







