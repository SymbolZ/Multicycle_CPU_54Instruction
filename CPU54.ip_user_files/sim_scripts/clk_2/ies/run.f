-makelib ies/xil_defaultlib -sv \
  "C:/Xilinx16/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies/xpm \
  "C:/Xilinx16/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../CPU54.srcs/sources_1/ip/clk_2/clk_2_clk_wiz.v" \
  "../../../../CPU54.srcs/sources_1/ip/clk_2/clk_2.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

