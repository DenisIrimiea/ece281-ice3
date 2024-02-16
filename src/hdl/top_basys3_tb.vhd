--+----------------------------------------------------------------------------
--| 
--| COPYRIGHT 2017 United States Air Force Academy All rights reserved.
--| 
--| United States Air Force Academy     __  _______ ___    _________ 
--| Dept of Electrical &               / / / / ___//   |  / ____/   |
--| Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
--| 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
--| USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
--| 
--| ---------------------------------------------------------------------------
--|
--| FILENAME      : top_basys3_tb.vhd
--| AUTHOR(S)     : Capt Johnson
--| CREATED       : 01/30/2019 Last Modified 06/24/2020
--| DESCRIPTION   : This file implements a test bench for the full adder top level design.
--|
--| DOCUMENTATION : None
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : top_basys3.vhd
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_basys3_tb is
end top_basys3_tb;

architecture test_bench of top_basys3_tb is 
    -- Declare the component of your top-level design unit under test (UUT)
    component top_basys3 is
        port(
            sw  : in  std_logic_vector(2 downto 0);
            led : out std_logic_vector(1 downto 0)
        );
    end component;
  
    -- Declare signals needed to stimulate the UUT inputs
    signal w_sw  : std_logic_vector(2 downto 0);
    signal w_led : std_logic_vector(1 downto 0);
    
begin
    -- PORT MAPS ----------------------------------------
    -- Instantiate the Unit Under Test (UUT)
    top_basys3_inst : top_basys3 port map (
       sw => w_sw,
       led => w_led
    );
    
    -- PROCESSES ----------------------------------------    
    -- Test Plan Process
    test_process : process 
    begin
        -- Test case 1: 000 -> Sum = 0, Carry = 0
        w_sw <= "000"; wait for 10 ns;
        assert w_led = "00" report "bad 000" severity failure;
        
        -- Test case 2: 001 -> Sum = 1, Carry = 0
        w_sw <= "001"; wait for 10 ns;
        assert w_led = "01" report "bad 001" severity failure;
        
        -- Add the remaining test cases based on the full adder logic
        -- Test case 3: 010 -> Sum = 1, Carry = 0
        w_sw <= "010"; wait for 10 ns;
        assert w_led = "01" report "bad 010" severity failure;
        
        -- Test case 4: 011 -> Sum = 0, Carry = 1
        w_sw <= "011"; wait for 10 ns;
        assert w_led = "10" report "bad 011" severity failure;
        
        -- Test case 5: 100 -> Sum = 1, Carry = 0
        w_sw <= "100"; wait for 10 ns;
        assert w_led = "01" report "bad 100" severity failure;
        
        -- Test case 6: 101 -> Sum = 0, Carry = 1
        w_sw <= "101"; wait for 10 ns;
        assert w_led = "10" report "bad 101" severity failure;
        
        -- Test case 7: 110 -> Sum = 0, Carry = 1
        w_sw <= "110"; wait for 10 ns;
        assert w_led = "10" report "bad 110" severity failure;
        
        -- Test case 8: 111 -> Sum = 1, Carry = 1
        w_sw <= "111"; wait for 10 ns;
        assert w_led = "11" report "bad 111" severity failure;
        
        -- End of tests
        wait; -- wait forever
    end process;
end test_bench;

