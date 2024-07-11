# PhaseFieldOxides
MOOSE app modeling oxide dynamics for a Summer Internship

## Overview

This MOOSE project solves the Cahn-Hilliard equation to examine the effects of different mobility values on the phase separation process. The simulations were performed using the MOOSE framework.

# Model Parameters

## Energy Density Expression

The energy density expression used in these simulations is given by: 
$$
F(c) = c \log(c) + (1 - c) \log(1 - c) + Wc(1 - c)
$$

The parameter \( W \) varies according to the mobility to ensure convergence.

## Tested Mobility Values and Corresponding \( W \) Values

| Mobility Type | Mobility Values | Corresponding \( W \) Values |
| ------------- | --------------- | --------------------------- |
| Isotropic Constant Mobility | \( M = 0.1 \) | \( W = 3.7 \) |
|  | \( M = 0.2 \) | \( W = 3.2 \) |
|  | \( M = 0.4 \) | \( W = 2.7 \) |
|  | \( M = 0.6 \) | \( W = 2.7 \) |
|  | \( M = 0.8 \) | \( W = 2.5 \) |
| Anisotropic Constant Mobility | \( M_x = 0.1, M_y = 0.2 \) | \( W = 3.5 \) |
|  | \( M_x = 0.1, M_y = 0.4 \) | \( W = 3.1 \) |
|  | \( M_x = 0.1, M_y = 0.8 \) | \( W = 2.7 \) |
|  | \( M_x = 0.2, M_y = 0.3 \) | \( W = 3.1 \) |
|  | \( M_x = 0.3, M_y = 0.2 \) | \( W = 3.1 \) |
| Composite Mobility | \( M_iso = 0.1, M_x = 0.2, M_y = 0.2 \) | \( W = 3.7 \) |
|  | \( M_iso = 0.1, M_x=0.1, M_y = 0.4 \) | \( W = 3.1 \) |
|  | \( M_iso = 0.1, M_x=0.1, M_y = 0.8 \) | \( W = 2.7 \) |
|  | \( M_iso = 0.1, M_x=0.2, M_y = 0.3 \) | \( W = 3.1 \) |
|  | \( M_iso = 0.1, M_x=0.3, M_y = 0.2 \) | \( W = 3.1 \) |
| Effective Mobility | \(Troubleshooting\) |

### Preconditioners and Solve Types

- **Preconditioner**: Single Matrix Preconditioner (SMP)
- **Solve Type**: Preconditioned Jacobian-Free Newton-Krylov (PJFNK)

### Execution Parameters
- **Scheme**: BDF2 (Second-order Backward Differentiation Formula)
- **Linear Solver Maximum Iterations**: 150
- **Linear Solver Tolerance**:  1e-6 
- **Nonlinear Solver Maximum Iterations**: 20
- **Nonlinear Solver Absolute Tolerance**:  1e-9 
- **End Time**: 10
- **Time Step**: 0.2, To generate 50 images