--- **********************************************************************
-- LIBRERIAS
-- **********************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- **********************************************************************
-- ENTIDAD     (entradas/salidas, el fichero de simulación no tiene)
-- **********************************************************************
ENTITY test_codigo IS
END    test_codigo;

-- **********************************************************************
-- ARQUITECTURA   (descripción de los estímulos)
-- **********************************************************************
ARCHITECTURE test_codigo_arq OF test_codigo IS
    --Declaración de componentes
    COMPONENT codigo
        Port ( 
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           resultado : out STD_LOGIC);
	END COMPONENT;

    SIGNAL RESULTADO : std_logic;
    SIGNAL DIGIT0,DIGIT1,DIGIT2,DIGIT3 : std_logic_vector(3 downto 0);


constant ciclo: time := 10 ns;  -- hay que dejar un espacio entre 1 y ns

BEGIN
    -- ///////////////////////////////////////////////////////////////////////////////
    -- Se crea el componente U1 y se conecta a las señales internas de la arquitectura
    -- ///////////////////////////////////////////////////////////////////////////////
    U1: codigo PORT MAP(
                          digit0    => DIGIT0,
                          digit1    => DIGIT1,
                          digit2    => DIGIT2,
                          digit3    => DIGIT3,
                          resultado => RESULTADO
                       );

    -- ======================================================================
    -- Proceso para el resto de entradas; ENABLE_test
    -- ======================================================================
    tb: PROCESS
    BEGIN
        -- Rellenar aquí los estímulos dando valores a las entradas

        wait;                  -- Espera indefinida con ENABLE_test='1'
    end process tb;

END test_codigo_arq;


































