package CNN_driver_pkg;
import uvm_pkg::*;
import CNN_config_pkg::*;
import CNN_seq_item_pkg::*;
import CNN_sqr_pkg::*;
`include "uvm_macros.svh"
	class CNN_driver extends uvm_driver #(CNN_seq_item);
		`uvm_component_utils(CNN_driver)

		virtual CNN_if CNN_vif;
		CNN_config CNN_cfg;
		CNN_seq_item stim_seq_item;

		function new(string name="CNN_driver", uvm_component parent = null);
			super.new(name,parent);
		endfunction : new


		task run_phase (uvm_phase phase);
			super.run_phase(phase);
			forever begin
				stim_seq_item=CNN_seq_item::type_id::create("stim_seq_item");
				seq_item_port.get_next_item(stim_seq_item);
			
			CNN_vif.rst=stim_seq_item.rst;
			CNN_vif.main_start=stim_seq_item.main_start;
			CNN_vif.firstmem=stim_seq_item.firstmem;
			


			
            
				@(negedge CNN_vif.clk);
				seq_item_port.item_done();
				`uvm_info("run_phase",stim_seq_item.convert2string_stimulus(),UVM_HIGH)
			end
			
		endtask : run_phase
	endclass : CNN_driver
endpackage : CNN_driver_pkg