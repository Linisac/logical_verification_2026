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

-- < indent 2
namespace sorryTheorems
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
end sorryTheorems
-- indent 2 >

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

#check Exists.elim
#check Exists.intro
#check Or.elim
theorem exists_or {α : Type} (p q : α → Prop) :
    (∃x, p x ∨ q x) ↔ (∃x, p x) ∨ (∃x, q x) :=
  by
    apply Iff.intro
    . intro hexporq
      apply Exists.elim hexporq
      intro x pxorqx
      apply Or.elim pxorqx
      · intro px
        apply Or.inl
        apply Exists.intro
        exact px
      · intro qx
        apply Or.inr
        apply Exists.intro
        exact qx
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

/-
Questions regarding practice.lean: 1. Why can't I write "zero" on line 84 and "succ" on line 85 rather than "Nat.zero" and "Nat.succ", respectively? 2. Why can't I write "ℕ.zero" for "Nat.zero" in this occasion (and like wise for the "succ")? 3. Similarly to 1., why can't I just write "succ" in place of "Nat.succ" while I must write so in the proofs (lines 400-402)?

All three come from the same fact: Nat's constructors are declared inside the namespace Nat, so their full names are Nat.zero and Nat.succ. It's the same as List.nil or Option.none. A bare zero only works if you're inside namespace Nat or have written open Nat, and practice.lean is in namespace mine. I tested each case below in Lean.

1. Bare zero / succ in a def (lines 84–85)

- On the right-hand side, zero is simply "Unknown identifier zero".
- In a pattern it's more dangerous. If a bare name doesn't resolve to a constructor, Lean treats it as a new variable. So | _, zero => … matches every number, and Lean only warns: "Local variable 'zero' resembles constructor 'Nat.zero' – write '.zero' (with a dot) or 'Nat.zero' to use the constructor."
- succ n is an application, so it has to be a constructor. It fails with "Invalid pattern: Expected a constructor…".

Shorter forms that do work:
- .zero / .succ n: the leading dot tells Lean to look the name up in the namespace of the expected type, here Nat. It also works on the right: | _, .zero => .zero.
- open Nat (inside a section), after which bare zero / succ resolve.
- 0 and n + 1: the usual way to write Nat patterns, as in your fib.

2. ℕ.zero

ℕ is notation that stands for Nat; it isn't itself a name or a namespace. Notation is replaced in terms, but namespaces are looked up by name. So Lean reads ℕ.zero as zero in a namespace called ℕ, which doesn't exist: "Unknown identifier «ℕ».zero".

3. Why induction … with | zero | succ needs the short names (lines 400–402)

The cases of induction (and cases) aren't patterns or terms. They're labels, one for each constructor of the type you're doing induction on. Lean already knows from n that this is Nat, so it expects just the constructor's own name. Writing | Nat.zero => … is rejected: "Invalid alternative name Nat.zero: Expected zero or succ."

def and match patterns are different. They're real terms built from constructors, so they go through normal name lookup, and the full name (or .zero) is required. That's the difference you noticed.

So you mean, the "Nat" in "Nat.zero" in your response 1. is the name of a namespace rather than of the type "Nat"?

Both. Here they're the same name, but they're different kinds of thing, and I was imprecise.

Lean names have parts, and a namespace is just a shared first part of names. Nat.zero is a name made of Nat and zero. A namespace isn't an object in the logic; it's only a prefix shared by many names. When you write inductive Nat, Lean does two things:
- It declares a constant named Nat: the type.
- It names the constructors and recursor with that same prefix: Nat.zero, Nat.succ, Nat.rec.

So the type and the namespace share the name Nat because that's how the inductive command names things. In Nat.zero, Nat is used as the namespace prefix. It just happens to be spelled the same as the type.

I checked each of these in Lean:
- A namespace can exist without a constant of that name. After namespace Foo  def bar …  end Foo, #check Foo.bar works, but #check Foo gives "Unknown identifier Foo".
- You can add your own definitions under Nat. def Nat.double (n : ℕ) : ℕ := n + n puts double in the Nat namespace. Inside namespace Nat, bare zero and double both resolve.
- The type points to its namespace. For x : Nat, writing x.double means Nat.double x, and (3 : ℕ).double evaluates to 6. The .zero shorthand works the same way. Lean takes the type's name, Nat, and uses it as the prefix to look things up.

That's also why ℕ.zero fails. ℕ is notation that turns into the constant Nat, but no name ℕ exists, so there's no prefix ℕ either. Lean reads ℕ.zero as a single name (it shows it as «ℕ».zero), so the ℕ notation never applies. Writing (3 : ℕ).double works because there the type is known to be Nat, so Lean looks in Nat.
-/

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

theorem reverse_cons {α : Type} (x : α) (xs : List α) :
    reverse (x :: xs) = reverse xs ++ [x] :=
  by
    rw [reverse]

namespace reverse_lemmas
theorem reverse_append {α : Type} (xs ys : List α) :
    reverse (xs ++ ys) = reverse ys ++ reverse xs :=
  by
    induction xs with
    | nil =>
        simp
        rfl
    | cons x xs ih =>
        simp
        rw [reverse]
        rw [ih]
        ac_rfl

theorem reverse_reverse {α : Type} (xs : List α) :
    reverse (reverse xs) = xs :=
  by
    induction xs with
    | nil =>
        rw [reverse]
        rfl
    | cons x xs' ih =>
        rw [reverse]
        rw [reverse_append]
        rw [ih]
        rfl
end reverse_lemmas
/-
by? runs a tactic block as usual and also shows you the proof term the tactics built. The term appears as a "Try this:" suggestion, and clicking it in VS Code replaces the whole by block with that term. It's built into Lean: by? tacs is shorthand for show_term by tacs.

So it lets you watch "proofs as terms" happen. Here's what it printed for your ch.3 proofs, which I ran:

lean
theorem C (a b c : Prop) : (a → b → c) → b → a → c := by?
  intro habc hb ha
  apply habc
  · exact ha
  · exact hb
-- Try this: fun habc hb ha => habc ha hb

theorem And_swap (a b : Prop) : a ∧ b → b ∧ a := by?
  intro hab
  apply And.intro
  · exact And.right hab
  · exact And.left hab
-- Try this: fun hab => ⟨hab.right, hab.left⟩

Things worth knowing:
- ⟨…, …⟩ is Lean's shorthand for applying a structure's constructor, here And.intro.
- hab.right is the dot notation from your last question. Because hab : And a b, hab.right means And.right hab.
- It's most readable on short proofs. On n + 0 = n, by? simp gives of_eq_true (Eq.trans (congrArg (fun x => x = n) (add_zero n)) (eq_self n)). It's correct but hard to read, so by? is most useful with intro/apply/exact.
- Compared with #print: #print thm shows the term after the whole theorem is finished. by? works right where you're writing and offers the replacement. Inside a proof you can use show_term tac to see the term for just one step.
- Not to be confused with exact? / apply?. The ? suffix means "suggest something", but those two search the library for a lemma that proves the goal. For example, exact? on m + n = n + m suggests exact Nat.add_comm m n. by? doesn't search anything; it only reports what your own tactics produced.
-/


-- Chapter 4. Forward Proofs
theorem fst_of_two_props' :
    ∀ a b : Prop, a → b → a :=
  fix a b : Prop
  assume ha : a
  assume hb : b
  show a from
    ha

#print fst_of_two_props'

theorem fst_of_two_props'' :
    ∀ a b : Prop, a → b → a :=
  fun a b : Prop ↦
  fun ha : a ↦
  fun _ : b ↦
  show a from
    ha

#print fst_of_two_props''

theorem fst_of_two_props''' :
    ∀ a b : Prop, a → b → a :=
  fun (a b : Prop) (ha : a) (hb : b) ↦ ha

#print fst_of_two_props'''

theorem fst_of_two_props_show (a b : Prop) (ha : a) (hb : b) :
    a :=
  show a from
    ha

theorem prop_comp' (a b c : Prop) (hab : a → b) (hbc : b → c) :
    a → c :=
  assume ha : a
  have hb : b :=
    hab ha
  have hc : c :=
    hbc hb
  show c from
    hc

theorem prop_comp'' (a b c : Prop) (hab : a → b) (hbc : b → c) :
    a → c :=
  fun ha : a ↦
  let hb : b := hab ha
  let hc : c := hbc hb
  show c from
    hc

/-
show c from
  hc
can be replaced by hc
-/
theorem prop_comp''' (a b c : Prop) (hab : a → b) (hbc : b → c) :
    a → c :=
  fun ha : a =>
  have hb : b :=
    hab ha
  have hc : c :=
    hbc hb
  hc

theorem prop_comp_inline (a b c : Prop) (hab : a → b) (hbc : b → c) :
    a → c :=
  assume ha : a
  show c from
    hbc (hab ha)

theorem two_and_two_Eq_four :
    2 + 2 = 4 :=
  by
    simp

theorem this_time_with_feeling :
    2 + 2 = 4 :=
  two_and_two_Eq_four

theorem add_comm_zero_left (n : ℕ) :
    add 0 n = add n 0 :=
  add_comm 0 n --alternatively: by exact add_comm 0 n

theorem  add_comm_zero_left_by_exact (n : ℕ) :
    add 0 n = add n 0 :=
  by exact add_comm 0 n

theorem And_swap' (a b : Prop) :
    a ∧ b → b ∧ a :=
  assume hab : a ∧ b
  have ha : a :=
    And.left hab
  have hb : b :=
    And.right hab
  show b ∧ a from
    And.intro hb ha

theorem Or_swap' (a b : Prop) :
    a ∨ b → b ∨ a :=
  assume hab : a ∨ b
  show b ∨ a from
    Or.elim hab
      ( assume ha : a
        show b ∨ a from
          Or.inr ha)
      ( assume hb : b
        Or.inl hb)

theorem Nat_exists_double_iden :
    ∃n : ℕ, double n = n :=
  Exists.intro 0
    ( show double 0 = 0 from
        by rfl)

theorem Nat_exists_double_iden_no_show :
    ∃n : ℕ, double n = n :=
  Exists.intro 0 (by rfl)

theorem modus_ponens (a b : Prop) :
    (a → b) → a → b :=
  assume hab : a → b
  assume ha : a
  show b from
    hab ha

theorem not_not_intro (a : Prop) :
    a → ¬¬a :=
  assume ha : a
  assume hna : ¬a
  show False from
    hna ha

theorem Forall.one_point {α : Type} (t : α) (P : α → Prop) :
    (∀x, x = t → P x) ↔ P t :=
  Iff.intro
    ( assume hall : ∀x, x = t → P x
      show P t from
        by
          apply hall t
          rfl)
    ( assume hp : P t
      fix x : α
      assume heq : x = t
      show P x from
        by
          rw [heq]
          exact hp)

theorem beast_666 (beast : ℕ) :
    (∀n, n = 666 → beast ≥ n) ↔ beast ≥ 666 :=
  Forall.one_point 666 (fun m => beast ≥ m)
  -- alternatively: Forall.one_point _ _

theorem beast_666' (beast : ℕ) :
    (∀n, n = 666 → beast ≥ n) ↔ beast ≥ 666 :=
  Forall.one_point _ _

theorem Exists.one_point {α : Type} (t : α) (P : α → Prop) :
    (∃x : α, x = t ∧ P x) ↔ P t :=
  Iff.intro
    ( assume hex : ∃x : α, x = t ∧ P x
      show P t from
        Exists.elim hex
          ( fix x : α
            assume hand : x = t ∧ P x
            have hxt : x = t :=
              And.left hand
            have hpx : P x :=
              And.right hand
            show P t from
              by
                rw [← hxt]
                exact hpx))
    ( assume hp : P t
      show ∃x : α, x = t ∧ P x from
        Exists.intro t
          ( have tt : t = t :=
              rfl
            show t = t ∧ P t from
              And.intro tt hp))

theorem Exists.one_point' {α : Type} (t : α) (P : α → Prop) :
    (∃x, x = t ∧ P x) ↔ P t :=
  Iff.intro
    ( assume hex : ∃x, x = t ∧ P x
      show P t from
        Exists.elim hex
        fix x : α
        assume hxeqp : x = t ∧ P x
        have hxeq : x = t :=
          And.left hxeqp
        have hxp : P x :=
          And.right hxeqp
        Eq.subst hxeq hxp)
    ( assume hp : P t
      Exists.intro t
        ( And.intro (Eq.refl t) hp))

theorem Exists.one_point'' {α : Type} (t : α) (P : α → Prop) :
    (∃x, x = t ∧ P t) ↔ P t :=
  Iff.intro
    ( assume hex : ∃x, x = t ∧ P t
      show P t from
        by
          apply Exists.elim hex
          intro x
          intro hxeqp
          exact And.right hxeqp)
    ( assume hp : P t
      show ∃x, x = t ∧ P t from
        by
          apply Exists.intro t
          apply And.intro
          · rfl
          · exact hp)

theorem two_mul_example (m n : ℕ) :
    2 * m + n = m + n + m :=
  calc
    2 * m + n = m + m + n :=
      by rw [Nat.two_mul]
    _ = m + n + m :=
      by ac_rfl

  /-
  by
    calc
    2 * m + n = m + m + n :=
      by rw [Nat.two_mul]
    _ = m + n + m :=
      by ac_rfl
  -/

theorem two_mul_example_have (m n : ℕ) :
    2 * m + n = m + n + m :=
  have hmul : 2 * m + n = m + m + n :=
    by rw [Nat.two_mul]
  have hcomm : m + m + n = m + n + m :=
    by ac_rfl
  show _ from
    Eq.trans hmul hcomm

theorem prop_comp_tactical (a b c : Prop) (hab : a → b)
    (hbc : b → c) :
    a → c :=
  by
    intro ha
    have hb : b :=
      hab ha
    let c' := c
    have hc : c' :=
      hbc hb
    exact hc

#check (fun α : Type => α → α)

theorem reverse_append {α : Type} :
    ∀xs ys : List α,
      reverse (xs ++ ys) = reverse ys ++ reverse xs
  | [], ys => by simp [reverse]
  | x :: xs, ys => by simp [reverse, reverse_append xs]

theorem reverse_append_tactical {α : Type} (xs ys : List α) :
    reverse (xs ++ ys) = reverse ys ++ reverse xs :=
  by
    induction xs with
    | nil => simp [reverse]
    | cons x xs' ih => simp [reverse, ih]

#loogle "mul", (?a : ℕ) * ?b = ?b * ?a

theorem And_swap'' (a b : Prop) :
    a ∧ b → b ∧ a :=
  fun hab : a ∧ b =>
  And.intro (And.right hab) (And.left hab)

theorem And_swap_tactical (a b : Prop) :
    a ∧ b → b ∧ a :=
  by
    intro hab
    apply And.intro
    · apply And.right
      exact hab
    · apply And.left
      exact hab

#print And_swap
#print And_swap'
#print And_swap''
#print And_swap_tactical

theorem reverse_reverse {α : Type} :
    ∀xs : List α, reverse (reverse xs) = xs
  | [] => by rfl
  | x :: xs => by simp [reverse, reverse_append, reverse_reverse xs]
  /- alternative:
  :=
  by
    intro xs'
    induction xs' with
    | nil => rfl
    | cons x xs ih => simp [reverse, reverse_append, ih]
  -/

end mine
-- indent 1 >
