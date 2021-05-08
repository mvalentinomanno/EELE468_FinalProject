-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\chorus_try10sin\DualRateDualPortRAM_generic.vhd
-- Created: 2021-04-19 22:46:32
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DualRateDualPortRAM_generic
-- Source Path: chorus_try10sin/dataplane/double_chorus/circular buffer delay/DualRateDualPortRAM_generic
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY DualRateDualPortRAM_generic IS
  GENERIC( AddrWidth                      : integer := 1;
           DataWidth                      : integer := 1
           );
  PORT( clk                               :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        din_A                             :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
        addr_A                            :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
        we_A                              :   IN    std_logic;  -- ufix1
        din_B                             :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
        addr_B                            :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
        we_B                              :   IN    std_logic;  -- ufix1
        doutA                             :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
        doutB                             :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
        );
END DualRateDualPortRAM_generic;


ARCHITECTURE rtl OF DualRateDualPortRAM_generic IS

  -- Local Type Definitions
  TYPE ram_type IS ARRAY (2**AddrWidth - 1 DOWNTO 0) of std_logic_vector(DataWidth - 1 DOWNTO 0);

  -- Signals
  SHARED VARIABLE ram : ram_type := (OTHERS => (OTHERS => '0'));
  SIGNAL dout_a                           : std_logic_vector(DataWidth - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL dout_b                           : std_logic_vector(DataWidth - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL addr_A_unsigned                  : unsigned(AddrWidth - 1 DOWNTO 0);  -- generic width
  SIGNAL addr_B_unsigned                  : unsigned(AddrWidth - 1 DOWNTO 0);  -- generic width

BEGIN
  addr_A_unsigned <= unsigned(addr_A);

  addr_B_unsigned <= unsigned(addr_B);

  DualRateDualPortRAM_generic_processA: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF enb_1_2048_0 = '1' THEN
        IF we_A = '1' THEN
          ram(to_integer(addr_A_unsigned)) := din_A;
          dout_a <= din_A;
        ELSE
          dout_a <= ram(to_integer(addr_A_unsigned));
        END IF;
      END IF;
    END IF;
  END PROCESS DualRateDualPortRAM_generic_processA;

  DualRateDualPortRAM_generic_processB: PROCESS (clk)
  BEGIN
    IF clk'event AND clk = '1' THEN
      IF enb_1_2048_0 = '1' THEN
        IF we_B = '1' THEN
          ram(to_integer(addr_B_unsigned)) := din_B;
          dout_b <= din_B;
        ELSE
          dout_b <= ram(to_integer(addr_B_unsigned));
        END IF;
      END IF;
    END IF;
  END PROCESS DualRateDualPortRAM_generic_processB;

  doutA <= dout_a;
  doutB <= dout_b;

END rtl;

