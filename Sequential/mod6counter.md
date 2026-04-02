# MOD-6 Ripple Counter Using T Flip-Flops (Verilog) — Complete Explanation

This document explains the Verilog implementation of a **MOD-6 ripple counter using T flip-flops** step by step. It includes the working of each module, reset logic, ripple behavior, and simulation/testbench explanation.

---

# 1. T Flip-Flop Module (`tff`)

```verilog
module tff (output reg q, input t, input clk, input rst);
```

This defines a **T flip-flop with asynchronous reset**.

---

## Asynchronous Reset Block

```verilog
always @ (posedge rst) begin
    if (rst) q = 0;
end
```

Meaning:

* Whenever `rst = 1`
* Output immediately becomes

```
q = 0
```

This reset does **not depend on the clock**, therefore it is called an **asynchronous reset**.

---

## Clock Triggered Block

```verilog
always @ (posedge clk)
```

This block executes when a **positive edge of clock** occurs.

```verilog
if (~rst)
```

The flip-flop operates only when reset is **inactive**.

---

## Toggle Logic of T Flip-Flop

```verilog
if (t)
    q <= ~q;
else
    q <= q;
```

Rule of a T flip-flop:

| T | Next State |
| - | ---------- |
| 0 | No change  |
| 1 | Toggle     |

Since in the testbench:

```verilog
t = 1;
```

The flip-flop toggles on every clock edge.

So effectively:

```
q toggles every clock pulse
```

This behaves like a **frequency divider by 2**.

---

# 2. Ripple Counter Module (`ripplecounter`)

```verilog
module ripplecounter(clk,t,q,rst,ffrst);
```

Inputs:

```
clk  → main clock input
 t   → toggle control input
 rst → external reset
```

Outputs:

```
q[2:0] → 3-bit counter output
ffrst  → internal reset signal
```

---

# 3. Flip-Flop Connections

### First Flip-Flop

```verilog
tff tf1(q[0], t, clk, ffrst);
```

Clock source:

```
clk
```

Meaning:

```
q[0] toggles every clock pulse
```

---

### Second Flip-Flop

```verilog
tff tf2(q[1], t, ~q[0], ffrst);
```

Clock source:

```
~q[0]
```

Meaning:

```
q[1] toggles when q[0] transitions
```

This produces ripple behavior.

---

### Third Flip-Flop

```verilog
tff tf3(q[2], t, ~q[1], ffrst);
```

Clock source:

```
~q[1]
```

Meaning:

```
q[2] toggles when q[1] transitions
```

---

### Result

Each flip-flop depends on the previous flip-flop output instead of the main clock.

Therefore this is called an:

```
Ripple Counter (Asynchronous Counter)
```

---

# 4. MOD-6 Logic (Important Section)

```verilog
assign #1 ffrst = rst | (q[2] & q[1]);
```

Meaning:

```
ffrst = external reset OR internal reset condition
```

Internal reset condition:

```
q[2] & q[1]
```

Binary condition:

| q2 | q1 | Reset |
| -- | -- | ----- |
| 1  | 1  | YES   |

This happens at:

```
110 (decimal 6)
```

So counter resets at **6**.

Therefore counting sequence becomes:

```
000
001
010
011
100
101
RESET
```

Hence:

```
MOD-6 Counter
```

---

# 5. Why `#1` Delay is Used

```verilog
assign #1 ffrst = ...
```

Adds **1 time-unit delay**.

Purpose:

Prevents race condition between:

```
flip-flop state update
and
reset triggering
```

Mostly useful in simulation.

---

# 6. Testbench Module (`tb`)

The testbench simulates the behavior of the ripple counter.

---

## Clock Generation

```verilog
initial
clk = 0;

always
#5 clk = ~clk;
```

Clock period:

```
10 time units
```

---

## Reset and Toggle Input Control

```verilog
initial
begin
```

Initial settings:

```
rst = 0
 t = 1
```

So counter starts toggling immediately.

---

### First Reset Pulse

```verilog
#10 rst = 1;
#10 rst = 0;
```

Applies reset briefly.

---

### Second Reset Pulse

```verilog
#100 rst = 1;
#10 rst = 0;
```

Simulates reset during operation.

---

### Simulation Stop

```verilog
#30 $finish;
```

Stops simulation.

---

# 7. Waveform Dump Commands

```verilog
$dumpfile("Mod6Counter.vcd");
$dumpvars;
```

Used for:

```
GTKWave visualization
```

Shows signal transitions during simulation.

---

# 8. Monitor Statement

```verilog
$monitor("time=%g, rst=%b, clk=%b, t=%b, q=%d ffrst=%b",
```

Prints values whenever signals change.

Example output:

```
time=20 rst=0 clk=1 t=1 q=3 ffrst=0
```

Displays:

```
current time
reset state
clock state
toggle input
counter value
internal reset signal
```

---

# 9. Overall Working Summary

Your design:

✔ Uses **3 T flip-flops**

✔ Creates **asynchronous ripple counter**

✔ Detects state **110**

✔ Resets automatically

✔ Produces **MOD-6 counting sequence**

Counting pattern:

```
0 → 1 → 2 → 3 → 4 → 5 → RESET → repeat
```

---

# 10. Recommended Improvement (Industry Standard Practice)

Instead of:

```verilog
always @(posedge rst)
```

Better approach:

```verilog
always @(posedge clk or posedge rst)
```

Improved implementation example:

```verilog
always @(posedge clk or posedge rst)
begin
    if (rst)
        q <= 0;
    else if (t)
        q <= ~q;
end
```

This version:

✔ avoids synthesis warnings

✔ matches FPGA-friendly design style

✔ preferred in interviews and industry projects

---

# Final Conclusion

This Verilog design successfully implements a **MOD-6 ripple counter using T flip-flops** where:

* each flip-flop toggles based on the previous stage
* asynchronous reset forces counter restart at state 6
* simulation verifies correct counter operation

This is a strong foundational example of **asynchronous counters in digital electronics**.
