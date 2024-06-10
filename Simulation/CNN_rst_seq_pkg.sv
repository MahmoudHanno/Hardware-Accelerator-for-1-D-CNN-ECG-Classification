package CNN_rst_seq_pkg;
	import CNN_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	class CNN_rst_seq extends uvm_sequence #(CNN_seq_item);
		`uvm_object_utils(CNN_rst_seq);
		CNN_seq_item seq_item;

		function new(string name ="CNN_rst_seq");
			super.new(name);
		endfunction : new

		task body;
			seq_item=CNN_seq_item::type_id::create("seq_item");
			start_item(seq_item);
			seq_item.rst=1;
			finish_item(seq_item);
		endtask : body
	endclass : CNN_rst_seq
endpackage : CNN_rst_seq_pkg