--- **********************************************************************
-- LIBRERIAS
-- **********************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;



-- **********************************************************************
-- ENTIDAD     (entradas/salidas, el fichero de simulación no tiene)
-- **********************************************************************
ENTITY test_rotacion IS
END    test_rotacion;



-- **********************************************************************
-- ARQUITECTURA   (descripción de los estímulos)
-- **********************************************************************
ARCHITECTURE test_rotacion_arq OF test_rotacion IS
    --Declaración de componentes
    COMPONENT rotacion
        GENERIC (
              N20: INTEGER := 20   -- Paramatrizable para cualquier frecuencia de reloj
        );     
        Port ( 
           clk,reset       : in  STD_LOGIC;
           digit_rota      : out STD_LOGIC_VECTOR (3 downto 0)
        );
    END COMPONENT;

    SIGNAL CLK,RESET: std_logic;
    SIGNAL DIGIT_ROTA : std_logic_vector(3 downto 0);


constant ciclo: time := 10 ns;  -- hay que dejar un espacio entre 1 y ms

BEGIN
    -- ///////////////////////////////////////////////////////////////////////////////
    -- Se crea el componente U1 y se conecta a las señales internas de la arquitectura
    -- ///////////////////////////////////////////////////////////////////////////////
    U1: rotacion 
           GENERIC MAP (N20 => 3) 
           PORT MAP(
               clk           => CLK,
               reset         => RESET,
               digit_rota    => DIGIT_ROTA
           ); 
                             

   -- Rellena los procesos de reloj, reset y otras entradas (si las hubiera)

END test_rotacion_arq;



































