library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Avalon2Simulink is
	port(
		sys_clk		: in std_logic;
		sys_reset	: in std_logic;
		avalon_slave_address : in std_logic_vector(3 downto 0);
		avalon_slave_write   : in std_logic;
		avalon_slave_writedata : in std_logic_vector(31 downto 0);
		avalon_slave_read	: in std_logic;
		avalon_slave_readdata	: out std_logic_vector(31 downto 0);
		avalon_streaming_source_data : out std_logic_vector(23 downto 0);
		avalon_streaming_source_valid : out std_logic;
		avalon_streaming_source_channel : out std_logic;
		avalon_Streaming_sink_data : in std_logic_vector(23 downto 0);
		avalon_streaming_sink_valid : in std_logic;
		avalon_streaming_sink_channel : in std_logic
		);
end entity Avalon2Simulink;

architecture Avalon2Simulink_arch of Avalon2Simulink is

	component dataplane
		port( clk                               :   IN    std_logic;
        		reset                             :   IN    std_logic;
        		clk_enable                        :   IN    std_logic;
        		input_signal                      :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
       		 	delay_samples                     :   IN    std_logic_vector(13 DOWNTO 0);  -- uint16
        		echo_gain                         :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En15
        		enable                            :   IN    std_logic;
        		volume                            :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En15
        		delay_samples2                    :   IN    std_logic_vector(13 DOWNTO 0);  -- uint16
        		ce_out                            :   OUT   std_logic;
        		output_signal                     :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
        );
	end component;

	signal data_l_ADC : std_logic_vector(23 downto 0);
	signal data_l_DAC : std_logic_vector(23 downto 0);
	signal data_r_ADC : std_logic_vector(23 downto 0);
	signal data_r_DAC : std_logic_vector(23 downto 0);
	
	signal l_en : std_logic := '1';
	signal l_delay_samp1 : std_logic_vector(13 downto 0) := "00001111101000"; --1000
	signal l_chorus_gain : std_logic_vector(15 downto 0) := x"6000"; --.75
	signal r_en	: std_logic := '1';
	signal r_delay_samp1 : std_logic_vector(13 downto 0) := "00001111101000"; --1000
	signal r_chorus_gain : std_logic_vector(15 downto 0) := x"6000"; --.75
	
	signal l_volume : std_logic_vector(15 downto 0) := x"6000"; --.75
	signal l_delay_samp2 : std_logic_vector(13 downto 0) := "00011111010000"; --2000
	signal r_volume	: std_logic_vector(15 downto 0) := x"6000"; --.75
	signal r_delay_samp2 : std_logic_vector(13 downto 0) := "00011111010000"; --2000

	
	signal zeros31 : std_logic_vector(30 downto 0) := (others => '0');	--signals used to achieve 32 bits
	signal zeros16 : std_logic_vector(15 downto 0) := (others => '0');
	signal zeros18 : std_logic_vector(17 downto 0) := (others => '0');
begin

process (sys_clk)
	begin
		if rising_Edge(sys_clk) then   --checks if valid
			if avalon_streaming_sink_valid = '1' then
				if avalon_Streaming_sink_channel = '0' then --left channel
					data_l_ADC <= avalon_streaming_sink_data;
					avalon_streaming_source_data <= data_l_DAC;
					avalon_streaming_source_channel <= '0';
					avalon_streaming_source_valid <= '1';
				else --right channel
					data_r_ADC <= avalon_streaming_sink_data;
					avalon_streaming_source_data <= data_r_DAC;
					avalon_streaming_source_channel <= '1';
					avalon_streaming_source_valid <= '1';
				end if;
			else
				avalon_streaming_source_valid <= '0';
			end if;
		end if;
	end process;
	
	
	process(sys_clk) is --read registers
	begin
		if rising_edge(sys_clk) and avalon_slave_read ='1' then
			case avalon_slave_address is
				when "0000" => avalon_slave_readdata <= zeros31 & l_en;
				when "0001" => avalon_slave_readdata <= zeros18 & l_delay_samp1;
				when "0010" => avalon_slave_readdata <= zeros18 & l_delay_samp2;
				when "0011" => avalon_slave_readdata <= zeros16 & l_chorus_gain;
				when "0100" => avalon_slave_readdata <= zeros16 & l_volume;
				when "0101" => avalon_slave_readdata <= zeros31 & r_en;
				when "0110" => avalon_slave_readdata <= zeros18 & r_delay_samp1;
				when "0111" => avalon_slave_readdata <= zeros18 & r_delay_samp2;
				when "1000" => avalon_slave_readdata <= zeros16 & r_chorus_gain;
				when "1001" => avalon_slave_readdata <= zeros16 & r_volume;

				when others => avalon_slave_readdata <= (others => '0');
			end case;
		end if;
	end process;
	
	process(sys_clk) is --write values
	begin
		if rising_edge(sys_clk) and avalon_slave_write = '1' then
			case avalon_slave_address is
				when "0000" => l_en <= avalon_slave_writedata(0);
				when "0001" => l_delay_samp1 <= avalon_slave_writedata(13 downto 0);
				when "0010" => l_delay_samp2 <= avalon_slave_writedata(13 downto 0);
				when "0011" => l_chorus_gain <= avalon_slave_writedata(15 downto 0);
				when "0100" => l_volume <= avalon_slave_writedata(15 downto 0);

				when "0101" => r_en <= avalon_slave_writedata(0);
				when "0110" => r_delay_samp1 <= avalon_slave_writedata(13 downto 0);
				when "0111" => r_delay_samp2 <= avalon_slave_writedata(13 downto 0);
				when "1000" => r_chorus_gain <= avalon_slave_writedata(15 downto 0);
				when "1001" => r_volume <= avalon_slave_writedata(15 downto 0);
				when others =>
			end case;
		end if;
	end process;
	
	right : dataplane port map( --simulink sound effect - right channel
		clk	=> sys_clk,
		reset	=> sys_reset,
		clk_enable => '1',
		input_signal => data_r_ADC,
		delay_samples => r_delay_samp1,
		echo_gain => r_chorus_gain,
		enable => r_en,
		volume => r_volume,
		delay_samples2 => r_delay_samp2,
		ce_out => open,
		output_signal => data_r_DAC
	);
	
		
	left : dataplane port map( --simulink sound effect - right channel
		clk	=> sys_clk,
		reset	=> sys_reset,
		clk_enable => '1',
		input_signal => data_l_ADC,
		delay_samples => l_delay_samp1,
		echo_gain => l_chorus_gain,
		enable => l_en,
		volume => l_volume,
		delay_samples2 => l_delay_samp2,
		ce_out => open,
		output_signal => data_l_DAC
	);
	
end architecture; 