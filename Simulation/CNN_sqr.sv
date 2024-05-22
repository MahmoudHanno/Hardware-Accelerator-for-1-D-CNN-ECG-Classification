package CNN_sqr_pkg;
	import CNN_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	class CNN_sqr extends uvm_sequencer #(CNN_seq_item);
		`uvm_component_utils(CNN_sqr)
		function new(string name="CNN_sqr",uvm_component parent= null);
			super.new(name,parent);
		endfunction : new
    endclass : CNN_sqr
endpackage : CNN_sqr_pkg