package CNN_seq_item_pkg; 
	import uvm_pkg::*;
`include "uvm_macros.svh"
	class CNN_seq_item extends uvm_sequence_item;
		`uvm_object_utils(CNN_seq_item)
		  bit rst,main_start;
		  bit [7:0] seg_final;
		  logic signed [7:0] firstmem [0:2503];
  		  function new(string name= "CNN_seq_item");
  		  	super.new(name);
  		  endfunction : new

  		  function string convert2string();
  		  	return $sformatf("%s rst=0b%0b, main_start=0b%0b, seg final=0b%0b"
  		  		,super.convert2string(),rst,main_start,seg_final);
  		  endfunction

  		  function string convert2string_stimulus();
  		  	return $sformatf("%s rst=0b%0b, main_start=0b%0b, seg final=0b%0b"
				,super.convert2string(),rst,main_start,seg_final);
  		endfunction : convert2string_stimulus
  	endclass : CNN_seq_item
  endpackage : CNN_seq_item_pkg
