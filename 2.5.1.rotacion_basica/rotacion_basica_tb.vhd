--- **********************************************************************
-- LIBRERIAS
-- **********************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;



-- **********************************************************************
-- ENTIDAD     (entradas/salidas, el fichero de simulaci�n no tiene)
-- **********************************************************************
ENTITY test_rotacion IS
END    test_rotacion;



-- **********************************************************************
-- ARQUITECTURA   (descripci�n de los est�mulos)
-- **********************************************************************
ARCHITECTURE test_rotacion_arq OF test_rotacion IS
    --Declaraci�n de componentes
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
    -- Se crea el componente U1 y se conecta a las se�ales internas de la arquitectura
    -- ///////////////////////////////////////////////////////////////////////////////
    U1: rotacion 
           GENERIC MAP (N20 => 3) 
           PORT MAP(
               clk           => CLK,
               reset         => RESET,
               digit_rota    => DIGIT_ROTA
           ); 
    -- ======================================================================
    -- Proceso de la entrada del reset inicial
    -- ======================================================================                           

    PROCESS
    BEGIN
        reset <='1';    wait for ciclo/3;
        reset <='0';    wait for 10*ciclo;
        reset <='1';    wait for ciclo/3;
        reset <='0';    wait;
    END PROCESS;
    
     -- ======================================================================
    -- Proceso de la simulaci�n de un reloj de entrada
    -- ======================================================================   
    PROCESS
    BEGIN
        CLK <='0';    wait for ciclo/2;
        CLK <='1';    wait for ciclo/2;
    END PROCESS;
        
END test_rotacion_arq;





































