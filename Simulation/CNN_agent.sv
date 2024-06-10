package CNN_agent_pkg;
import CNN_config_pkg::*;
import CNN_driver_pkg::*;
import CNN_sqr_pkg::*;
import CNN_monitor_pkg::*;
import CNN_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class CNN_agent extends uvm_agent;
   `uvm_component_utils(CNN_agent)
   CNN_sqr sqr;
   CNN_driver drv;
   CNN_monitor mon;
   CNN_config CNN_cfg;
   uvm_analysis_port #(CNN_seq_item) agt_ap;

   function new(string name = "CNN_agent", uvm_component parent=null);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db #(CNN_config)::get(this, "", "CFG", CNN_cfg))
         `uvm_fatal("Build Phase", {"Unable to get configuration object for ", get_full_name(), " in ", get_parent().get_full_name()});
      sqr = CNN_sqr::type_id::create("sqr", this);
      drv = CNN_driver::type_id::create("drv", this);
      mon = CNN_monitor::type_id::create("mon", this);
      agt_ap = new("agt_ap", this);
   endfunction : build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      drv.CNN_vif = CNN_cfg.CNN_vif;
      mon.CNN_vif = CNN_cfg.CNN_vif;

        drv.seq_item_port.connect(sqr.seq_item_export);
        mon.mon_ap.connect(agt_ap);
   endfunction : connect_phase
endclass : CNN_agent
endpackage : CNN_agent_pkg