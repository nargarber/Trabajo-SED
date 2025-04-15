-- **********************************************************************
-- LIBRERIAS
-- **********************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- **********************************************************************
-- ENTIDAD     (entradas/salidas, el fichero de simulación no tiene)
-- **********************************************************************
ENTITY test_rebotes IS
END    test_rebotes;

-- **********************************************************************
-- ARQUITECTURA   (descripción de los estímulos)
-- **********************************************************************
ARCHITECTURE test_rebotes_arq OF test_rebotes IS
    --Declaración de componentes
    COMPONENT rebotes
		  GENERIC(
			N21 : INTEGER := 21  -- Tamaño del contador (ajustable segun la frecuencia del reloj)
		  );
		  PORT(
			clk     : IN  STD_LOGIC;  -- Reloj del sistema
			i       : IN  STD_LOGIC;  -- Entrada del botón con rebote
			o       : OUT STD_LOGIC   -- Salida debounced
		  );
    END COMPONENT;

    SIGNAL CLK,I,O : std_logic;
    constant ciclo: time :=  10 ns;  -- hay que dejar un espacio entre 10 y ns
BEGIN
    -- ///////////////////////////////////////////////////////////////////////////////
    -- Se crea el componente U1 y se conecta a las señales internas de la arquitectura
    -- ///////////////////////////////////////////////////////////////////////////////
    i_rebotes: rebotes   
                 GENERIC MAP (N => 3)
                 PORT    MAP(
                                clk    => CLK,
                                i      => I,
                                o      => O
                             );

    -- ======================================================================
    -- Proceso de la entrada de reloj. Se ejecuta indefinidamente ya que no tiene "WAIT;"
    -- ======================================================================
    PROCESS
    BEGIN
        CLK<='0';    wait for ciclo/2;
        CLK<='1';    wait for ciclo/2;
    END PROCESS;


    -- ======================================================================
    -- Proceso para el resto de entradas; ENABLE_test
    -- ======================================================================
    tb: PROCESS
    BEGIN
        I <= '0';


        -- rellenar aquí 

         wait;                  -- Espera indefinida
    end process tb;

END test_rebotes_arq;




















