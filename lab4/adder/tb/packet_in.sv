class packet_in extends uvm_sequence_item;
    rand bit [15:0] A;
    rand bit [15:0] B;

	// constraint my_range_A { A > 100; A < 1000; }
	// constraint my_range_B { B < A/10; }

    `uvm_object_utils_begin(packet_in)
        `uvm_field_int(A, UVM_ALL_ON|UVM_HEX)
        `uvm_field_int(B, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

    function new(string name="packet_in");
        super.new(name);
    endfunction: new
endclass: packet_in
