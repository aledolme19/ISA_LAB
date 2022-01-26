In this section, we are performing two different logic synthesis of the fine grain pipeline structure, using a MBE multiplier:
   -Logic Synthesis with compile and optmize_register commands;
    -Logic Synthesis with compile ultra command;

The different folders are organized as usual.
Moreover, both in syn and in netlist/results folders we have two different scripts and two 
different sets of results for each of the three synthesis:

- no CLK pedix present :  just to find the maximum clock frequency of our design, forcing a 0 ns
 clock period. 
- CLK pedix present: we are synthetizing with 0 ns clock, but imposing the proper clock period in order to
find more accurate power's results;

Two main cases were considered:
	- multiplier with only 1 pipeline register
	- multiplier with 2 pipeline registers
In both cases syntheses without ungroup attribute, ungrouping only the MBE multiplier and ungrouping all the architecture were performed.