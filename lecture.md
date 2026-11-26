
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

### Q&A: `zero` vs `Nat.zero` vs `ℕ.zero` (practice.lean)

All behaviour below was checked with this repo's toolchain.

**Background:** the constructors of `inductive Nat` are declared *inside the
namespace `Nat`*. Their real names are `Nat.zero` and `Nat.succ`, just as
`List.nil` and `Option.none` live in their types' namespaces. A bare `zero`
resolves only if you are inside `namespace Nat` or have written `open Nat`.
`practice.lean` is in `namespace mine`, so neither applies.

**1. Bare `zero`/`succ` in a `def` pattern.**
- On the right-hand side, `zero` is simply "Unknown identifier `zero`".
- In a pattern it's worse. A bare identifier that doesn't resolve to a
  constructor is read as a **new pattern variable**. So `| _, zero => …`
  matches *every* number, and Lean warns: "Local variable 'zero' resembles
  constructor 'Nat.zero' – write '.zero' (with a dot) or 'Nat.zero'".
- `succ n` is an application, so it has to be a constructor. That gives
  "Invalid pattern: Expected a constructor…".

Short alternatives that work:
- `.zero` / `.succ n`: the leading dot means "look this name up in the
  namespace of the expected type", here `Nat`. This also works on the
  right-hand side: `| _, .zero => .zero`.
- `open Nat` (in a `section`), then bare `zero`/`succ`.
- Idiomatic for `Nat` specifically: numerals `0` and `n + 1`.

**2. `ℕ.zero`.** `ℕ` is **notation** for the term `Nat`, not a name or
namespace. Notation rewrites terms, but namespaces are looked up by name,
so `ℕ.zero` is read as a name in a nonexistent namespace `ℕ`: "Unknown
identifier `«ℕ».zero`".

**3. Why `induction … with | zero | succ` *requires* the short names.** The
alternatives of `induction`/`cases` are not patterns or terms. They are
**labels** for the cases of the recursor `Nat.rec`, one per constructor.
Lean already knows from `n` that the type is `Nat`, so it expects the bare
constructor names. `| Nat.zero => …` is rejected: "Invalid alternative name
`Nat.zero`: Expected `zero` or `succ`". By contrast, `def`/`match` patterns
are real terms (constructor applications) and go through ordinary name
resolution. That's the asymmetry you noticed.

### Follow-up: is the `Nat` in `Nat.zero` the namespace or the type?

**Both, because in Lean they are the same string.** Lean names are
hierarchical (`Nat.zero` is the name with components `Nat` and `zero`), and
a **namespace is nothing but a name prefix**. It's not an object in the
logic. `inductive Nat` declares a constant named `Nat` (the type) and puts
its constructors and recursor under that prefix: `Nat.zero`, `Nat.succ`,
`Nat.rec`. So the type's name and the namespace coincide *by convention of
the `inductive` command*. They aren't the same kind of thing.

Evidence (checked):
- A namespace can exist with no constant of that name: after
  `namespace Foo  def bar …  end Foo`, `#check Foo.bar` works but
  `#check Foo` gives "Unknown identifier `Foo`".
- You can add to the `Nat` namespace yourself:
  `def Nat.double (n : ℕ) : ℕ := n + n`.
- Inside `namespace Nat … end Nat`, bare `zero` and `double` resolve.
- The link is used *from the type to the namespace*. For `x : Nat`, dot
  notation `x.double` means `Nat.double x` (`(3 : ℕ).double` evaluates to
  6), and the shorthand `.zero` with expected type `Nat` means `Nat.zero`.
  Lean takes the *head constant's name* of the type (`Nat`) and uses it as
  the prefix.

That also explains `ℕ.zero` failing. `ℕ` is notation that *elaborates to*
the constant `Nat`, but there's no name `ℕ`, so no prefix `ℕ`. The
parser reads `ℕ.zero` as a single identifier (Lean shows it as
`«ℕ».zero`), so the `ℕ` notation never gets a chance to apply.

### Q&A: what is `by?`

`by?` is a Lean-core macro (`Init/Tactics.lean`):
`by? tacs` ≡ `show_term by tacs`. It runs the tactic block normally *and*
prints the **proof term the tactics built**, as a clickable "Try this:"
suggestion that replaces the `by` block with that term. In other words,
it's PAT made visible: you watch tactics turn into a term. Checked outputs:

    theorem C … := by? intro habc hb ha; apply habc; · exact ha; · exact hb
      -- Try this: fun habc hb ha => habc ha hb
    theorem And_swap … := by? intro hab; apply And.intro; · exact And.right hab; · exact And.left hab
      -- Try this: fun hab => ⟨hab.right, hab.left⟩
    example (n : Nat) : n + 0 = n := by? simp
      -- Try this: of_eq_true (Eq.trans (congrArg (fun x => x = n) (add_zero n)) (eq_self n))

Notes:
- `⟨…, …⟩` is *anonymous constructor* notation (here `And.intro`), and
  `hab.right` is dot notation for `And.right hab`. That's the
  namespace-prefix mechanism from the previous Q&A, since `hab : And a b`.
- `simp`'s terms are unreadable, so `by?` is most useful on short
  intro/apply/exact proofs.
- **vs `#print`:** `#print thm` shows the term of a *finished* declaration
  after the fact. `by?` works on the block in place, offers the replacement,
  and also works for a sub-block (`show_term tac` inside a proof).
- The `?` suffix is a convention for "suggest something". **Don't confuse
  `by?` with `exact?`/`apply?`**, which *search the library* for a lemma
  closing the goal (e.g. `exact?` on `m + n = n + m` suggests
  `exact Nat.add_comm m n`). `by?` searches nothing. It only reports what
  your own tactics produced.
- Useful for the ch.4 sheet: write a ch.3-style tactic proof, use `by?` to
  see its term, and compare it with your structured proof.

### Q&A: is `fun … ↦ … show … from …` standard Lean?

Yes. `practice.lean`'s `fst_of_two_props''` (`fun a b : Prop ↦ fun ha : a
↦ fun _ : b ↦ show a from ha`) compiles in a file with **no imports at all**
(core `Init` only). `fun`, `↦` (interchangeable with `=>`), the `_` binder,
and `show … from …` are all core syntax. In the same import-free file,
the LoVelib version fails at `fix` ("Unknown identifier `fix`"), which
confirms that `fix`/`assume` are LoVelib-only.

`#print` shows that `show a from ha` is itself sugar:
`fun a b ha x => have this := ha; this`. So `show P from e` means
`have this : P := e; this`, a type ascription done via `have`. It's
erased in effect, but it makes Lean check `e` against `P` (up to
computation). Standard-Lean style would usually write the multi-binder
form `fun (a b : Prop) (ha : a) (_ : b) ↦ ha`, i.e. your
`fst_of_two_props'''`.

---

**2026-11-25**

### Review of the chapter 4 exercise and homework sheets

Both build clean and `sorry`-free. Homework 3.3 (`Peirce_of_DN`,
`EM_of_Peirce`, `dn_of_em`) uses no axioms. The two Q3 `proof_of_False`
theorems depend on exactly the intended bad axiom (plus `propext` /
`Quot.sound` from `simp`).

**"There is an easy way" (HW 1.1, 2.1).** By PAT, a tactical proof is
already a term, so there are two easy routes:
1. **The name of a theorem is a proof term** (book §4.2, the
   `this_time_with_feeling` example). So
   `theorem about_Impl_term : … := about_Impl` is a legitimate term proof.
   Checked: it compiles, and so does `weak_peirce_term … := weak_peirce`.
   That's almost certainly the joke intended.
2. The honest-but-mechanical route: ask Lean for the term the tactics built
   (`#print about_Impl`, or `by?`) and paste it. `#print` gives
   `fun a b hor ha => Or.elim hor (fun hna => False.elim (hna ha)) fun hb => hb`
   and `fun a b habaab => habaab fun habaa => habaa fun ha => habaab fun haba => ha`.
   Your hand-written `about_Impl_term` and `weak_peirce_term` are exactly
   these terms, up to binder annotations. (`about_Impl_term'` is a
   genuinely different term: it pushes `ha` into each branch.)

**Exercise sheet.**
- Q1.1–1.3: all correct. `contrapositive` correctly uses `assume ha : a`
  against a `¬a` goal, because `¬a` is definitionally `a → False`.
  `forall_and` is clean.
- 1.4: all three versions correct. The first omits the parentheses around
  the `Exists.elim` argument. It works because `fun` extends as far right
  as possible, but the parenthesized `'` version is more robust.
- Q2: `binomial_square` and `binomial_square₂` are correct. The last step
  (`add_assoc (a * a)`, `← Nat.two_mul`, `← mul_assoc`) is a nice
  `ac_rfl`-free finish. `binomial_square₂`'s
  `Eq.trans (Eq.trans (Eq.trans …))` could also be written
  `heq1.trans (heq2.trans (heq3.trans heq4))` (dot notation again).
- Q3: both correct, with nicely chosen instances over `Bool`. Observation:
  the predicate barely matters.
  - 3.1's axiom is refuted by *any* type with two distinct elements and any
    `P` with `P t` true (even `fun _ ↦ True`), because the left-hand side
    forces every `x` to equal `t`.
  - 3.2's is refuted by `P := fun _ ↦ False` plus any witness `x ≠ t`,
    which makes `x = t → P x` hold vacuously.
  - The `--alternatively: rw []` comment is stale.

**Homework sheet.**
- Q1, Q2: correct. In 1.2, `( fun hb => hb)` could be
  `(assume hb : b; hb)` to stick to the requested `fix`/`assume`/`show`
  style. Cosmetic.
- Q3.1, 3.2: correct, and they use only the intro/elim rules, as required.
- Q3.3: correct and non-circular. Naming nit: `dn_of_em` breaks the
  `DN_of_EM` convention used by the other five.

---

**2026-11-26**

### Q&A: Lean equivalents of HOL4's `m`, `f`, `mm`, `ff`, `fm`, `mf`

(HOL4 cheatsheet: `m` = `Hol_pp.print_apropos`, a subterm-pattern search;
`f` = `Hol_pp.print_find`, a theorem-name search; the two-letter versions
chain two searches.) All commands below were checked in this repo.

**Loogle covers all six with one query language.** Filters separated by
commas are conjoined:

| HOL4 | Loogle filter | example |
|---|---|---|
| `f "str"` | `"str"` (substring of the lemma name) | `"two_mul"` |
| `m ‘pat’` | subterm pattern, `_` = anything, `?a` = named/non-linear | `_ * (_ + _)` |
| — | conclusion pattern | `\|- _ < _ → _` |
| — | mentions constant | `List.map` |
| `mm`/`ff`/`fm`/`mf` | comma-combine any of the above | `"add", ?a * (?b + ?c) = ?a * ?b + ?a * ?c` |

The last query returned `Nat.mul_add`, `Int.mul_add`, `Rat.mul_add`, ….

Three ways to run it:
- **VS Code**: Command Palette → "Lean 4: Loogle: Search With Loogle…"
  (command `lean4.loogle.search`, built into the installed extension). It
  needs no import, so it's the closest thing to having `m`/`f` at hand.
- **In a file**: `#loogle <query>` after `import Mathlib.Tactic.Common`.
- **Web**: loogle.lean-lang.org.

Caveats:
- Loogle queries a **server-side, current Mathlib**, not this repo's pinned
  Mathlib or LoVe's own definitions (e.g. LoVe's `add`/`mul`). Names can
  differ slightly between versions. It also needs network access.
- Gotcha: a constant filter refers to the *constant*, not the notation.
  `a * b` on ℕ elaborates to `HMul.hMul`, not `Nat.mul`, so
  `#loogle Nat.mul, …` found nothing. Use a pattern (`_ * _`) instead.

**Offline / local alternatives:**
- `#find <pattern>` (`Mathlib.Tactic.Common`) is a local `m`, but noisy.
  `#find _ * (_ + _) = _ * _ + _ * _` hit `mul_add`/`left_distrib`, along
  with lots of junk that unifies loosely, and then the result cap.
- `#print prefix Nat.two_mul` (`import Batteries.Tactic.PrintPrefix`) lists
  every declaration whose name starts with that prefix. It's a local
  prefix-only `f`.
- **Name completion** in VS Code: type `Nat.mul_` and press Ctrl+Space.
  This is the everyday Lean `f`.

**Goal-directed search** (what Lean users reach for most, with no exact
HOL4-cheatsheet analogue):
- `exact?` proves the goal from one library lemma. On
  `a * (b + c) = a * b + a * c` it suggests `exact Nat.mul_add a b c`.
- `apply?` and `rw?` do the same for apply and rewrite steps. (`rw?`
  suggested `rw [h]`.)
- `simp?` runs `simp` and reports the `simp only [...]` lemma list it used.

### Q&A: Loogle query for `a * b = b * a` on ℕ

Checked with `#loogle` from this repo:

| query | result |
|---|---|
| `(?a : ℕ) * ?b = ?b * ?a` | exactly `Nat.mul_comm (n m : ℕ) : n * m = m * n` |
| `⊢ (?a : ℕ) * ?b = ?b * ?a` | same, `Nat.mul_comm` only |
| `(_ : ℕ) * _ = _ * _` | `Nat.mul_comm`, plus `Nat.mul_assoc`, `Nat.mul_left_comm`, `Nat.eq_of_mul_eq_mul_left`, … |
| `⊢ ?a * ?b = ?b * ?a` | `Nat/Int/Fin/Rat.mul_comm`, `Lean.Grind.CommSemiring.mul_comm`, … |
| `?a * ?b = ?b * ?a` | failed (server timeout: too general without `⊢`) |

Lessons:
- **`?a`/`?b` are essential.** They're non-linear, so `?a` must be the same
  term in both places. `_` is linear (each `_` independent), so
  `_ * _ = _ * _` also matches associativity and cancellation lemmas.
- **The type ascription `(?a : ℕ)` restricts to ℕ.** Without it you get
  every commutative type.
- **`⊢` (or `|-`) matches only the conclusion.** It's more precise, and
  in practice it also keeps the unrestricted query from timing out.
- `#loogle` prints only the first few hits. The VS Code command and the
  website show the full list.

`Nat.mul_comm` is the ℕ-specific lemma. The generic Mathlib `mul_comm :
∀ {G} [CommMagma G] (a b : G), a * b = b * a` also applies to ℕ via type
classes (checked: `example (a b : ℕ) : a * b = b * a := mul_comm a b`).
That's the one used in ch.4's `rw [mul_comm b a]`. Type classes are ch.5.

---

**2026-11-26**

## Chapter 5: Functional Programming

(Book pp.57–77.) Most of this chapter (inductive types, structural
recursion, pattern matching, lists, trees) is ML/HOL4/Agda material you
know. The genuinely new part is **type classes**. Then there are a handful
of Lean mechanics around `cases`, induction and `if`. Every behavioural
claim below was checked against this repo's toolchain.

### 1. Type classes: the new idea

- **What they are:** a `class` is just a `structure`, and an `instance` is
  a value of that structure *registered* in a global table. An argument
  written `[C α]` is *instance-implicit*: Lean fills it by **instance
  search**, a Prolog-like backward search through the registered instances
  that can chain them. For example, `inferInstance : Inhabited (ℕ → List ℕ)`
  is found by combining the `Fun.Inhabited` and `List.Inhabited` instances.
- **Your background:**
  - Agda's instance arguments `{{…}}` are the closest analogue.
  - HOL4 has nothing like it. `overload_on` is purely syntactic, and
    algebra is done with predicates on records (`Group g`).
  - The book's footnote is apt: Lean's mechanism is closer to Scala's
    implicits than to Haskell's classes.
- **Syntactic classes** (`Add`, `Mul`, `Zero`, `One`, …) give notation:
  `a + b` *is* `HAdd.hAdd a b`, with the instance chosen by type. That's
  the "constants vs notation" Loogle gotcha from earlier.
  **Semantic classes** also carry proofs (`Std.Commutative`; Mathlib's
  `CommMagma`, `Monoid`, `Ring`, …).
- **This explains the generic `mul_comm`:**
  `mul_comm : ∀ {G} [CommMagma G] (a b : G), a * b = b * a` works on ℕ
  because `#synth CommMagma ℕ` finds `Nat.instCommSemigroup.toCommMagma`.
  The instance is reached through the `extends` hierarchy: one lemma serves
  every type with an instance. That's Mathlib's whole design (ch.13).
- **Tools:**
  - `#synth C τ` shows which instance Lean picks.
  - `@f …` lets you pass an instance explicitly.
  - If several instances apply, the most recently declared (or
    higher-priority) one wins. In the demo, `#synth Inhabited ℕ` returns the
    demo's own `Nat.Inhabited`, not core's.
- **`Decidable` is a type class too, and it governs `if`.**
  `if p then … else …` needs a `Decidable p` instance, so
  `def g (p : Prop) : ℕ := if p then 1 else 0` fails with "failed to
  synthesize Decidable p".
  - That's the computational boundary. A *program* can only branch on
    decidable propositions. A *proof* may split on any proposition
    classically (`Classical.em p`, or the idiomatic tactic `by_cases h : p`).
  - The dependent form `if h : p then … else …` gives you `h : p` /
    `h : ¬p` in the branches.

### 2. `Bool` vs `Prop`

`Bool` is data with two values (`true`/`false`, `&&`, `||`, `!`), used
in programs. `Prop` is for specifications. Pattern matching works on
`Bool`, not on `Prop`. Lean silently coerces between them (`b` becomes
`b = true`). The book advises not relying on that.

### 3. Structures

`structure RGB where red : ℕ …` is a one-constructor inductive type plus
projections `RGB.red`.
- `c.red` is dot notation (the namespace-prefix mechanism again).
- `{ c with alpha := … }` is functional update.
- `⟨r, g, b⟩` is the anonymous constructor (you saw it in `by?` output).
- `extends` adds fields.

This is nearly identical to HOL4 records (`<| red := … |>`, `with`).

### 4. `cases`, constructor facts, and generalizing the induction

- **`cases t`** splits into one case per constructor, without induction
  hypotheses. Applied to an *equation* between constructors, it uses
  injectivity and distinctness:
  - `h : x :: xs = y :: ys` gets unified away (`y := x`, `ys := xs`);
  - `h : [] = x :: xs` closes the goal outright.
  `simp` knows the same facts: `simp at h` turns the first `h` into
  `x = y ∧ xs = ys`. This is HOL4's `list_11` / `NOT_NIL_CONS` being in
  `srw_ss`.
- **`induction` does not generalize other variables for you.** In the
  demo's `length_zip`, plain `induction xs` yields
  `ih : length (zip xs' ys) = …` for the *same fixed* `ys` (checked), which
  is useless because the step needs the tail of `ys`.
  `induction xs generalizing ys` makes it `ih : ∀ys, …`. It's the same
  trick as quantifying `ys` before `Induct_on` in HOL4.
  - Pattern-matching proofs avoid this: state the theorem with `∀xs ys`,
    and the recursive call may take any arguments (`map_zip`).
  - **Exercise 1.1 is exactly this situation**: the accumulator must be
    generalized.

### 5. Termination, `axiom`, and testing definitions

- A `def` must terminate. Structural recursion is accepted automatically.
  `illegal n = illegal n + 1` is rejected (this is HOL4's TFL obligation).
- The same equation stated with `opaque` + `axiom` *is* accepted and proves
  `False`. That's ch.4 Q3 again.
- The book's `fact` (with `| 0 => 0`) is deliberately wrong. It returns 0
  everywhere, which is a reminder to `#eval` your definitions.

### 6. Mechanics you'll use in the sheet

- **`@[simp] theorem …`** adds the theorem to the simp set. It's HOL4's
  `Theorem foo[simp]` / `export_rewrites`. Exercise 2.2 does this.
- **Overlapping patterns are tried top to bottom.** Prefer
  non-overlapping, constructor-shaped patterns that mirror the definition
  (`drop`/`take`'s three cases), because proofs then follow the same three
  cases.
- **Name clash gotcha:** `open LoVe` *outside* the namespace makes `min`
  ambiguous between `LoVe.min` and root `Min.min` ("Ambiguous term"). Inside
  `namespace LoVe … end LoVe`, the local name wins. Keep that in mind for
  `practice.lean`.

### 7. Dependent inductive types (`Vec`), skim only

These will feel familiar from Agda. The book marks them "not exam
material". The usual pain applies: `Vec α (m + n)` vs `Vec α (n + m)` are
not definitionally equal. `match` must also match the index
(`| _, Vec.cons a u => …`), which `cases` does for you.

**Task:** `lean/LoVe/LoVe05_FunctionalProgramming_ExerciseSheet.lean`.
- Q1: `reverseAccu`. Generalize over the accumulator in 1.1, derive 1.2,
  and do 1.3 in one line without induction. 1.4 is a careful paper proof,
  so state each case's IH and goal.
- Q2: define `take`, then prove the `@[simp]` lemmas and `drop_drop` /
  `take_take` / `take_drop`, each with three cases mirroring the
  definition.
- Q3: an inductive type of untyped λ-terms. 3.2 (optional) is your first
  type class *instance* (`Repr`).

Build with `lake build LoVe.LoVe05_FunctionalProgramming_ExerciseSheet`.
