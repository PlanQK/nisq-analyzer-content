OPENQASM 2.0;
include "qelib1.inc";
qreg q[5];
creg c[3];
h q[0];
h q[1];
h q[1];
cu1(0) q[1],q[0];
h q[0];
h q[2];
cx q[2],q[3];
cx q[2],q[4];
cu1(0) q[1],q[2];
cu1(0) q[0],q[2];
h q[2];
measure q[0] -> c[0];
measure q[1] -> c[1];
measure q[2] -> c[2];