
package CNN_monitor_pkg;
import CNN_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class CNN_monitor extends uvm_monitor;
   `uvm_component_utils(CNN_monitor)
virtual CNN_if CNN_vif;
virtual CNN_G_if CNN_G_vif;
    CNN_seq_item rsp_seq_item;
   uvm_analysis_port #(CNN_seq_item) mon_ap;
   
   

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon_ap = new("mon_ap", this);
   endfunction : build_phase

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
         rsp_seq_item = CNN_seq_item::type_id::create("rsp_seq_item");
         @(negedge CNN_vif.clk);
         rsp_seq_item.rst = CNN_vif.rst;
         rsp_seq_item.main_start = CNN_vif.main_start;
         rsp_seq_item.seg_final = CNN_vif.seg_final;
         rsp_seq_item.firstmem=CNN_vif.firstmem;
         mon_ap.write(rsp_seq_item);
        `uvm_info("run_phase",rsp_seq_item.convert2string(),UVM_HIGH)
      end
   endtask : run_phase
endclass : CNN_monitor
endpackage : CNN_monitor_pkg