package CNN_test_pkg; 
import CNN_config_pkg::*;
import CNN_env_pkg::*;
import CNN_rst_seq_pkg::*;
import CNN_main_seq_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class CNN_test extends uvm_test;
	`uvm_component_utils(CNN_test)

	CNN_env env;
	CNN_config CNN_cfg;
	CNN_rst_seq reset_seq;
	CNN_main_seq main_seq;

	

	function new(string name= "CNN_test", uvm_component parent= null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = CNN_env::type_id::create("env",this);
		CNN_cfg= CNN_config::type_id::create("CNN_cfg",this);
		reset_seq= CNN_rst_seq::type_id::create("reset_seq",this);
		main_seq= CNN_main_seq::type_id::create("main_seq",this);
		if(!uvm_config_db #(virtual CNN_if)::get(this,"","CNN_IF",CNN_cfg.CNN_vif))
			`uvm_fatal("build_phase","Test- Unable to get the virtual interface of the SPI RAM from uvm_config_db");


		uvm_config_db #(CNN_config)::set(this,"*","CFG",CNN_cfg);
	endfunction : build_phase


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		phase.raise_objection(this);
		repeat(2155)begin
		 //`uvm_info("run_phase","Reset asserted", UVM_LOW)
		 reset_seq.start(env.agt.sqr);
		// `uvm_info("run_phase","Reset Deasserted", UVM_LOW)

		// `uvm_info("run_phase","stimulus generation started", UVM_LOW)
		main_seq.start(env.agt.sqr);
		// `uvm_info("run_phase","Stimulus Deasserted", UVM_LOW)
		end
		phase.drop_objection(this);	
	endtask : run_phase

endclass : CNN_test
endpackage : CNN_test_pkg