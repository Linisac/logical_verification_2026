
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

---

**2026-11-22**

### Review of the chapter 3 homework sheet

Builds clean and `sorry`-free. `#print axioms` on `EM_of_DN`,
`EM_of_Peirce`, `Peirce_of_DN`, `DN_of_EM`, `herman` and `weak_peirce`
reports **no axioms at all**: no `sorryAx`, no `Classical.choice`, no
`propext`. So the whole EM/Peirce/DN equivalence was proved
intuitionistically, as the sheet intends. The ch.3 exercise sheet is also
`sorry`-free.

- `EM_of_DN`: the standard proof, with the key move of using
  `hnaa : ¬(a ∨ ¬a)` twice. The part after `apply dn` is an intuitionistic
  proof of `¬¬(a ∨ ¬a)`. `herman` (`¬¬(¬¬a → a)`) is the same phenomenon:
  the double negation of each classical principle's instance is
  intuitionistically provable (Glivenko-style). `dn` itself is used only once.
- 2.4: each missing implication is a composite of two of the three base
  theorems, so the reasoning isn't circular.
- Style nits: the standard bullet is `·` (Lean also accepts `.`). Unused
  intro'd hypotheses (`haba'` in `weak_peirce`, `hnna'` in `herman`) are
  conventionally named `_`. `rw [Not]` / `rw [Not] at h` are never needed,
  since `¬p` is definitionally `p → False`, so `intro`/`apply`/`exact` see
  through it. `S` could be one line: `exact habc ha (hab ha)`.

### Q&A: typing `·`

In the Lean VS Code extension, type `\.` (or `\cdot`), followed by a space or
Tab, and it turns into `·`. This was verified against the abbreviation table
in the installed extension v0.0.242. System-wide on a US macOS keyboard,
Option+Shift+9 also gives `·` (U+00B7). Lean also accepts plain `.` as a
bullet.

### Q&A: does `herman` illustrate "classical ⇒ ¬¬ intuitionistic"?

Yes, but only for **propositional** logic. That's **Glivenko's theorem**: if
`P` is a classical *propositional* tautology, then `¬¬P` is intuitionistically
provable. `herman` (`¬¬(¬¬a → a)`) and the inner part of `EM_of_DN`
(`¬¬(a ∨ ¬a)`) are instances of it, each checked in Lean without axioms.
The usual proof shape: assume `¬P`, then use that hypothesis to refute
both the "positive" and the "negative" way `P` could hold. That's why `hnaa`
was used twice.

It **fails once quantifiers are involved**. `∀x, ¬¬(p x ∨ ¬p x)` is
intuitionistically provable, but moving the `¬¬` outside the `∀`
(`¬¬∀x, (p x ∨ ¬p x)`) needs the double-negation shift, which isn't
intuitionistically valid in general. Note that the sheet's
`ExcludedMiddle := ∀a : Prop, a ∨ ¬a` *is* such a quantified statement, so
Glivenko does not give you `¬¬ExcludedMiddle`. Only each instance is
covered. The uniform fix for first-order logic is a negative translation
(Gödel–Gentzen, or Kuroda's, which inserts `¬¬` after every `∀`) instead of
a single outer `¬¬`.

### Review of the chapter 3 exercise sheet

Builds clean and `sorry`-free. `Peirce_of_EM`, `DN_of_Peirce` and
`forall_and` use no axioms.

- **`proj_fst'` is actually the second projection.** `#print` shows
  `fun a ha => I a`, and `I a : a → a` returns the *second* argument. So
  it's `proj_snd` in disguise, not a variant of `proj_fst`. (The sheet's
  "different answer" request applies to `proj_snd`, which you did solve
  properly.) In `Prop` all proofs of the same statement are equal anyway
  (proof irrelevance, ch.12), so "different" only means a different proof
  *term*.
- `some_nonsense''` (intro only three, then `apply habc; exact ha`) is a
  nice η-reduced proof term `fun … ↦ habc ha`.
- `forall_and`: correct. Right-to-left uses `apply And.left hallpallq`,
  which unifies `∀x, p x` with `p x`. That's the forward step the hint
  meant.
- Q2: all correct. `add_mul` by `rw [mul_comm _ n, mul_add]` is exactly the
  intended "instantiate to aim the rewrite" trick: `mul ?x n` only matches
  the right-hand side's `mul (add l m) n`. `mul_comm` depends on `propext`
  and `Quot.sound` (introduced by `simp`). Those are *not* classical
  axioms; only `Classical.choice` is (ch.12).
- Layout nit: the usual Lean style for a multi-tactic case is to start a
  new line after `=>` and indent, rather than aligning continuation lines
  under the first tactic.
- You also filled in `SorryTheorems.EM_of_DN`, which is harmless and
  matches your homework proof.

---

**2026-11-23**

### Re-check of the chapter 3 exercise sheet

Builds clean. Layout fixed (new line after `=>`) ✔. Unused hypotheses now
`_` ✔. **But `proj_fst'` is *still* the second projection.** The new proof
`intro ha _; assumption` elaborates to `fun a ha a✝ => a✝`, confirmed
with `set_option pp.raw true`. Two Lean mechanics explain it:

1. `intro _` does **not** discard the hypothesis. It stays in the context
   with an *inaccessible* name `a✝` (shown as `ha a✝ : a`). You can't
   refer to it by name, but automation can still use it.
2. `assumption` searches the context **from the most recent hypothesis
   backwards**, so it picks `a✝` (the second argument) before `ha`.

Moral: `assumption`, `simp`, etc. may choose a *different* proof than the
one you intend. In `Prop` that never matters for correctness (proof
irrelevance), but it does matter when, as here, the exercise is about which
term you build. `#print` shows you what you actually built.

- Second re-check: `proj_fst'` = `intro ha _; apply ha` now elaborates to
  `fun a ha _ => ha`, the first projection ✔. Note that this is the
  *identical* term to `proj_fst`'s (`exact ha`). Different tactics can
  build the same term. A genuinely different term would route through a
  lemma, e.g. `fun a ha _ => I a ha`. Optional; the sheet's actual
  requirement is met by `proj_snd`. **Ch.3 exercise sheet closed.**

---

**2026-11-23**

## Chapter 4: Forward Proofs

(Book pp.37–54.) The chapter has two halves. The structured-proof syntax
(`fix`/`assume`/`have`/`show`/`calc`) is mechanical. Dependent types and
the **PAT principle** (§4.6–4.8) are the conceptual core, so slow down there.
Every behavioural claim below was checked with this repo's toolchain.

### 1. PAT, compared with what you already know

**Coming from Agda:** you already work with propositions-as-types, so
nothing is new in principle. Two Lean-specific differences matter:
- **`Prop` is impredicative.** `∀ a : Prop, a → a` has type `Prop`, even
  though it quantifies over all of `Prop`. Compare
  `(α : Type) → α → α : Type 1`, which is predicative and goes up a
  universe, as in Agda's `Set`. This is why ch.3's
  `ExcludedMiddle := ∀a : Prop, a ∨ ¬a` was an ordinary proposition you
  could assume and prove things about.
- **Proof irrelevance:** any two proofs of the same `P : Prop` are
  definitionally equal (ch.12). That's why `theorem` bodies are opaque,
  and why the "different proof of `proj_fst`" exercise was only about
  syntax.

**Coming from HOL4:** this is the real shift.
- In LCF-style HOL4, a theorem is a value of the abstract ML type `thm`.
  Proofs are *not* objects of the logic, and soundness comes from the
  inference rules being `thm`'s only constructors.
- In Lean, a **proof is a term of the logic**, and the kernel is just a
  **type checker**. Tactics are untrusted programs that output a term,
  which the kernel re-checks: a small checker verifies every proof (the
  de Bruijn criterion), instead of trust coming from an abstract type.
- HOL's `∀` is a constant applied to a λ-abstraction. Lean's `∀` is
  *the dependent function type itself*: `∀x : σ, Q x` **is**
  `(x : σ) → Q x`. (`#check (n : ℕ) → n = n` prints `∀ (n : ℕ), n = n`.)
- That's the reason, promised in ch.3, that `→` and `∀` have no named
  intro/elim rules. Introduction is `fun` (rule Fun′) and elimination is
  application (rule App′). Modus ponens is `hab ha`, and instantiation is
  `h 5`.

**The dictionary (book §4.7 table), read as term constructors:**

| tactic        | structured               | raw term          |
|---------------|--------------------------|-------------------|
| `intro x`     | `fix x : σ`              | `fun x ↦ …`       |
| `intro h`     | `assume h : P`           | `fun h ↦ …`       |
| `have k := H` | `have k : Q := H`        | `(fun k ↦ …) H`   |
| `exact H`     | `show P from H`          | `(H : P)`         |

So a structured proof is a proof term with readable syntax. `#print` your
ch.3 tactic proofs next to your ch.4 structured ones: they should often
produce the *same* term.

### 2. Dependent types: the ch.1 rules, generalized

Fun′ and App′ are ch.1's Fun/App with the codomain allowed to mention the
bound variable: `(x : σ) → τ[x]`, and application substitutes, giving
`τ[u]`. `σ → τ` is just `(_ : σ) → τ`. This also finishes the
well-typed/well-formed discussion: the types on the right of `:` are
checked by the same rules.

### 3. Mechanical gotchas (all verified)

- **`fix` and `assume` exist only in LoVelib**, as macros that expand to
  `fun x : σ ↦ …`. Standard Lean writes `fun` (or `intro` in tactics). In
  this LoVelib:
  - the **type annotation is mandatory** (`fix x; …` is a parse error,
    "expected ':'"), despite the book saying types are often omitted;
  - **`assume` takes exactly one name** (`assume ha hb : a` fails), while
    `fix x y : σ` may bind several names of the same type.
- **Layout:** each `fix`/`assume`/`have` line must be followed by a line
  break or `;`. Wrap subproofs passed as arguments in parentheses, as in
  the book's `Iff.intro (assume … ) (assume … )`.
- **`have` forgets, `let` remembers.** `let n := 2` followed by
  `(rfl : n = 2)` checks, but `have n := 2` followed by the same thing
  fails, because `n` is opaque. It's the same distinction as
  `theorem`/`def`. Use `have` for proofs and `let` for data.
- **`show P from H`** may restate the goal *up to computation*, e.g. a
  `¬a` goal can be shown as `a → False`.
- **`calc`:** `calc a = b := proof₁` then `_ = c := proof₂`, where the `_`
  stands for the previous right-hand side. `=`, `≤`, `<` can be mixed.
  `calc`, `have` and `let` also work as **tactics** inside `by`, so you
  can mix forward and backward steps.
- **Precedence (useful for Q2.1):** `2 * a * b` parses as
  `(2 * a) * b`. `*` and `+` associate to the left.

### 4. Induction by pattern matching = a recursive proof term

```lean
theorem reverse_append {α : Type} : ∀xs ys : List α, … 
  | [], ys      => …
  | x :: xs, ys => … reverse_append xs …   -- the IH is the theorem itself
```

By PAT, an inductive proof *is* a recursive function into proofs. The
"induction hypothesis" is a recursive call, and Lean's termination checker
plays the role of the induction principle. A circular call is rejected:
`| n + 1 => bad (n + 1)` gives "fail to show termination … failed to
eliminate recursive application". Structural recursion compiles to the
recursor (`Nat.brecOn`, which you saw in `#print mul`'s output). This is
more flexible than `induction` (matching several arguments at once,
well-founded recursion), but it isn't available for inductive predicates
(ch.6).

**∃ in structured style:** `Exists.intro t proof` introduces, and
`Exists.elim hex (fix x : α; assume hx : P x; …)` eliminates. The
elimination rule takes a *function* (a ∀-proof) as its second argument.
That's PAT again.

**Task:** `lean/LoVe/LoVe04_ForwardProofs_ExerciseSheet.lean`.
- Q1: structured proofs of ch.3's Q1 theorems, plus `forall_and`; 1.4 is
  optional. Compare `#print`s against your ch.3 versions.
- Q2: `binomial_square` by `calc`. The sheet says it's hard; mind the
  precedence point above.
- Q3 (optional, recommended for a logician): derive `False` from two
  *wrongly stated* one-point-rule axioms. It's a concrete demonstration of
  why `axiom` (and `sorry`) can make the logic inconsistent.

Build with `lake build LoVe.LoVe04_ForwardProofs_ExerciseSheet`.
