package CNN_env_pkg;
import CNN_agent_pkg::*;
import CNN_coverage_pkg::*;
import CNN_scoreboard_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class CNN_env extends uvm_env;
	`uvm_component_utils(CNN_env)

	CNN_agent agt;
	CNN_coverage cov;
	CNN_scoreboard sb;
	function new(string name="CNN_env", uvm_component parent = null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agt= CNN_agent::type_id::create("agt",this);
		cov=CNN_coverage::type_id::create("cov",this);
		sb=CNN_scoreboard::type_id::create("sb",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		agt.agt_ap.connect(cov.cov_export);
		agt.agt_ap.connect(sb.sb_export);
	endfunction
endclass : CNN_env
endpackage : CNN_env_pkg