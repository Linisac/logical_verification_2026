
---

**2026-11-07**

### Review of the chapter 1 (redo) and chapter 2 exercises

Both sheets build clean (`lake build`). The only `sorry`s are the three
intended statement-only theorems: `simplify_correct`, `map_id`, `map_comp`.

- **Ch.1:** all six terms are fine. `projSnd` really is different from
  `projFst`. `someNonsense` ignores `f` and `b`, and the alternative noted
  in the comment also type-checks. The 8-step derivation of `C` is correct:
  every App step uses the same context, and the three Fun steps discharge
  `a`, `b`, `f` from the right of the context, as they should.
- **Ch.2 Q1/Q3:** `pred`, `map`, `map_id` and `map_comp` are all correct.
  `map_comp` is as general as `map` allows: three independent type
  variables. Truly universe-polymorphic statements would need
  `map` itself at `Type u`.
- **Ch.2 Q2.2 `simplify`:** every new rule preserves `eval`. Tested
  exhaustively on all 90,150 expressions of depth ≤ 2 over leaves
  {0, 1, −1, 2, x, z} under 3 environments: no counterexample. Two rules are
  *only* sound because of Lean's totalization convention, so they
  exercise exactly the issue flagged in the ch.2 briefing:
  `e / 0 ↦ 0` (true because `x / 0 = 0` in ℤ, not mathematically) and,
  less obviously, `0 / e ↦ 0`, which is true even when `e` evaluates to 0
  only because of the same convention. Leaving out `0 - e` was correct,
  since subtraction isn't commutative.
- **Nits:** Q2.1 asks "what happens if you divide by zero?". The `#eval`
  shows 0, but write the answer as a comment. Lean style is camelCase for
  defs (`aexpAddXY`, not `aexp_add_xy`), and continuation lines of a theorem
  statement are indented 4 spaces.

---

**2026-11-08**

### Review of the chapter 1 and chapter 2 homework sheets

Both build clean. The only `sorry`s are the five intended statement-only
theorems in ch.2.

- **Ch.1 1.1/1.2:** all seven terms are correct (Lean type-checks them).
  `weakPeirce` is right: the trick is to build `α → β` by sending `a` to
  `f (fun _ ↦ a)`. The constant function `fun _ ↦ a` inhabits
  `((α → β) → α) → α` without using its argument.
- **Ch.1 2.1 (`B`):** correct derivation.
- **Ch.1 2.2 (`S`):** step order and rule use are correct. **Typo in step
  8**: `f : (α → b → γ)` has a lowercase `b`, a term variable rather than a
  type. As written, the judgment isn't well formed. It should be
  `α → β → γ`.
- **Both derivations, a rigour point:** the lambdas lost their binder
  annotations (`fun g ↦ …` instead of `fun g : γ ↦ …`). In the book's
  system, the Fun rule's conclusion is `Γ ⊢ (fun x : σ ↦ t) : σ → τ`, with
  σ read off the binder. Unannotated terms need type *inference*, which is
  a different (and harder) problem. Steps like 7's `fun f g ↦ …` are also
  multi-binder sugar for `fun f : γ → α ↦ fun g : γ ↦ …`. The ch.1 exercise
  version had the annotations. Keep them.
- **Ch.1 naming nit:** the sheet asks for `a : α`, `b : β`, `c : γ`.
  Calling an element of `γ` `g` (in `B`, `nonsense1`, `nonsense3`) makes it
  read like a function.
- **Ch.2:** `snoc`, `minusTwo`, `sum` and all five theorem statements are
  correct. Nits: `append_append` names the *shape* of the statement, not
  the *property*. Lean core and mathlib call it `append_assoc` (cf.
  `List.append_assoc`, `List.reverse_append`). Also add `-- expected:`
  comments to your own `#eval` tests, so a wrong output stands out.

### Q&A: type checking vs. type inference

They are two different *problems* about the same judgment `Γ ⊢ t : σ`:

- **Type checking:** given `Γ`, `t` **and** `σ`, decide whether
  `Γ ⊢ t : σ` is derivable. Output: yes/no.
- **Type inference:** given `Γ` and `t` only, *find* a `σ` with
  `Γ ⊢ t : σ`, or report that none exists. Output: a type.

**Why binder annotations decide which problem you're solving.** With
annotated binders (Church-style λ-calculus, the book's ch.1 system), every
rule is syntax-directed. The type in each conclusion is determined by the
types in the premises, and the Fun rule reads σ off `fun x : σ ↦ t`. So
inference is a simple bottom-up computation, and checking is "infer, then
compare". The term alone determines its derivation.

Unannotated (Curry-style), `fun x ↦ x` has *infinitely many* types: `σ → σ`
for every σ. Nothing in the term tells the Fun rule which σ to use. Then:
- inference must invent an unknown for `x`'s type and solve the constraints
  the term generates by unification. (Hindley–Milner does this for ML and
  returns a principal type `?a → ?a`.)
- a derivation for an unannotated term contains types that aren't in the
  term. It's a certificate for a different system, which is why the
  ch.1 homework derivations should carry annotations.

**What Lean does.** Lean's *elaborator* is bidirectional. When an expected
type is available it pushes it inward (checking mode). Otherwise it infers,
creating metavariables `?m` for anything missing (omitted binder types, `_`,
implicit arguments) and solving them by unification. The output is a fully
annotated Church-style term, and that is all the *kernel* ever sees. Checked
with this repo's toolchain:

    #check fun (x : Nat) ↦ x          -- fun x => x : ℕ → ℕ        (inferred)
    #check fun x ↦ x                  -- fun x => x : ?m.1 → ?m.1  (unsolved metavariable)
    example : Nat → Nat := fun x ↦ x  -- fine: expected type supplies x : ℕ (checking)
    #eval reverse []                  -- error: don't know how to synthesize
                                      --   implicit argument `α`

The last one is exactly why ch.2 HW 4.1 writes `reverse ([] : List ℕ)`.
Your `def B : (α → β) → … := fun h f c ↦ …` also elaborates without
annotations only because the signature supplies the expected type.

(Footnote for the logician: for simple type theory both problems are
decidable, book §1.3. In dependent type theory, checking needs to decide
*definitional equality*, since a term can have type `σ` and be checked
against `σ'` with `σ ≡ σ'` only up to computation. That's where the
difficulty lives. Lean's full defeq is in fact known to be undecidable in
corner cases, and the elaborator/kernel use incomplete but practical
algorithms.)

### Re-check of homework edits

- Ch.1 2.2 (`S`): fixed. Typo gone, all binders annotated and fully
  curried. ✔
- Ch.1 2.1 (`B`): **not yet updated**. It still uses `g : γ` (the term now
  says `c`) and unannotated `fun g ↦ …`, `fun f g ↦ …`.
- Ch.1 names (`c : γ`): fixed. ✔ Ch.2 `append_assoc`, `-- expected:`
  comments: fixed. ✔ Both sheets still build clean.

- Ch.1 2.1 (`B`): fixed on the third pass. Renamed to `c : γ`, binders
  annotated, and the body in steps 6–8 corrected from `h (f g)` to
  `h (f c)`. (The leftover `g` was a free variable, so those three
  judgments weren't derivable.) ✔ **Chapters 1–2 closed.**

---

**2026-11-08**

## Chapter 3: Backward Proofs

(Book pp.23–36.) You know backward proof, natural deduction and
intro/elim rules cold, so this briefing covers only Lean's *mechanics* and
the places where your HOL4 instincts will mislead you. Every behavioural
claim below was checked against this repo's toolchain.

**1. Definitional equality lives inside the logic.** This is the biggest
change from HOL4. In HOL4 a definition is just a theorem you rewrite with,
and `REFL_TAC` needs α-equivalence. In Lean, `rfl`, `exact`, `apply` and
unification all work *up to computation*: β, δ (unfold definitions),
ι (match/recursor reduction), ζ (`let`), η. So
`example : add 2 2 = 4 := by rfl` goes through with no lemmas at all.
"By definition" steps cost nothing. The flip side is that `exact h` can
succeed even when the goal and `h` look different on screen.

**2. Tactics build proof terms. The goal *is* a typed hole.** If you think
in Agda terms: `Γ ⊢ P` is a metavariable `?g : P` in context `Γ`.
- `intro h` fills it with `fun h ↦ ?g'`.
- `apply f` fills it with `f ?_ … ?_`, and each `?_` becomes a new goal.
- `exact t` fills it completely.
- That's why `→` and `∀` have no named intro/elim rules (book p.30). They
  are both function types (Π-types). Introduction is `fun`, elimination
  is application, so `h 5` instantiates `h : ∀n, f n = n`.
- `¬a` is literally `a → False`, so `intro` works on a `¬` goal directly.
  You don't need `rw [Not]`.
- Ch.4 (propositions as types) makes this official. For now, read every
  tactic as "which term does this build?".

**3. False friends from HOL4.**
- **Lean `rw` is NOT HOL4 `rw`.** HOL4's `rw[]` is simp-based and
  exhaustive. Lean's `rw [h]` finds the *first* subterm matching `h`'s
  left-hand side, fixes `h`'s variables to that instance, rewrites every
  occurrence of *that instance*, and then tries only a cheap
  (reducible-transparency) `rfl`. Two checked consequences:
  - With `hf : ∀x, f x = x` on the goal `f a + f b = a + b`, `rw [hf]`
    rewrites `f a` only. You are left with `a + f b = a + b`.
  - With `h : n = 0`, `rw [h]` turns `add n 0 = 0` into `add 0 0 = 0` and
    stops. The cheap `rfl` won't unfold `add`. (The book's "will also apply
    `rfl`" means only this cheap version.)
  To rewrite at a particular spot, instantiate the lemma yourself, e.g.
  `rw [mul_comm _ l]`. Exercise 2.3 is built around exactly this.
- **Lean `simp` is the closer analogue of HOL4 `simp[]`/`rw[]`.** It
  rewrites to a normal form using the simp set plus whatever you list.
  Writing a definition's name, as in `simp [add]`, adds its defining
  equations. It does **not** use hypotheses unless you give them
  (`simp [h]`, `simp [*]`, `simp [*] at *`). A `simp` that changes nothing
  is an **error** ("simp made no progress"), not a no-op.
- Rough correspondences: `intro` ≈ `gen_tac`/`disch_tac`; `apply` ≈
  `irule`/`MATCH_MP_TAC`, but up to definitional equality; `exact` ≈
  `ACCEPT_TAC`; `assumption` ≈ `first_assum ACCEPT_TAC`.

**4. Metavariables in goals and unsafe `apply`.** `apply And.right` on
`⊢ b` gives `⊢ ?left.a ∧ b`. The `?left.a` is an unknown that the next
`exact hab` fills by unification. You may also see stray `⊢ Prop` goals
for such unknowns. Ignore them; they disappear once the unknown is filled.
To avoid metavariables altogether, take a small forward step:
`exact And.right hab`. `apply`, `Or.inl`/`Or.inr` and `Exists.intro` are
unsafe: they can leave you with a goal you can't prove, so backtrack.

**5. Syntax and layout.**
- Tactic blocks are whitespace-sensitive: one tactic per line, all at the
  same column under `by`.
- `·` focuses on the first goal and **must close it**. If it doesn't, you
  get an error at the bullet. Use bullets whenever more than one goal is
  open.
- Induction: `induction n with | zero => … | succ n' ih => …`. The case
  labels are constructor names. Note that the goals display as `0` and
  `n' + 1`, *not* `Nat.zero` and `Nat.succ n'` as the book text shows.
- `trace_state` prints the goals mid-proof. That's useful when you read
  errors from `lake build` rather than from VS Code's info view.

**6. Induction heuristic (the book's, and it's right).** Do induction on
the argument the function recurses on. In this book `add` and `mul`
recurse on their **second** argument. If the base case is hard, you
probably picked the wrong variable or need a lemma first. That's why the
sheet asks for `mul_zero` and `mul_succ` before `mul_comm`.

**Task:** `lean/LoVe/LoVe03_BackwardProofs_ExerciseSheet.lean`.
- Q1: connectives, using basic tactics only. 1.3 `forall_and` is flagged
  as tricky.
- Q2: induction on `mul`: `mul_zero`, `mul_succ`, `mul_comm`, `mul_assoc`,
  then `add_mul` by `rw`.
- Q3 (optional, recommended for you as a logician): EM → Peirce → DN,
  without `Classical`.
Build with `lake build LoVe.LoVe03_BackwardProofs_ExerciseSheet`.
