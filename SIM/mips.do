onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group ifetch /mips_tbss/CORE/IFE/clk_i
add wave -noupdate -expand -group ifetch /mips_tbss/CORE/IFE/rst_i
add wave -noupdate -expand -group ifetch /mips_tbss/CORE/IFE/en_pc_i
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/add_result_i
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/Branch_ctrl_i
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/jump_i
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/zero_i
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/Flush_i
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/pc_o
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/pc_plus4_o
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/instruction_o
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/inst_cnt_o
add wave -noupdate -expand -group ifetch -color Blue -radix hexadecimal /mips_tbss/CORE/IFE/pc_q
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/pc_plus4_r
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/itcm_addr_w
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/next_pc_w
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/rst_flag_q
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/inst_cnt_q
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/pc_prev_q
add wave -noupdate -expand -group ifetch -color Magenta -radix hexadecimal /mips_tbss/CORE/IFE/next_pc_w_final
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/jump_addr_w
add wave -noupdate -expand -group ifetch -radix hexadecimal /mips_tbss/CORE/IFE/instruction_r
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/clk_i
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/rst_i
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/instruction_i
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/WB_mux_data_rd_i
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/RegWrite_ctrl_i
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/reg_write_in
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/RegDst_ctrl_i
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/jump_i
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/pc_plus4_o
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/eq_flag
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/read_data1_o
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/read_data2_o
add wave -noupdate -group IDECODE -radix decimal /mips_tbss/CORE/ID/sign_extend_o
add wave -noupdate -group IDECODE -radix hexadecimal -childformat {{/mips_tbss/CORE/ID/addr_res_o(7) -radix hexadecimal} {/mips_tbss/CORE/ID/addr_res_o(6) -radix hexadecimal} {/mips_tbss/CORE/ID/addr_res_o(5) -radix hexadecimal} {/mips_tbss/CORE/ID/addr_res_o(4) -radix hexadecimal} {/mips_tbss/CORE/ID/addr_res_o(3) -radix hexadecimal} {/mips_tbss/CORE/ID/addr_res_o(2) -radix hexadecimal} {/mips_tbss/CORE/ID/addr_res_o(1) -radix hexadecimal} {/mips_tbss/CORE/ID/addr_res_o(0) -radix hexadecimal}} -subitemconfig {/mips_tbss/CORE/ID/addr_res_o(7) {-height 15 -radix hexadecimal} /mips_tbss/CORE/ID/addr_res_o(6) {-height 15 -radix hexadecimal} /mips_tbss/CORE/ID/addr_res_o(5) {-height 15 -radix hexadecimal} /mips_tbss/CORE/ID/addr_res_o(4) {-height 15 -radix hexadecimal} /mips_tbss/CORE/ID/addr_res_o(3) {-height 15 -radix hexadecimal} /mips_tbss/CORE/ID/addr_res_o(2) {-height 15 -radix hexadecimal} /mips_tbss/CORE/ID/addr_res_o(1) {-height 15 -radix hexadecimal} /mips_tbss/CORE/ID/addr_res_o(0) {-height 15 -radix hexadecimal}} /mips_tbss/CORE/ID/addr_res_o
add wave -noupdate -group IDECODE -radix hexadecimal -childformat {{/mips_tbss/CORE/ID/RF_q(0) -radix decimal} {/mips_tbss/CORE/ID/RF_q(1) -radix decimal} {/mips_tbss/CORE/ID/RF_q(2) -radix decimal} {/mips_tbss/CORE/ID/RF_q(3) -radix decimal} {/mips_tbss/CORE/ID/RF_q(4) -radix decimal} {/mips_tbss/CORE/ID/RF_q(5) -radix decimal} {/mips_tbss/CORE/ID/RF_q(6) -radix decimal} {/mips_tbss/CORE/ID/RF_q(7) -radix decimal} {/mips_tbss/CORE/ID/RF_q(8) -radix decimal} {/mips_tbss/CORE/ID/RF_q(9) -radix decimal} {/mips_tbss/CORE/ID/RF_q(10) -radix decimal} {/mips_tbss/CORE/ID/RF_q(11) -radix decimal} {/mips_tbss/CORE/ID/RF_q(12) -radix decimal} {/mips_tbss/CORE/ID/RF_q(13) -radix decimal} {/mips_tbss/CORE/ID/RF_q(14) -radix decimal} {/mips_tbss/CORE/ID/RF_q(15) -radix decimal} {/mips_tbss/CORE/ID/RF_q(16) -radix decimal} {/mips_tbss/CORE/ID/RF_q(17) -radix decimal} {/mips_tbss/CORE/ID/RF_q(18) -radix decimal} {/mips_tbss/CORE/ID/RF_q(19) -radix decimal} {/mips_tbss/CORE/ID/RF_q(20) -radix decimal} {/mips_tbss/CORE/ID/RF_q(21) -radix decimal} {/mips_tbss/CORE/ID/RF_q(22) -radix decimal} {/mips_tbss/CORE/ID/RF_q(23) -radix decimal} {/mips_tbss/CORE/ID/RF_q(24) -radix decimal} {/mips_tbss/CORE/ID/RF_q(25) -radix decimal} {/mips_tbss/CORE/ID/RF_q(26) -radix decimal} {/mips_tbss/CORE/ID/RF_q(27) -radix decimal} {/mips_tbss/CORE/ID/RF_q(28) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29) -radix decimal -childformat {{/mips_tbss/CORE/ID/RF_q(29)(31) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(30) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(29) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(28) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(27) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(26) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(25) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(24) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(23) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(22) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(21) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(20) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(19) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(18) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(17) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(16) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(15) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(14) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(13) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(12) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(11) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(10) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(9) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(8) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(7) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(6) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(5) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(4) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(3) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(2) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(1) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(0) -radix decimal}}} {/mips_tbss/CORE/ID/RF_q(30) -radix decimal} {/mips_tbss/CORE/ID/RF_q(31) -radix hexadecimal}} -subitemconfig {/mips_tbss/CORE/ID/RF_q(0) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(1) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(2) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(3) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(4) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(5) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(6) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(7) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(8) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(9) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(10) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(11) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(12) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(13) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(14) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(15) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(16) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(17) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(18) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(19) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(20) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(21) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(22) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(23) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(24) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(25) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(26) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(27) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(28) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29) {-height 15 -radix decimal -childformat {{/mips_tbss/CORE/ID/RF_q(29)(31) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(30) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(29) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(28) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(27) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(26) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(25) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(24) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(23) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(22) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(21) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(20) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(19) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(18) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(17) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(16) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(15) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(14) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(13) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(12) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(11) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(10) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(9) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(8) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(7) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(6) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(5) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(4) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(3) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(2) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(1) -radix decimal} {/mips_tbss/CORE/ID/RF_q(29)(0) -radix decimal}}} /mips_tbss/CORE/ID/RF_q(29)(31) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(30) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(29) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(28) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(27) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(26) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(25) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(24) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(23) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(22) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(21) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(20) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(19) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(18) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(17) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(16) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(15) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(14) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(13) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(12) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(11) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(10) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(9) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(8) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(7) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(6) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(5) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(4) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(3) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(2) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(1) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(29)(0) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(30) {-height 15 -radix decimal} /mips_tbss/CORE/ID/RF_q(31) {-height 15 -radix hexadecimal}} /mips_tbss/CORE/ID/RF_q
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/rs_register_w
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/rt_register_w
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/rd_register_w
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/imm_value_w
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/opc
add wave -noupdate -group IDECODE -radix hexadecimal /mips_tbss/CORE/ID/branch_addr_r
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/read_data1_i
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/read_data2_i
add wave -noupdate -group execute -radix decimal /mips_tbss/CORE/EXE/sign_extend_i
add wave -noupdate -group execute -radix binary /mips_tbss/CORE/EXE/funct_i
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/ALUOp_ctrl_i
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/ALUSrc_ctrl_i
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/pc_plus4_i
add wave -noupdate -group execute -radix binary /mips_tbss/CORE/EXE/opc_action
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/zero_o
add wave -noupdate -group execute -radix decimal /mips_tbss/CORE/EXE/alu_res_o
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/addr_res_o
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/a_input_w
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/b_input_w
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/alu_out_mux_w
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/branch_addr_r
add wave -noupdate -group execute -radix binary /mips_tbss/CORE/EXE/alu_ctl_w
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/Temp_mul
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/SHIFT_VAL
add wave -noupdate -group execute -radix hexadecimal /mips_tbss/CORE/EXE/shift_cond
add wave -noupdate -group execute /mips_tbss/CORE/EXE/funct_in
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/clk_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/instruction_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/ID_EX_MemRead
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/reg_write_id_ex_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/reg_write_ex_mem_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/ID_EX_rt
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/IF_ID_rs
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/IF_ID_rt
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rd_ex_mem_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rd_id_ex_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/Branch_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/equal_Flag
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/IF_Flush_o
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/stall
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rs_reg_in
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rt_reg_in
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/opc_w
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/funct_w
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/Branch_cntrl
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rt_reg
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rs_reg
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/stall_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/flush_mashov
add wave -noupdate -group {forward unit } -radix hexadecimal /mips_tbss/CORE/for_pm/rs_EX
add wave -noupdate -group {forward unit } -radix hexadecimal /mips_tbss/CORE/for_pm/rt_EX
add wave -noupdate -group {forward unit } -radix hexadecimal /mips_tbss/CORE/for_pm/rd_MEM
add wave -noupdate -group {forward unit } -radix hexadecimal /mips_tbss/CORE/for_pm/rd_WB
add wave -noupdate -group {forward unit } -radix hexadecimal /mips_tbss/CORE/for_pm/reg_write_MEM
add wave -noupdate -group {forward unit } -radix hexadecimal /mips_tbss/CORE/for_pm/reg_write_WB
add wave -noupdate -group {forward unit } -radix hexadecimal /mips_tbss/CORE/for_pm/forward_A
add wave -noupdate -group {forward unit } -radix hexadecimal /mips_tbss/CORE/for_pm/forward_B
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/opcode_i
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/funct_i
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/RegDst_ctrl_o
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/ALUSrc_ctrl_o
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/MemtoReg_ctrl_o
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/RegWrite_ctrl_o
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/MemRead_ctrl_o
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/MemWrite_ctrl_o
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/Branch_ctrl_o
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/ALUOp_ctrl_o
add wave -noupdate -group CTL -expand /mips_tbss/CORE/CTL/Jump_o
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/rtype_w
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/lw_w
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/sw_w
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/itype_imm_w
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/j_w
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/jr_w
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/jal_w
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/slti_w
add wave -noupdate -group CTL /mips_tbss/CORE/CTL/beq_w
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/instruction_ID_EX
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/rt_ex_mux
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/rs_mid
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/rd_ex_mux
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/reg_dst_ex
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/alu_op_ID_EX
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/alu_src_ID_EX
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/mem_read_ID_EX
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/mem_write_ID_EX
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/MemtoReg_ID_EX
add wave -noupdate -group ID/EX-REG /mips_tbss/CORE/reg_write_ID_EX
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -radix hexadecimal /mips_tbss/CORE/ID/clk_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/clk_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/instruction_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/ID_EX_MemRead
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/reg_write_id_ex_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/reg_write_ex_mem_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/ID_EX_rt
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/IF_ID_rs
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/IF_ID_rt
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rd_ex_mem_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rd_id_ex_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/Branch_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/equal_Flag
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/IF_Flush_o
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/stall
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rs_reg_in
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rt_reg_in
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/opc_w
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/funct_w
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/Branch_cntrl
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rt_reg
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/rs_reg
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/stall_i
add wave -noupdate -group {Detection unnit } -radix hexadecimal /mips_tbss/CORE/detect_unit/flush_mashov
add wave -noupdate -radix hexadecimal /mips_tbss/CORE/detect_unit/IF_Flush_o
add wave -noupdate -radix hexadecimal /mips_tbss/CORE/detect_unit/stall
add wave -noupdate /mips_tbss/CORE/CTL/jr_w
add wave -noupdate /mips_tbss/CORE/CTL/jal_w
add wave -noupdate /mips_tbss/CORE/CTL/lw_w
add wave -noupdate -radix hexadecimal /mips_tbss/CORE/ID/eq_flag
add wave -noupdate -radix hexadecimal /mips_tbss/CORE/IFE/next_pc_w_final
add wave -noupdate -radix decimal /mips_tbss/CORE/ID/RF_q(14)
add wave -noupdate -radix hexadecimal /mips_tbss/CORE/ID/RF_q(31)
add wave -noupdate /mips_tbss/CORE/CTL/beq_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rst_i
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/clk_i
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/pc_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_result_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/read_data1_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/read_data2_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/write_data_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/instruction_top_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/Branch_ctrl_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/Zero_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/MemWrite_ctrl_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/RegWrite_ctrl_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/mclk_cnt_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/inst_cnt_o
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/pc_plus4_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/read_data1_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/read_data2_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/sign_extend_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/addr_res_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_result_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/dtcm_data_rd_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_src_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/branch_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/reg_dst_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/reg_write_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/zero_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/mem_write_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/MemtoReg_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/mem_read_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_op_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/jmp_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/instruction_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/MCLK_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/mclk_cnt_q
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/inst_cnt_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/input_control
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/pc_plus4_IF
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rs_reg
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rt_reg
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rd_reg
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/sign_ext_reg
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/WB_mux_reg_data_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_op_ID_EX
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_src_ID_EX
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/mem_read_ID_EX
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/mem_write_ID_EX
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/MemtoReg_ID_EX
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/reg_write_ID_EX
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/instruction_ID_EX
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/instruction_IF_ID
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/data_1_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/data_2_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/sign_ext_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rt_ex_mux
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rd_ex_mux
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rs_mid
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/reg_dst_ex
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/pc_plus4_ID
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/mem_read_EX_MEM
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/mem_write_EX_MEM
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/MemtoReg_EX_MEM
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/reg_write_EX_MEM
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/zero_alu
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/read_data2_EX_MEM
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/write_addr_ex
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/addr_temp_alu
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_res_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/MemtoReg_MEM_WB
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/reg_write_MEM_WB
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/write_reg_addr_ALU
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/write_reg_addr_DMEM
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/write_reg_addr_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/dtcm_data_rd_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_result_input
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/read_data2_MEM_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/read_data2_MEM_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/write_addr_mem
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/write_addr_final
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rt_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rd_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/rs_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/temp_write_addr
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/write_addr_fin_temp
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/sign_ext_temp_reg
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/stall_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/en_IFID
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/addr_to_fetch
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/forward_A_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/forward_B_w
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_input1
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_input2_pre
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/alu_input2
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/equal_zero_flag
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/Flush_W
add wave -noupdate -group core -radix hexadecimal /mips_tbss/CORE/eq_flag_w
add wave -noupdate -label fetch_inst -radix hexadecimal /mips_tbss/CORE/IFE/instruction_o
add wave -noupdate -label de_inst -radix hexadecimal /mips_tbss/CORE/ID/instruction_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {284374847 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {283858496 ps} {285060080 ps}
