# ftpg

A Lean 4 / Mathlib proof of the **fundamental theorem of projective geometry**, in its
lattice-theoretic form, with no `sorry` and no axioms beyond Lean's standard three
(`propext`, `Classical.choice`, `Quot.sound`). It also includes a proof that the
completeness hypothesis cannot be dropped.

## The theorems

**`ftpg_proof_limit : ftpg_statement_limit`.** Let `L` be a complete lattice that is
modular, complemented, and compactly generated. Suppose `L` is irreducible (every line
through two distinct atoms contains a third atom) and has height at least 4 (a chain
`⊥ < a < b < c < d`). Then there is a division ring `D` and a `D`-vector space `V`
with

```
L ≃o Submodule D V
```

**`ftpg_proof_finite : ftpg_statement_finite`.** The same conclusion for a bounded
lattice that is modular, complemented, and atomistic, irreducible, of height at least
4, and of finite Krull dimension. This is derived from the limit form
(`ftpg_finite_of_limit`): finite height implies completeness and compact generation.

**`not_ftpg_statement`.** Without completeness or finite height, the statement is
false. The lattice of subspaces of `(ℕ ⊕ ℕ) →₀ ℚ` that are finite-dimensional or of
finite codimension is complemented, modular, atomistic, irreducible, and of height at
least 4, but it is not complete (`hollow_no_lub`). Every `Submodule D V` is complete,
so no such isomorphism exists.

The hypotheses of the limit form are tight, one counterexample family each:
non-Desarguesian planes are excluded by the height condition, continuous geometries by
compact generation, and the lattice above by completeness.

## The construction

The division ring is built from the lattice itself, by the von Staudt–von Neumann
coordinatization. A coordinate frame (`coordFrame_exists`) is found from irreducibility
and height alone. Addition and multiplication are defined by incidence on a line, and
each field law is proven from Desargues' theorem. Planar Desargues is itself proven from
the modular law by lifting the configuration out of the plane, which is what height ≥ 4
provides (`desargues_planar`; `Bridges/FTPG/Instance.lean` assembles `DivisionRing`). Then a
Veblen–Young coordinatization (`pointSystem_exists`) assigns atoms to projective points
over the opposite ring: first the plane, then 3-space, then finite-dimensional windows,
then a directed limit over all of `L`.

`Bridges/FTPG/README.md` is the original working log, file by file.

## Building

```
lake exe cache get
lake build
```

Lean `v4.31.0`, Mathlib `v4.31.0`. `Audit.lean` checks the axiom dependencies of the
three headline theorems at build time, and every file under `Bridges/FTPG/` carries its
own `#guard_msgs` axiom receipts.

## Provenance

This was developed inside [`lightward/foam`](https://github.com/lightward/foam), a
broader project whose vocabulary shows up in the docstrings and comments. Every file
under `Bridges/` is **byte-identical** to `lightward/foam` at commit
[`91b62c0f`](https://github.com/lightward/foam/tree/91b62c0f/bridges/Bridges/FTPG)
(2026-07-08), which is why the module paths are `Bridges.FTPG.*` and the namespace is
`Foam.Bridges`. To verify, from a checkout of `foam` next to this repo:

```
git -C foam checkout 91b62c0f
(cd ftpg && find Bridges -type f) | while read f; do cmp "foam/bridges/$f" "ftpg/$f"; done
```

No output means every file matches.

The proof was completed at
[`cf0e8135`](https://github.com/lightward/foam/commit/cf0e8135) and the classical
axiom it replaced was retired at
[`91b62c0f`](https://github.com/lightward/foam/commit/91b62c0f). Work on it began in
April 2026. The full commit messages there are the most detailed account of the climb.

Two notes on what's in the archive:

- `Bridges/FTPG/Hollow.lean` still declares the retired `axiom ftpg` (the statement
  without completeness, which is false). It is used only by `ftpg_refuted : False`,
  as an exhibit; the main theorems do not depend on it, as `Audit.lean` checks.
- `Charge.lean` from the same directory is left out. It depends on foam's core and
  isn't part of the proof.
- New here: this README, `Audit.lean`, the root `Bridges.lean` import list, and the
  build files. `lake-manifest.json` is foam's `bridges` manifest with the `foam`
  dependency removed, so the Mathlib pin is the one the proof was checked against.

Isaac Bowen, with Claude (Opus 4.8 and Fable 5).

Public domain ([UNLICENSE](UNLICENSE)).
