package CNN_config_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
class CNN_config extends uvm_object;
`uvm_object_utils(CNN_config)

virtual CNN_if CNN_vif;


function new( string name="CNN_config");
	super.new(name);
endfunction : new
endclass : CNN_config
endpackage : CNN_config_pkg
