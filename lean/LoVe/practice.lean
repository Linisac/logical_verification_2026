import LoVe.LoVelib

--set_option autoImplicit false
--set_option linter.unusedVariables false
--set_option linter.unnecessarySeqFocus false
--set_option linter.tacticAnalysis.introMerge false

-- < indent 1
namespace mine
-- Chapter 1. Types and Terms
#check ℕ
#check ℤ
#check Empty
#check Unit
#check Bool
#check ℕ → ℤ
#check fun x : ℕ ↦ x
#check fun f : ℕ → ℕ ↦ fun g : ℕ → ℕ ↦ fun h : ℕ → ℕ ↦ fun x : ℕ ↦ h (g (f x))
#check fun (f g h : ℕ → ℕ) (x : ℕ) ↦ h (g (f x))
#check (fun x : ℕ ↦ x) 4

opaque a : ℤ
opaque b : ℤ
opaque f : ℤ → ℤ
opaque g : ℤ → ℤ → ℤ
#check fun x : ℤ ↦ g (f (g a x)) (g x b)
#check fun x ↦ g (f (g a x)) (g x b)

-- Chapter 2. Programs and Theorems
-- < indent 2
namespace MyNat

inductive Nat : Type where
  | zero : Nat
  | succ : Nat → Nat
#print Nat
/- we can also write
inductive Nat where
  | zero : Nat
  | succ : Nat → Nat
omitting ": Type", and Lean is able to figure it out.
-/
end MyNat
-- indent 2 >

inductive AExp : Type where
  | num : ℤ → AExp
  | var : String → AExp
  | add : AExp → AExp → AExp
  | sub : AExp → AExp → AExp
  | mul : AExp → AExp → AExp
  | div : AExp → AExp → AExp

-- < indent 2
namespace MyList
inductive List (α : Type) where
  | nil : List α
  | cons : α → List α → List α
#check List.nil
#check List.nil (α := ℕ)
#check @List.nil ℕ
#check List.cons
#check List.cons (α := ℕ)
#check @List.cons ℕ
#print List
end MyList
-- indent 2 >

def fib : ℕ → ℕ
  | 0     => 0
  | 1     => 1
  | n + 2 => fib (n + 1) + fib n

#print Nat

def add : ℕ → ℕ → ℕ
  | m, Nat.zero   => m
  | m, Nat.succ n => Nat.succ (add m n)

#eval add 2 7
#reduce add 2 7

def mul : ℕ → ℕ → ℕ
  | _, Nat.zero   => Nat.zero
  | m, Nat.succ n => add m (mul m n)

#eval mul 2 7

def power : ℕ → ℕ → ℕ
  | _, Nat.zero  => 1
  | m, Nat.succ n => mul m (power m n)

def powerParam (m : ℕ) : ℕ → ℕ
  | Nat.zero   => 1
  | Nat.succ n => mul m (powerParam m n)

def iter (α : Type) (z : α) (f : α → α) : ℕ → α
  | Nat.zero => z
  | Nat.succ n => f (iter α z f n)

def powerIter (m n : ℕ) : ℕ :=
  iter ℕ 1 (mul m) n

def addIter (m n : ℕ) : ℕ :=
  iter ℕ m Nat.succ n

def mulIter (m n : ℕ) : ℕ :=
  iter ℕ 0 (add m) n

#print AExp
def eval (env : String → ℤ) : AExp → ℤ
  | AExp.num i => i
  | AExp.var x => env x
  | AExp.add e1 e2 => eval env e1 + eval env e2
  | AExp.sub e1 e2 => eval env e1 - eval env e2
  | AExp.mul e1 e2 => eval env e1 * eval env e2
  | AExp.div e1 e2 => eval env e1 / eval env e2

def env1 : String → ℤ :=
  fun _ => 0
/-
alternatively, one can write
def env1 : String → ℤ :=
  fun _ ↦ 0
-/

#eval eval env1 (AExp.add (AExp.num 1) (AExp.var "b"))

def append (α : Type) : List α → List α → List α
  | List.nil,       ys => ys
  | List.cons x xs, ys => List.cons x (append α xs ys)

#eval append ℕ [3, 1] [4, 1, 5]
#eval append _ [3, 1] [4, 1, 5]

def appendImplicit {α : Type} : List α → List α → List α
  | List.nil, ys       => ys
  | List.cons x xs, ys => List.cons x (appendImplicit xs ys)

#eval appendImplicit [3, 1] [4, 1, 5]
#eval @appendImplicit ℕ [3, 1] [4, 1, 5]
#eval @appendImplicit _ [3, 1] [4, 1, 5]

def appendPretty {α : Type} : List α → List α → List α
  | [],      ys => ys
  | x :: xs, ys => x :: appendPretty xs ys

def reverse {α : Type} : List α → List α
  | [] => []
  | x :: xs => reverse xs ++ [x]

theorem add_comm_ (m n : ℕ) :
  add m n = add n m :=
  sorry

theorem add_assoc_ (l m n : ℕ) :
  add (add l m) n = add l (add m n) :=
  sorry

theorem mul_comm_ (m n : ℕ) :
  mul m n = mul n m :=
  sorry

theorem mul_assoc_ (l m n : ℕ) :
  mul (mul l m) n = mul l (mul m n) :=
  sorry

theorem mul_add_ (l m n : ℕ) :
  mul l (add m n) = add (mul l m) (mul l n) :=
  sorry

theorem reverse_reverse {α : Type} (xs : List α) :
  reverse (reverse xs) = xs :=
  sorry

-- < indent 2
namespace test_axiom
opaque a : ℤ
opaque b : ℤ
axiom a_less_b :
    a < b
end test_axiom
-- indent 2 >

-- Chapter 3. Backward Proofs
theorem fst_of_two_props :
    ∀ a b : Prop, a → b → a :=
  by
    intro a b
    intro ha hb
    apply ha

theorem fst_of_two_props_params (a b : Prop) (ha : a) (hb : b) :
    a :=
  by apply ha

theorem fst_of_two_props_exact (a b : Prop) (ha : a) (hb : b) :
    a :=
  by exact ha

theorem fst_of_two_props_assumption (a b : Prop)
      (ha : a) (hb : b) :
    a :=
  by assumption

theorem prop_comp (a b c : Prop) (hab : a → b) (hbc : b → c) :
    a → c :=
  by
    intro ha
    apply hbc
    apply hab
    apply ha

theorem α_example {α β : Type} (f : α → β) :
    (fun x ↦ f x) = (fun y ↦ f y) :=
  by rfl

theorem β_example {α β : Type} (f : α → β) (a : α):
    (fun x ↦ f x) a = f a :=
  by rfl

def double (n : ℕ) : ℕ := n + n

theorem δ_example :
    double 5 = 5 + 5 :=
  by rfl

theorem ζ_example :
    (let n : ℕ := 2
     n + n) = 4 :=
  by rfl

theorem η_example {α β : Type} (f : α → β) :
    (fun x ↦ f x) = f :=
  by rfl

namespace MyProd
structure Prod (α β : Type) where
  mk ::
  fst : α
  snd : β
end MyProd
#print MyProd.Prod
#print Prod

theorem th {α β : Type} (a : α) (b : β) :
    MyProd.Prod.fst (MyProd.Prod.mk a b) = a :=
  by rfl

theorem ι_example {α β : Type} (a : α) (b : β) :
    Prod.fst (a, b) = a :=
  by rfl

theorem And_swap (a b : Prop) :
    a ∧ b → b ∧ a :=
  by
    intro hab
    apply And.intro
    apply And.right
    exact hab
    apply And.left
    exact hab

/- Note:
To type the character ·, use one of the following
(1) type "Option+Shift+9"
(2) type "\." and hit TAB
(3) type "\cdot" and hit TAB
-/
theorem And_swap_braces :
    ∀ a b : Prop, a ∧ b → b ∧ a :=
  by
    intro a b hab
    apply And.intro
    . exact And.right hab
    . exact And.left hab

theorem f5_if (h : ∀ n : ℕ, f n = n) :
    f 5 = 5 :=
  by exact h 5

theorem Or_swap (a b : Prop) :
    a ∨ b → b ∨ a :=
  by
    intro hab
    apply Or.elim
    . exact hab
    . exact Or.inr
    . exact Or.inl

-- introduction and elimination rules for connectives
#check And.intro
#check And.left
#check And.right
#check Or.inl
#check Or.inr
#check Or.elim
#check Iff.intro
#check Iff.mp
#check Iff.mpr
#check Exists.intro
#check Exists.elim
#check True.intro
#check False.elim
#check Classical.em
#check Classical.byContradiction

theorem Exists_double_iden :
    ∃ n : ℕ, double n = n :=
  by
    apply Exists.intro 0
    rfl

theorem exists_or {α : Type} (p q : α → Prop) :
    (∃x, p x ∨ q x) ↔ (∃x, p x) ∨ (∃x, q x) :=
  by
    apply Iff.intro
    . sorry
    . intro hexporexq
      apply Or.elim hexporexq
      . intro hexp
        apply Exists.elim hexp
        intro x hpx
        apply Exists.intro
        apply Or.inl hpx
      . intro hexq
        apply Exists.elim hexq
        intro x hqx
        apply Exists.intro x
        apply Or.inr hqx

-- introduction and elimination rules that characterize equality
#check Eq.refl
#check Eq.symm
#check Eq.trans
#check Eq.subst

theorem Eq_trans_symm {α : Type} (a b c : α)
      (hab : a = b) (hcb : c = b) :
    a = c :=
  by
    apply Eq.trans
    . exact hab
    . apply Eq.symm
      exact hcb

theorem Eq_trans_symm_rw {α : Type} (a b c : α)
      (hab : a = b) (hcb : c = b) :
    a = c :=
  by
    rw [hab]
    rw [hcb]

theorem a_proof_of_negation (a : Prop) :
    a → ¬¬ a :=
  by
    intro ha
    rw [Not]
    rw [Not]
    intro hna
    exact hna ha

#print Not

theorem cong_two_args_1p1 {α β : Type} (a b c d : α)
      (g : α → α → ℕ → β) (hab : a = b) (hcd : c = d) :
    g a c (1 + 1) = g b d 2 :=
  by
    simp [hab, hcd]

theorem abc_Eq_cba (a b c : ℕ) :
    a + b + c = c + b + a :=
  by ac_rfl

theorem add_zero (n : ℕ) :
    add 0 n = n :=
  by
    induction n with
    | zero => rfl
    | succ n' ih => simp [add, ih]

def MyNat_add : MyNat.Nat → MyNat.Nat → MyNat.Nat
  | m, MyNat.Nat.zero => m
  | m, MyNat.Nat.succ n => MyNat.Nat.succ (MyNat_add m n)

theorem MyNat_add_zero (n : MyNat.Nat) :
    MyNat_add MyNat.Nat.zero n = n :=
  by
    induction n with
    | zero => rfl
    | succ n' ih => simp [MyNat_add, ih]

theorem add_succ (m n : ℕ) :
    add (Nat.succ m) n = Nat.succ (add m n) :=
  by
    induction n with
    | zero => rfl --alternatively, simp [add]
    | succ n' ih => simp [add, ih]

theorem add_comm (m n : ℕ) :
    add m n = add n m :=
  by
    induction n with
    | zero => simp [add, add_zero]
    | succ n' ih => simp [add, add_succ, ih]

theorem add_comm' (m n : ℕ) :
    add m n = add n m :=
  by
    induction m with
    | zero => simp [add_zero, add]
    | succ m' ih => simp [add_succ, add, ih]

theorem add_assoc (l m n : ℕ) :
    add (add l m) n = add l (add m n) :=
  by
    induction n with
    | zero => rfl --alternatively, simp [add]
    | succ n' ih => simp [add, ih]

theorem add_assoc' (l m n : ℕ) :
    add (add l m) n = add l (add m n) :=
  by
    induction m with
    | zero => simp [add, add_zero]
    | succ m' ih => simp [add, add_succ, ih]

theorem add_assoc'' (l m n : ℕ) :
    add (add l m) n = add l (add m n) :=
  by
    induction l with
    | zero => simp [add_zero]
    | succ l' ih => simp [add_succ, ih]

instance Associative_add : Std.Associative add :=
  { assoc := add_assoc }

instance Commutative_add : Std.Commutative add :=
  { comm := add_comm }

theorem mul_zero (n : ℕ) :
    mul 0 n = 0 :=
  by
    induction n with
    | zero => rfl
    | succ n' ih => simp [mul, add_zero, ih]

theorem mul_succ (m n : ℕ) :
    mul (Nat.succ m) n = add n (mul m n) :=
  by
    induction n with
    | zero => rfl
    | succ n' ih => simp [mul, add_succ, ih, ← add_assoc, add_comm]

theorem mul_comm (m n : ℕ) :
    mul m n = mul n m :=
  by
    induction n with
    | zero => simp [mul, mul_zero]
    | succ n' ih => simp [mul, mul_succ, ih]

theorem mul_add (l m n : ℕ) :
    mul l (add m n) = add (mul l m) (mul l n) :=
  by
    induction n with
    | zero => rfl
    | succ n' ih => simp [add, mul, ih]
                    ac_rfl

theorem mul_add' (l m n : ℕ) :
    mul l (add m n) = add (mul l m) (mul l n) :=
  by
    induction m with
    | zero => ac_rfl
    | succ m' ih => simp [add_succ, mul, ih]
                    ac_rfl

theorem mul_add'' (l m n : ℕ) :
    mul l (add m n) = add (mul l m) (mul l n) :=
  by
    induction l with
    | zero => simp [mul_zero]
              rfl
    | succ l' ih => simp [mul_succ, ih]
                    ac_rfl

theorem mul_assoc (l m n : ℕ) :
    mul (mul l m) n = mul l (mul m n) :=
  by
    induction n with
    | zero => rfl
    | succ n' ih => simp [mul, ih, mul_add]

instance Associative_mul : Std.Associative mul :=
  { assoc := mul_assoc }

instance Commutative_mul : Std.Commutative mul :=
 { comm := mul_comm }

-- The following prints all axioms which mul_assoc depends on
#print axioms mul_assoc

-- In the induction proof, there's no need to prefix the constructor with the type name (followed by a .)
-- In the def and theorem environment, however, this is needed.
-- by?
#print mul
end mine
-- indent 1 >
