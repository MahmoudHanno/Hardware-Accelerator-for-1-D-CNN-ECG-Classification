package CNN_coverage_pkg;
	import CNN_seq_item_pkg::*;
	import uvm_pkg::*;
    `include "uvm_macros.svh"
	class CNN_coverage extends uvm_component;
		`uvm_component_utils(CNN_coverage)
    uvm_analysis_export #(CNN_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(CNN_seq_item) cov_fifo;
    CNN_seq_item cov_seq_item;
    covergroup cvr_grp;
        rst_cvp: coverpoint cov_seq_item.rst;
        main_start_cvp: coverpoint cov_seq_item.main_start;
        seg_final_cvp: coverpoint cov_seq_item.seg_final;
       
    endgroup : cvr_grp
    function new(string name, uvm_component parent);
      super.new(name, parent);
      cvr_grp = new();
    endfunction : new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      cov_export = new("cov_export", this);
      cov_fifo = new("cov_fifo", this);
      endfunction : build_phase

      function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
        endfunction : connect_phase

      task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            cov_fifo.get(cov_seq_item);
            cvr_grp.sample();
        end
      endtask : run_phase

	endclass 
endpackage : CNN_coverage_pkg