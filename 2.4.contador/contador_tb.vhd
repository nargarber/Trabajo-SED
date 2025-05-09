--- **********************************************************************
-- LIBRERIAS
-- **********************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- **********************************************************************
-- ENTIDAD     (entradas/salidas, el fichero de simulación no tiene)
-- **********************************************************************
ENTITY test_contador IS
END    test_contador;

-- **********************************************************************
-- ARQUITECTURA   (descripción de los estímulos)
-- **********************************************************************
ARCHITECTURE test_contador_arq OF test_contador IS
    --Declaración de componentes
    COMPONENT contador
		Port ( 
                   clk      : in  STD_LOGIC;
                   reset    : in  STD_LOGIC;
                   enable   : in  STD_LOGIC;
                   up       : in  STD_LOGIC;
                   down     : in  STD_LOGIC;
		           cuenta  : out STD_LOGIC_VECTOR (3 downto 0));
    END COMPONENT;

    SIGNAL CLK,ENABLE,UP,DOWN,RESET : std_logic;
    SIGNAL CUENTA : std_logic_vector(3 downto 0);


constant ciclo: time := 10 ns;  -- hay que dejar un espacio entre 10 y ns

BEGIN
    -- ///////////////////////////////////////////////////////////////////////////////
    -- Se crea el componente U1 y se conecta a las señales internas de la arquitectura
    -- ///////////////////////////////////////////////////////////////////////////////
    U1: contador PORT    MAP(
                                clk     => CLK,
                                reset   => RESET,
                                enable  => ENABLE,
                                up      => UP,
                                down    => DOWN,
                                cuenta => CUENTA
                             );

    -- ======================================================================
    -- Proceso de la entrada de reloj. Se ejecuta indefinidamente ya que no tiene "WAIT;"
    -- ======================================================================
    PROCESS
    BEGIN
        CLK <='0';    wait for ciclo/2;
        CLK <='1';    wait for ciclo/2;
    END PROCESS;

    PROCESS
    BEGIN
        reset <='1';    wait for ciclo/3;
        reset <='0';    wait for 10*ciclo;
        reset <='1';    wait for ciclo/3;
        reset <='0';    wait;
    END PROCESS;


    -- ======================================================================
    -- Proceso para el resto de entradas; ENABLE_test
    -- ======================================================================
    tb: PROCESS
    BEGIN
        UP        <= '0';
        DOWN      <= '0';
        ENABLE    <= '0';
        wait for 1.1*ciclo/2;    -- No tocar
        
        -- Simulación de comparación con la dada en la memoria
        for i in 0 to 1 loop
            UP <= '1';
            wait for 1.5*ciclo;
            ENABLE <= '1';
            wait for 1.1*ciclo/2;
            ENABLE <= '0';
            wait for 1.5*ciclo;
            UP <= '0';
            wait for 1.5*ciclo;
        end loop;
   
   
        wait until falling_edge(reset);
        wait for ciclo;
        --Simulación de lo que se nos pide aportar
        for i in 0 to 2 loop
            UP <= '1';
            wait for 1.5*ciclo;
            ENABLE <= '1';
            wait for 1.1*ciclo/2;
            ENABLE <= '0';
            wait for 1.5*ciclo;
            UP <= '0';
            wait for 1.5*ciclo;
        end loop;
        
        DOWN <= '1';
        wait for 1.5*ciclo;
        ENABLE <= '1';
        wait for 1.1*ciclo/2;
        ENABLE <= '0';
        wait for 1.5*ciclo;
        DOWN <= '0';
        wait for 1.5*ciclo;
        
        for i in 0 to 1 loop
            UP <= '1';
            wait for 1.5*ciclo;
            ENABLE <= '1';
            wait for 1.1*ciclo/2;
            ENABLE <= '0';
            wait for 1.5*ciclo;
            UP <= '0';
            wait for 1.5*ciclo;
        end loop;        
        
        wait;                  -- Espera indefinida 
    end process tb;

END test_contador_arq;



































