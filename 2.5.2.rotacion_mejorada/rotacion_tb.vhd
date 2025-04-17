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
              N20: INTEGER := 20;   -- 20 bits para el contador de rotación
              N10: INTEGER := 10;   -- 10 bits para el contador de parpadeo
              NP: INTEGER := 2   -- Constante para el cálculo de parpadeos
        );     
        Port ( 
           clk,reset       : in  STD_LOGIC;
           contador_activo: in std_logic_vector(3 downto 0);
           ini_parpadeo: in std_logic;
           fin_parpadeo: out std_logic;
           digit_rota      : out STD_LOGIC_VECTOR (3 downto 0)
        );
    END COMPONENT;

    SIGNAL CLK, RESET, INI_PARPADEO, FIN_PARPADEO: std_logic;
    SIGNAL DIGIT_ROTA, CONTADOR_ACTIVO : std_logic_vector(3 downto 0);

constant ciclo: time := 10 ns;  -- hay que dejar un espacio entre 1 y ms

BEGIN
    -- ///////////////////////////////////////////////////////////////////////////////
    -- Se crea el componente U1 y se conecta a las señales internas de la arquitectura
    -- ///////////////////////////////////////////////////////////////////////////////
    U1: rotacion 
           GENERIC MAP (N20 => 2, N10 => 4) 
           PORT MAP(
               clk           => CLK,
               reset         => RESET,
               ini_parpadeo => INI_PARPADEO,
               fin_parpadeo => FIN_PARPADEO,
               contador_activo => CONTADOR_ACTIVO,
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
    -- Proceso de la simulación de un reloj de entrada
    -- ======================================================================   
    PROCESS
    BEGIN
        CLK <='0';    wait for ciclo/2;
        CLK <='1';    wait for ciclo/2;
    END PROCESS;
    
    -- ======================================================================
    -- Proceso para el resto de entradas; ENABLE_test
    -- ======================================================================
    tb: PROCESS
    BEGIN
     contador_activo <= (others => '0');
     ini_parpadeo    <= '0';
     wait for 1.1*ciclo/2;
     
     ini_parpadeo <= '1';
     
     --Descomentar esta sección para comprobar que al desactivarse la señan ini_parpadeo para de incrementarse el contador
     -- de parpadeo
     
     --wait for 20*ciclo;
     --ini_parpadeo <= '0';
     
     --wait for 20*ciclo;
     --ini_parpadeo <= '1';
     wait;
     
    end process tb;    
END test_rotacion_arq;






































