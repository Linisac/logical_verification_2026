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
#check List.cons
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

theorem add_comm (m n : ℕ) :
  add m n = add n m :=
  sorry

theorem add_assoc (l m n : ℕ) :
  add (add l m) n = add l (add m n) :=
  sorry

theorem mul_comm (m n : ℕ) :
  mul m n = mul n m :=
  sorry

theorem mul_assoc (l m n : ℕ) :
  mul (mul l m) n = mul l (mul m n) :=
  sorry

theorem mul_add (l m n : ℕ) :
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

theorem prop_comp (a b c : Prop) (hab : a → b) (hbc : b → c) :
    a → c :=
  by
    intro ha
    apply hbc
    apply hab
    apply ha

theorem And_swap (a b : Prop) :
    a ∧ b → b ∧ a :=
  by
    intro hab
    apply And.intro
    apply And.right
    exact hab
    apply And.left
    exact hab

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
end mine
-- indent 1 >
