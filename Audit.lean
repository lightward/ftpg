import Bridges

/-!
# Audit

The headline results, with their axiom dependencies checked at build time.
`lake build` fails if any of these depend on anything beyond Lean's three
standard axioms (in particular: on `sorryAx`, or on the retired `axiom ftpg`
kept as an exhibit in `Bridges/FTPG/Hollow.lean`).

This file is new to the archive; everything under `Bridges/` is byte-identical
to `lightward/foam` at commit `91b62c0f`.
-/

open Foam.Bridges

/-! ## The fundamental theorem, two forms -/

-- Complete, modular, complemented, compactly generated, irreducible, height ≥ 4
-- ⟹ order-isomorphic to the subspace lattice of a vector space over a division ring.
example : ftpg_statement_limit := ftpg_proof_limit

-- Lattice, bounded, modular, complemented, atomistic, irreducible, height ≥ 4,
-- finite Krull dimension ⟹ the same conclusion.
example : ftpg_statement_finite := ftpg_proof_finite

/-- info: 'Foam.Bridges.ftpg_proof_limit' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ftpg_proof_limit

/-- info: 'Foam.Bridges.ftpg_proof_finite' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms ftpg_proof_finite

/-! ## Completeness cannot be dropped -/

-- Without completeness (and finite height), the statement is false: the lattice of
-- finite-dimensional-or-finite-codimensional subspaces of `(ℕ ⊕ ℕ) →₀ ℚ` satisfies
-- every other hypothesis and is not complete.
/-- info: 'Foam.Bridges.not_ftpg_statement' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms not_ftpg_statement
