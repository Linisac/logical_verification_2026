/- Copyright © 2018–2026 Anne Baanen, Alexander Bentkamp, Jasmin Blanchette,
Xavier Généreux, Johannes Hölzl, and Jannis Limperg. See `LICENSE.txt`. -/

import LoVe.LoVe03_BackwardProofs_ExerciseSheet


/- # LoVe Homework 4: Forward Proofs

Replace the placeholders (e.g., `:= sorry`) with your solutions. -/


set_option autoImplicit false
set_option linter.unusedVariables false
set_option linter.unnecessarySeqFocus false
set_option linter.tacticAnalysis.introMerge false

namespace LoVe


/- ## Question 1: Logic Puzzles

Consider the following tactical proof: -/

theorem about_Impl :
    ∀a b : Prop, ¬ a ∨ b → a → b :=
  by
    intros a b hor ha
    apply Or.elim hor
    · intro hna
      apply False.elim
      apply hna
      exact ha
    · intro hb
      exact hb

/- 1.1. Prove the same theorem again, this time by providing a proof term.

Hint: There is an easy way. -/

theorem about_Impl_term :
    ∀ a b : Prop, ¬ a ∨ b → a → b :=
  about_Impl

theorem about_Impl_term' :
    ∀a b : Prop, ¬ a ∨ b → a → b :=
  fun (a b : Prop) (hnab : ¬ a ∨ b) (ha : a) =>
  Or.elim hnab
    ( fun hna : ¬ a =>
      False.elim (hna ha))
    ( fun hb : b => hb)

theorem about_Impl_term'' :
    ∀a b : Prop, ¬ a ∨ b → a → b :=
fun a : Prop =>
  fun b : Prop =>
  fun hor : ¬a ∨ b =>
  Or.elim hor
    ( fun hna : ¬a =>
      fun ha : a =>
      False.elim (hna ha))
    ( fun hb : b =>
      fun _ : a =>
      hb)

/- 1.2. Prove the same theorem again, this time by providing a
structured proof, with `fix`, `assume`, and `show`. -/

theorem about_Impl_struct :
    ∀a b : Prop, ¬ a ∨ b → a → b :=
  fix a b : Prop
  assume hor : ¬a ∨ b
  assume ha : a
  show b from
    Or.elim hor
    ( assume hna : ¬a
      False.elim (hna ha))
    ( fun hb => hb)


/- ## Question 2: More Logic Puzzles

Recall the following tactical proof: -/

theorem weak_peirce :
    ∀a b : Prop, ((((a → b) → a) → a) → b) → b :=
  by
    intro a b habaab
    apply habaab
    intro habaa
    apply habaa
    intro ha
    apply habaab
    intro haba
    apply ha

/- 2.1. Prove the same theorem again, this time by providing a proof
term.

Hint: There is an easy way. -/

theorem weak_peirce_term :
    ∀a b : Prop, ((((a → b) → a) → a) → b) → b :=
  weak_peirce

theorem weak_peirce_term' :
    ∀a b : Prop, ((((a → b) → a) → a) → b) → b :=
  fun (a b : Prop) (habaab : (((a → b) → a) → a) → b) =>
  habaab
    ( fun haba : (a → b) → a =>
      haba
        ( fun ha : a =>
          habaab
            fun _ : (a → b) → a =>
            ha))

/- 2.2. Prove the same theorem again, this time by providing a structured
proof, with `fix`, `assume`, and `show`. -/

theorem weak_peirce_struct :
    ∀a b : Prop, ((((a → b) → a) → a) → b) → b :=
  fix a b : Prop
  assume habaab : (((a → b) → a) → a) → b
  show b from
    habaab
      ( assume haba : (a → b) → a
        show a from
          haba
            ( assume ha : a
              show b from
                habaab
                  ( assume haba' : (a → b) → a
                    show a from
                      ha)))


/- ## Question 3: Connectives and Quantifiers

3.1. Supply a structured proof of the commutativity of `∧` under an `∃`
quantifier, using no other theorems than the introduction and elimination rules
for `∃`, `∧`, and `↔`. -/

theorem And_comm_under_Exists {α : Type} (p q : α → Prop) :
    (∃x, p x ∧ q x) ↔ (∃x, q x ∧ p x) :=
  Iff.intro
    ( assume hexpxqx : ∃x, p x ∧ q x
      show ∃x, q x ∧ p x from
        Exists.elim hexpxqx
          ( fix x : α
            assume hpxqx : p x ∧ q x
            show ∃x, q x ∧ p x from
              Exists.intro x
              ( And.intro (And.right hpxqx) (And.left hpxqx))))
    ( assume hexqxpx : ∃x, q x ∧ p x
      show ∃x, p x ∧ q x from
        Exists.elim hexqxpx
          ( fix x : α
            assume hqxpx : q x ∧ p x
            show ∃x, p x ∧ q x from
              Exists.intro x
                (And.intro (And.right hqxpx) (And.left hqxpx))))

/- 3.2. Supply a structured proof of the commutativity of `∨` under a `∀`
quantifier, using no other theorems than the introduction and elimination rules
for `∀`, `∨`, and `↔`. -/
#check Or.elim
theorem Or_comm_under_All {α : Type} (p q : α → Prop) :
    (∀x, p x ∨ q x) ↔ (∀x, q x ∨ p x) :=
  Iff.intro
    ( assume haxpxqx : ∀x, p x ∨ q x
      fix x : α
      have hpxqx : p x ∨ q x := haxpxqx x
      show q x ∨ p x from
        Or.elim hpxqx
          ( assume hpx : p x
            show q x ∨ p x from
              Or.inr hpx)
          ( assume hqx : q x
            show q x ∨ p x from
              Or.inl hqx))
    ( assume haxqxpx : ∀x, q x ∨ p x
      fix x : α
      have hqxpx : q x ∨ p x := haxqxpx x
      show p x ∨ q x from
        Or.elim hqxpx
          ( assume hqx : q x
            show p x ∨ q x from
              Or.inr hqx)
          ( assume hpx : p x
            show p x ∨ q x from
              Or.inl hpx))

/- 3.3. We have proved or stated three of the six possible implications between
`ExcludedMiddle`, `Peirce`, and `DoubleNegation` in the exercise of lecture 3.
Prove the three missing implications using structured proofs, exploiting the
three theorems we already have. -/

namespace BackwardProofs

#check Peirce_of_EM
#check DN_of_Peirce
#check SorryTheorems.EM_of_DN

theorem Peirce_of_DN :
    DoubleNegation → Peirce :=
  assume dn : DoubleNegation
  have em : ExcludedMiddle := SorryTheorems.EM_of_DN dn
  Peirce_of_EM em

theorem EM_of_Peirce :
    Peirce → ExcludedMiddle :=
  assume prc : Peirce
  have dn : DoubleNegation := DN_of_Peirce prc
  SorryTheorems.EM_of_DN dn

theorem DN_of_EM :
    ExcludedMiddle → DoubleNegation :=
  assume em : ExcludedMiddle
  have prc : Peirce := Peirce_of_EM em
  DN_of_Peirce prc

end BackwardProofs

end LoVe
