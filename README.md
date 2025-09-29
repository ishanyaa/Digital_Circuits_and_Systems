# Digital Circuits and Systems-ECS 326/676

## Course Information

| **Course** | Digital Circuits and Systems |
| :--- | :--- |
| **Course Code** | ECS 326/676 |
| **Course Instructor** | [Dr. Santanu Talukder](https://sites.google.com/site/santanutalukderiiscnanoscience/principal-investigator) |
| **Teaching Assistant** | Ishanya |
| **Email** | [ishanya21@iiserb.ac.in](mailto:ishanya21@iiserb.ac.in) |
| **Department** | [Electrical Engineering and Computer Science](https://eecs.iiserb.ac.in/) |
| **Institute** | [Indian Institute of Science Education and Research, Bhopal](https://www.iiserb.ac.in/) |
| **Timeline** | Jan 2025 – Apr 2025 |

---

## Overview

This repository contains **Verilog practice questions and implementations** for the course *Digital Circuits and Systems (ECS 326/676)*.
The repository also includes the **course PPT** for reference: [Digital Circuits and Systems - Verilog PPT](https://github.com/ishanyaa/Digital_Circuits_and_Systems/blob/main/Ishanya_Verilog.pdf)

---

## Contents

The repository includes implementations of:

- **Basic logic gates and combinational circuits:** `and3.v`, `or3.v`, `fun.v`, `logic_function.v`  
- **Arithmetic modules:** `FA.v`, `HA.v`, `cla_4bit.v`, `comp_4bit.v`, `comparator_4bit.v`  
- **Multiplexers and decoders:** `mux2.v`, `mux2b.v`, `mux4.v`, `mux4b.v`, `decoder3to8.v`, `de2to4.v`, `en4to2.v`  
- **Flip-flops and sequential circuits:** `ardff.v`, `counter.v`, `d3.v`, `q4.v`, `srl.v`, `pe.v`  
- **Additional utility and practice files:** `fs.v`, `m2.v`, `SmilingSnail.v`, `bin/` folder containing Icarus Verilog binaries  

---

## Usage

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/ishanyaa/Digital_Circuits_and_Systems.git](https://github.com/ishanyaa/Digital_Circuits_and_Systems.git)
    ```
2.  **Navigate to the folder:**
    ```bash
    cd Digital_Circuits_and_Systems
    ```
3.  **Compile and simulate Verilog files** using Icarus Verilog or any Verilog simulator:
    ```bash
    iverilog -o output_file file.v
    vvp output_file
    ```
    *Note: The `bin/` folder contains Icarus Verilog binaries for convenience. Ensure your system paths are set correctly if using these directly.*

4.  Check out the **PPT** in the repository for guidance and explanations of each topic: [Digital Circuits and Systems - Verilog PPT](https://github.com/ishanyaa/Digital_Circuits_and_Systems/blob/main/Ishanya_Verilog.pdf)


---

## References

* **Course Material:** ECS 326/676 (2023-24) by Dr. Santanu Talukder
* **Related Course:** ECS 409/609 Computer Organization (2024-25)
* **Textbook:** *Digital Design* by Morris Mano (5th edition)
* **Textbook:** *Digital Design and Computer Architecture*, Chapter 4, by Sarah Harris and David Harris
* **External Resources:** YouTube and the Internet.
* https://paisimulation.blogspot.com/2020/02/running-verilog-code-using-visual.html
---

## Author

**Ishanya** –Senior Undergrad, Department of Electrical Engineering and Computer Science, IISER Bhopal

**Email:** [ishanya21@iiserb.ac.in](mailto:ishanya21@iiserb.ac.in)
