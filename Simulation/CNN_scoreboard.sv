package CNN_scoreboard_pkg;
import CNN_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class CNN_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(CNN_scoreboard)
    uvm_analysis_port #(CNN_seq_item) sb_export;
    uvm_tlm_analysis_fifo #(CNN_seq_item) sb_fifo;
    CNN_seq_item seq_item_sb;
    bit signed [18:0] max_old=0, max_new,min_new,min_old=0,max_value;
    int error_count=0;
    int correct_count=0;
	function new(string name="CNN_scoreboard", uvm_component parent = null);
		super.new(name,parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
        sb_export=new("sb_export",this);
        sb_fifo=new("sb_fifo",this);
	endfunction : build_phase

	function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sb_export.connect(sb_fifo.analysis_export);
	endfunction : connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
           sb_fifo.get(seq_item_sb);
           //max_num(seq_item_sb);
        end
        //`uvm_info(get_type_name(),$sformatf("MAX POSITIVE= %d, MAX NEGATIVE=  %h",max_new,min_new),UVM_LOW);
    endtask : run_phase
    /*task max_num(CNN_seq_item sb_seq_item);
        max_old=max_new;
        if(($signed(sb_seq_item.quant1layer1)>$signed(sb_seq_item.quant2layer1)) && ($signed(sb_seq_item.quant1layer1)>$signed(sb_seq_item.quant3layer1)) &&
        ($signed(sb_seq_item.quant1layer1)>$signed(sb_seq_item.quant4layer1)) && ($signed(sb_seq_item.quant1layer1)>$signed(max_old)))
            max_new=sb_seq_item.quant1layer1;
        else if(($signed(sb_seq_item.quant2layer1)>$signed(sb_seq_item.quant3layer1)) && ($signed(sb_seq_item.quant2layer1)>$signed(sb_seq_item.quant4layer1)) 
            && ($signed(sb_seq_item.quant2layer1)>$signed(max_old)))
            max_new=sb_seq_item.quant2layer1;
        else if (($signed(sb_seq_item.quant3layer1)>$signed(sb_seq_item.quant4layer1)) && ($signed(sb_seq_item.quant3layer1>max_old)))
            max_new=sb_seq_item.quant3layer1;
        else if(($signed(sb_seq_item.quant4layer1)>$signed(max_old)))
            max_new=sb_seq_item.quant4layer1;
        else
            max_new=max_old;

            min_old=min_new;
        if(($signed(sb_seq_item.quant1layer1)<$signed(sb_seq_item.quant2layer1)) && ($signed(sb_seq_item.quant1layer1)<$signed(sb_seq_item.quant3layer1)) &&
        ($signed(sb_seq_item.quant1layer1)<$signed(sb_seq_item.quant4layer1)) && ($signed(sb_seq_item.quant1layer1)<$signed(min_old)))
            min_new=sb_seq_item.quant1layer1;
        else if(($signed(sb_seq_item.quant2layer1)<$signed(sb_seq_item.quant3layer1)) && ($signed(sb_seq_item.quant2layer1)<$signed(sb_seq_item.quant4layer1)) 
            && ($signed(sb_seq_item.quant2layer1)<$signed(min_old)))
            min_new=sb_seq_item.quant2layer1;
        else if (($signed(sb_seq_item.quant3layer1)<$signed(sb_seq_item.quant4layer1)) && ($signed(sb_seq_item.quant3layer1<min_old)))
            min_new=sb_seq_item.quant3layer1;
        else if(($signed(sb_seq_item.quant4layer1)<$signed(min_old)))
            min_new=sb_seq_item.quant4layer1;
        else
            min_new=min_old;
      
        

    endtask
      */
endclass : CNN_scoreboard
endpackage : CNN_scoreboard_pkg