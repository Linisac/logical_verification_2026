/- Copyright © 2018–2026 Anne Baanen, Alexander Bentkamp, Jasmin Blanchette,
Xavier Généreux, Johannes Hölzl, and Jannis Limperg. See `LICENSE.txt`. -/

import LoVe.LoVelib


/- # LoVe Exercise 4: Forward Proofs -/


set_option autoImplicit false
set_option linter.unusedVariables false
set_option linter.unnecessarySeqFocus false
set_option linter.tacticAnalysis.introMerge false

namespace LoVe


/- ## Question 1: Connectives and Quantifiers

1.1. Supply structured proofs of the following theorems. -/

theorem I (a : Prop) :
    a → a :=
  assume ha : a
  show a from
    ha

theorem K (a b : Prop) :
    a → b → b :=
  fun ha : a =>
  fun hb : b =>
  hb

theorem C (a b c : Prop) :
    (a → b → c) → b → a → c :=
  assume habc : a → b → c
  assume hb : b
  assume ha : a
  show c from
    habc ha hb

theorem proj_fst (a : Prop) :
    a → a → a :=
  assume ha : a
  assume ha' : a
  ha

/- Please give a different answer than for `proj_fst`. -/

theorem proj_snd (a : Prop) :
    a → a → a :=
  fun ha : a =>
  fun ha' : a =>
  show a from
    ha'

theorem some_nonsense (a b c : Prop) :
    (a → b → c) → a → (a → c) → b → c :=
  assume habc : a → b → c
  assume ha : a
  assume hac : a → c
  assume hb : b
  have hc : c := habc ha hb --alternatively: hac ha
  hc

/- 1.2. Supply a structured proof of the contraposition rule. -/

theorem contrapositive (a b : Prop) :
    (a → b) → ¬ b → ¬ a :=
  assume hab : a → b
  assume hnb : ¬b
  assume ha : a
  have hb : b := hab ha
  show False from
    hnb hb

/- 1.3. Supply a structured proof of the distributivity of `∀` over `∧`. -/

theorem forall_and {α : Type} (p q : α → Prop) :
    (∀x, p x ∧ q x) ↔ (∀x, p x) ∧ (∀x, q x) :=
  Iff.intro
    ( assume hallpq : ∀x, p x ∧ q x
      have hallp : ∀x, p x :=
        fix x : α
        have hpq : p x ∧ q x :=
          hallpq x
        And.left hpq
      have hallq : ∀x, q x :=
        fix x : α
        have hpq : p x ∧ q x :=
          hallpq x
        And.right hpq
      And.intro hallp hallq)
    ( assume hallpallq : (∀x, p x) ∧ (∀x, q x)
      fix x : α
      have hallp : ∀x, p x := And.left hallpallq
      have hallq : ∀x, q x := hallpallq.right
      have hp : p x := hallp x
      have hq : q x := hallq x
      And.intro hp hq)

/- 1.4 (**optional**). Supply a structured proof of the following property,
which can be used to pull a `∀` quantifier past an `∃` quantifier. -/

theorem forall_exists_of_exists_forall {α : Type} (p : α → α → Prop) :
    (∃x, ∀y, p x y) → (∀y, ∃x, p x y) :=
  fun hexaypxy : ∃x, ∀y, p x y =>
  fun y : α =>
  Exists.elim hexaypxy
  fun x : α =>
  fun haypxy : ∀y, p x y =>
  have hxy : p x y := haypxy y
  Exists.intro x hxy

theorem forall_exists_of_exists_forall' {α : Type} (p : α → α → Prop) :
    (∃x, ∀y, p x y) → (∀y, ∃x, p x y) :=
  assume hexaypxy : ∃x, ∀y, p x y
  fix y : α
  show ∃x, p x y from
    Exists.elim hexaypxy
      ( fix x : α
        assume haypxy : ∀y, p x y
        Exists.intro x (haypxy y))

theorem forall_exists_of_exists_forall'' {α : Type} (p : α → α → Prop) :
    (∃x, ∀y, p x y) → (∀y, ∃x, p x y) :=
  by
    intro hexaypxy
    intro y
    apply Exists.elim hexaypxy
    intro x
    intro hallypxy
    exact Exists.intro x (hallypxy y)

/- ## Question 2: Chain of Equalities

2.1. Write the following proof using `calc`.

      (a + b) * (a + b)
    = a * (a + b) + b * (a + b)
    = a * a + a * b + b * a + b * b
    = a * a + a * b + a * b + b * b
    = a * a + 2 * a * b + b * b

Hint: This is a difficult question. You might need the tactics `simp` and
`ac_rfl` and some of the theorems `mul_add`, `add_mul`, `add_comm`, `add_assoc`,
`mul_comm`, `mul_assoc`, , and `Nat.two_mul`. -/

theorem binomial_square (a b : ℕ) :
    (a + b) * (a + b) = a * a + 2 * a * b + b * b :=
  calc
    (a + b) * (a + b) = a * (a + b) + b * (a + b) :=
      by rw [add_mul]
    _ = a * a + a * b + b * a + b * b :=
      by
        rw [mul_add]
        rw [mul_add]
        ac_rfl
    _ = a * a + a * b + a * b + b * b :=
      by rw [mul_comm b a]
    _ = a * a + 2 * a * b + b * b :=
      by
        rw [add_assoc (a * a)]
        rw [← Nat.two_mul]
        rw [← mul_assoc]

/- 2.2 (**optional**). Prove the same argument again, this time as a structured
proof, with `have` steps corresponding to the `calc` equations. Try to reuse as
much of the above proof idea as possible, proceeding mechanically. -/

theorem binomial_square₂ (a b : ℕ) :
    (a + b) * (a + b) = a * a + 2 * a * b + b * b :=
  have heq1 : (a + b) * (a + b) = a * (a + b) + b * (a + b) :=
    by rw [add_mul]
  have heq2 : a * (a + b) + b * (a + b) = a * a + a * b + b * a + b * b :=
    by
      rw [mul_add]
      rw [mul_add]
      ac_rfl
  have heq3 : a * a + a * b + b * a + b * b = a * a + a * b + a * b + b * b :=
    by rw [mul_comm b a]
  have heq4 : a * a + a * b + a * b + b * b = a * a + 2 * a * b + b * b :=
    by
      rw [add_assoc (a * a)]
      rw [← Nat.two_mul]
      rw [← mul_assoc]
  show _ from
    Eq.trans (Eq.trans (Eq.trans heq1 heq2) heq3) heq4

/- ## Question 3 (**optional**): One-Point Rules

3.1 (**optional**). Prove that the following wrong formulation of the one-point
rule for `∀` is inconsistent, using a structured proof. -/

namespace Ex3_1
axiom All.one_point_wrong {α : Type} (t : α) (P : α → Prop) :
    (∀x : α, x = t ∧ P x) ↔ P t

theorem All.proof_of_False :
    False :=
  let P : Bool → Prop := fun b => b = true
  have h : ∀x : Bool, x = true ∧ P x :=
    by
      apply Iff.mpr (All.one_point_wrong true P)
      simp [P] --alternatively: rw []
  have h1 : false = true :=
    by
      apply And.left
      exact h false
  have h2 : ¬false = true := fun h => nomatch h
  h2 h1
end Ex3_1

/- 3.2 (**optional**). Prove that the following wrong formulation of the
one-point rule for `∃` is inconsistent, using a structured proof. -/

namespace Ex3_2
axiom Exists.one_point_wrong {α : Type} (t : α) (P : α → Prop) :
    (∃x : α, x = t → P x) ↔ P t

theorem Exists.proof_of_False :
    False :=
  let P : Bool → Prop := fun b => ¬b = true
  have h1 : (∃x : Bool, x = true → P x) → P true :=
    Iff.mp (Exists.one_point_wrong true P)
  have h2 : P true :=
    h1
      ( by
          apply Exists.intro false
          simp [P])
  by
    simp [P] at h2
end Ex3_2
end LoVe
