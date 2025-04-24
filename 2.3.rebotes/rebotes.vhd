LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY rebotes IS
  GENERIC(
    N21  :  INTEGER := 21); -- tamano contador (20 bits dan 10.5ms con reloj de 100Mhz)
  PORT(
    clk : IN  STD_LOGIC;  --input clock
    i   : IN  STD_LOGIC;  --input signal to be rebotesd
    o   : OUT STD_LOGIC); --output signal
END rebotes;

ARCHITECTURE rebotes_arq OF rebotes IS
  SIGNAL biestables: STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";              --input flip flops
  SIGNAL reinicia  : STD_LOGIC := '0';                                  --sync reset to zero
  SIGNAL cuenta    : STD_LOGIC_VECTOR(N21-1 DOWNTO 0) := (OTHERS => '0'); --counter output
  SIGNAL reset     : STD_LOGIC := '0';
BEGIN

  reinicia <= biestables(0) xor biestables(1);   --determina cuando se reinicia o cuenta el contador


  PROCESS(clk)
  BEGIN
    IF(clk'EVENT and clk = '1') THEN -- si hay rising_edge
      biestables(0) <= i;
      biestables(1) <= biestables(0);
      reset <= reinicia;
      IF(reinicia = '1') THEN
        CUENTA <= (others =>'0');
      ELSE
        CUENTA <= CUENTA + 1;
        IF(CUENTA(N21-1) = '1') THEN
            o <= biestables(1);
        END IF;
        END IF;
      END IF;


  END PROCESS;
END rebotes_arq;
