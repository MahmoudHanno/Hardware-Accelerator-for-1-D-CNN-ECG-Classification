package CNN_main_seq_pkg;
	import CNN_seq_item_pkg::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	class CNN_main_seq extends uvm_sequence #(CNN_seq_item);
		`uvm_object_utils(CNN_main_seq);
		CNN_seq_item seq_item;
		string path;
		int count=3;
		function new(string name ="CNN_main_seq");
			super.new(name);
		endfunction : new

		task body;
			seq_item=CNN_seq_item::type_id::create("seq_item");
			start_item(seq_item);
				
				seq_item.rst=0;
				seq_item.main_start=1;
			finish_item(seq_item);
			start_item(seq_item);
				seq_item.rst=0;
				seq_item.main_start=0;
			finish_item(seq_item);
			repeat(3045)begin
				start_item(seq_item);
					
				finish_item(seq_item);
			end
			for(int i=0;i<10;i++)begin
				start_item(seq_item);
				seq_item.main_start=1;
				finish_item(seq_item);
				for(int j=0;j<3046;j++)begin
					start_item(seq_item);
					seq_item.main_start=0;
					finish_item(seq_item);
				end
			end
		endtask : body
	endclass : CNN_main_seq
endpackage : CNN_main_seq_pkg