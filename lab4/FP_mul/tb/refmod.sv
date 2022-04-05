class refmod extends uvm_component;
    `uvm_component_utils(refmod)
    
    packet_in tr_in;
    packet_out tr_out;
    uvm_get_port #(packet_in) in;
    uvm_put_port #(packet_out) out;

	int count = 0;
	bit [2:0][31:0] data_out;
    
    function new(string name = "refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
		for(int i = 0; i < 3; i++) begin
			data_out[i] = 'x;
		end
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = packet_out::type_id::create("tr_out", this);
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
		in.get(tr_in);
			for(int i = 2; i > 0; i--) begin
				data_out[i] = data_out[i-1];
			end
		data_out[0] = $shortrealtobits($bitstoshortreal(tr_in.A) * $bitstoshortreal(tr_in.B));

		// this statement checks if the output of the multiplication is a denormal number, since the multiplier under test gives 0 as output if the
		// output is a denormal number
		if(($bitstoshortreal(data_out[0]) > 0 && $bitstoshortreal(data_out[0]) < $bitstoshortreal(32'h00800000)) || ($bitstoshortreal(data_out[0]) < 0 && $bitstoshortreal(data_out[0]) > $bitstoshortreal(32'h80800000)))
			data_out[0] = 32'h00000000;

		$display("---------- Simulation %d ----------", count);
		$display("refmod: input A = %f, input B = %f, output OUT = %f",$bitstoshortreal(tr_in.A), $bitstoshortreal(tr_in.B), $bitstoshortreal(data_out[0]));
		$display("refmod: input A = %b, input B = %b, output OUT = %b",tr_in.A, tr_in.B, data_out[0]);
		count++;
		tr_out.data = data_out[2];
		out.put(tr_out);
        end
    endtask: run_phase
endclass: refmod
