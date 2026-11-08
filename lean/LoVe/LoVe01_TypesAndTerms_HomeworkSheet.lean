/- Copyright © 2018–2026 Anne Baanen, Alexander Bentkamp, Jasmin Blanchette,
Xavier Généreux, Johannes Hölzl, and Jannis Limperg. See `LICENSE.txt`. -/

import LoVe.LoVelib


/- # LoVe Homework 1: Types and Terms

Replace the placeholders (e.g., `:= sorry`) with your solutions. -/


set_option autoImplicit false
set_option linter.unusedVariables false
set_option linter.unnecessarySeqFocus false
set_option linter.tacticAnalysis.introMerge false

namespace LoVe


/- ## Question 1: Terms

We start by declaring four new opaque types. -/

opaque α : Type
opaque β : Type
opaque γ : Type
opaque δ : Type

/- 1.1. Complete the following definitions by providing terms with the expected
type.

Please use reasonable names for the bound variables, e.g., `a : α`, `b : β`,
`c : γ`.

Hint: A procedure for doing so systematically is described in Section 1.4 of the
Hitchhiker's Guide. As explained there, you can use `_` as a placeholder while
constructing a term. By hovering over `_`, you will see the current logical
context. -/

def B : (α → β) → (γ → α) → γ → β :=
  fun h f c ↦ h (f c)

def S : (α → β → γ) → (α → β) → α → γ :=
  fun f g a ↦ f a (g a)

def nonsense1 : (γ → (α → β) → α) → γ → β → α :=
  fun f c b ↦ f c (fun _ ↦ b)

def nonsense2 : (α → α → β) → (β → γ) → α → β → γ :=
  fun f g a b ↦ g b

def nonsense3 : ((α → β) → γ → δ) → γ → β → δ :=
  fun f c b ↦ f (fun _ ↦ b) c

def nonsense4 : (α → β) → (α → γ) → α → β → γ :=
  fun f g a b ↦ g a

/- 1.2. Complete the following definition.

This one looks more difficult, but it should be fairly straightforward if you
follow the procedure described in the Hitchhiker's Guide.

Note: Peirce is pronounced like the English word "purse". -/

def weakPeirce : ((((α → β) → α) → α) → β) → β :=
  fun f ↦ f (fun g ↦ g (fun a ↦ f (fun _ ↦ a)))

/- ## Question 2: Typing Derivation

2.1. Show the typing derivation for your definition of `B` above, using ASCII or
Unicode art. Start with an empty context. You might find the characters `–` (to
draw horizontal bars) and `⊢` useful.

Feel free to introduce abbreviations to avoid repeating large contexts `C`. -/

/-
1. (Var) h : (α → β), f : (γ → α), c : γ ⊢ f : (γ → α)
2. (Var) h : (α → β), f : (γ → α), c : γ ⊢ c : γ
3. (Var) h : (α → β), f : (γ → α), c : γ ⊢ h : (α → β)
4. (App to 1. and 2.) h : (α → β), f : (γ → α), c : γ ⊢ f c : α
5. (App to 3. and 4.) h : (α → β), f : (γ → α), c : γ ⊢ h (f c) : β
6. (Fun to 5.) h : (α → β), f : (γ → α) ⊢ (fun c : γ ↦ h (f c)) : γ → β
7. (Fun to 6.) h : (α → β) ⊢ (fun f : (γ → α) ↦ fun c : γ ↦ h (f c)) : (γ → α) → γ → β
8. (Fun to 7.) ⊢ (fun h : (α → β) ↦ fun f : (γ → α) ↦ fun c : γ ↦ h (f c)) : (α → β) → (γ → α) → γ → β
-/

/- 2.2. Show the typing derivation for your definition of `S` above, using
ASCII or Unicode art. Start with an empty context. -/

/-
1. (Var) f : (α → β → γ), g : (α → β), a : α ⊢ f : (α → β → γ)
2. (Var) f : (α → β → γ), g : (α → β), a : α ⊢ g : (α → β)
3. (Var) f : (α → β → γ), g : (α → β), a : α ⊢ a : α
4. (App to 1. and 3.) f : (α → β → γ), g : (α → β), a : α ⊢ f a : β → γ
5. (App to 2. and 3.) f : (α → β → γ), g : (α → β), a : α ⊢ g a : β
6. (App to 4. and 5.) f : (α → β → γ), g : (α → β), a : α ⊢ f a (g a) : γ
7. (Fun to 6.) f : (α → β → γ), g : (α → β) ⊢ (fun a : α ↦ f a (g a)) : α → γ
8. (Fun to 7.) f : (α → β → γ) ⊢ (fun g : (α → β) ↦ fun a : α ↦ f a (g a)) : (α → β) → α → γ
9. (Fun to 8.) ⊢ (fun f : (α → β → γ) ↦ fun g : (α → β) ↦ fun a : α ↦ f a (g a)) : (α → β → γ) → (α → β) → α → γ
-/

end LoVe
