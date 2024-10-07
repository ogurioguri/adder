/* ACM Class System (I) Fall Assignment 1 
 *
 * Implement your naive adder here
 * 
 * GUIDE:
 *   1. Create a RTL project in Vivado
 *   2. Put this file into `Sources'
 *   3. Put `test_adder.v' into `Simulation Sources'
 *   4. Run Behavioral Simulation
 *   5. Make sure to run at least 100 steps during the simulation (usually 100ns)
 *   6. You can see the results in `Tcl console'
 *
 */

module adder_4(
	input [3:0] a,
	input [3:0] b,
	input carry_in,
	output [3:0] answer,
	output carry
);
    wire [3:0] p; 
    wire [3:0] g; 
    wire [3:0] c; 

    assign p = a ^ b;
    assign g = a & b;

    assign c[0] = carry_in;
    assign c[1] = g[0] | (p[0] & carry_in);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[0] & carry_in);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[1] & (g[0] | (p[0] & carry_in)));
    assign carry_out = g[3] | (p[3]&(g[2]|(p[2]&(g[1]|(p[1]&(g[0]|(p[0]&carry_in)))))));
    assign sum = p ^ c[3:0];
	
endmodule

module adder(
	// TODO: Write the ports of this module here
	//
	// Hint: 
	//   The module needs 4 ports, 
	//     the first 2 ports are 16-bit unsigned numbers as the inputs of the adder
	//     the third port is a 16-bit unsigned number as the output
	//	   the forth port is a one bit port as the carry flag
	// 
	input [15:0] a,
	input [15:0] b,
	output [15:0] answer,
	output carry
);
	// TODO: Implement this module here

	wire [3:0] carry;
	adder_4 adder_4_0(
		.a(a[3:0]),
		.b(b[3:0]),
		.carry_in(1'b0),
		.answer(answer[3:0]),
		.carry(carry[0])
	);

	adder_4 adder_4_1(
		.a(a[7:4]),
		.b(b[7:4]),
		.carry_in(carry[0]),
		.answer(answer[7:4]),
		.carry(carry[1])
	);

	adder_4 adder_4_2(
		.a(a[11:8]),
		.b(b[11:8]),
		.carry_in(carry[1]),
		.answer(answer[11:8]),
		.carry(carry[2])
	);

	adder_4 adder_4_3(
		.a(a[15:12]),
		.b(b[15:12]),
		.carry_in(carry[2]),
		.answer(answer[15:12]),
		.carry(carry[3])
	);

	assign carry = carry[3];


	
endmodule
