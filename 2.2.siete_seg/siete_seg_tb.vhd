--- **********************************************************************
-- LIBRERIAS
-- **********************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- **********************************************************************
-- ENTIDAD     (entradas/salidas, el fichero de simulaci�n no tiene)
-- **********************************************************************
ENTITY test_siete_seg IS
END    test_siete_seg;

-- **********************************************************************
-- ARQUITECTURA   (descripci�n de los est�mulos)
-- **********************************************************************
ARCHITECTURE test_siete_seg_arq OF test_siete_seg IS
    --Declaraci�n de componentes
    COMPONENT siete_seg
        Port ( 
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           digit_rota : in STD_LOGIC_VECTOR (3 downto 0);
           segments : out STD_LOGIC_VECTOR (6 downto 0));
	END COMPONENT;

    SIGNAL SEGMENTS : std_logic_vector(6 downto 0);
    SIGNAL DIGIT0,DIGIT1,DIGIT2,DIGIT3, DIGIT_ROTA : std_logic_vector(3 downto 0);


constant ciclo: time := 10 ns;  -- hay que dejar un espacio entre 1 y ns

BEGIN
    -- ///////////////////////////////////////////////////////////////////////////////
    -- Se crea el componente U1 y se conecta a las se�ales internas de la arquitectura
    -- ///////////////////////////////////////////////////////////////////////////////
    U1: siete_seg PORT MAP(
                          digit0    => DIGIT0,
                          digit1    => DIGIT1,
                          digit2    => DIGIT2,
                          digit3    => DIGIT3,
                          segments => SEGMENTS,
                          digit_rota => DIGIT_ROTA
                       );

    -- ======================================================================
    -- Proceso para el resto de entradas; ENABLE_test
    -- ======================================================================
    tb: PROCESS
    BEGIN
        -- Simulaci�n inicial para comprobar que est� bien el c�digo
        digit0 <= "0001";
        digit1 <= "0111";
        digit2 <= "0011";
        digit3 <= "0110";
        
        digit_rota <= "0001";
        wait for 2*ciclo;
       
        digit_rota <= "0010";
        wait for 2*ciclo;
        
        digit_rota <= "0100";
        wait for 2*ciclo;
        
        digit_rota <= "1000";
        wait for 2*ciclo;
                      
        digit0 <= "0101";
        digit1 <= "0001";
        digit2 <= "0110";
        digit3 <= "1001";
                
        digit_rota <= "1000";
        wait for 2*ciclo;
       
        digit_rota <= "0100";
        wait for 2*ciclo;
        
        digit_rota <= "0010";
        wait for 2*ciclo;
        
        digit_rota <= "0001";
        wait;                 -- Espera indefinida con ENABLE_test='1'
    end process tb;

END test_siete_seg_arq;


































