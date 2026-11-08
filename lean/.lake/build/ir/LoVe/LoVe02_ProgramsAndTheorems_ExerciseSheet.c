// Lean compiler output
// Module: LoVe.LoVe02_ProgramsAndTheorems_ExerciseSheet
// Imports: Init LoVe.LoVe02_ProgramsAndTheorems_Demo
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
static lean_object* l_LoVe_aexp__y___closed__0;
static lean_object* l_LoVe_simplify___closed__1;
static lean_object* l_LoVe_aexp__div__50___closed__0;
LEAN_EXPORT lean_object* l_LoVe_aexp__div__50;
static lean_object* l_LoVe_aexp__z___closed__0;
static lean_object* l_LoVe_aexp__z___closed__1;
static lean_object* l_LoVe_someEnv___closed__1;
LEAN_EXPORT lean_object* l_LoVe_someEnv___boxed(lean_object*);
LEAN_EXPORT lean_object* l_LoVe_pred___boxed(lean_object*);
static lean_object* l_LoVe_someEnv___closed__4;
uint8_t lean_string_dec_eq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_aexp__add__xy;
LEAN_EXPORT lean_object* l_LoVe_aexp__y;
static lean_object* l_LoVe_aexp__0___closed__1;
lean_object* lean_nat_to_int(lean_object*);
static lean_object* l_LoVe_aexp__5___closed__0;
static lean_object* l_LoVe_aexp__mul__z5___closed__0;
static lean_object* l_LoVe_aexp__5___closed__1;
static lean_object* l_LoVe_someEnv___closed__3;
LEAN_EXPORT lean_object* l_LoVe_aexp__x;
static lean_object* l_LoVe_someEnv___closed__0;
static lean_object* l_LoVe_aexp__add__xy___closed__0;
static lean_object* l_LoVe_aexp__sub__yz___closed__0;
LEAN_EXPORT lean_object* l_LoVe_aexp__sub__yz;
LEAN_EXPORT lean_object* l_LoVe_aexp__5;
static lean_object* l_LoVe_aexp__x___closed__0;
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_map(lean_object*, lean_object*, lean_object*, lean_object*);
static lean_object* l_LoVe_simplify___closed__0;
LEAN_EXPORT lean_object* l_LoVe_aexp__z;
LEAN_EXPORT lean_object* l_LoVe_aexp__0;
lean_object* lean_nat_sub(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_map___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_pred(lean_object*);
static lean_object* l_LoVe_someEnv___closed__2;
static lean_object* l_LoVe_aexp__0___closed__0;
LEAN_EXPORT lean_object* l_LoVe_someEnv(lean_object*);
uint8_t lean_int_dec_eq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_aexp__mul__z5;
LEAN_EXPORT lean_object* l_LoVe_simplify(lean_object*);
LEAN_EXPORT lean_object* l_LoVe_pred(lean_object* x_1) {
_start:
{
lean_object* x_2; uint8_t x_3; 
x_2 = lean_unsigned_to_nat(0u);
x_3 = lean_nat_dec_eq(x_1, x_2);
if (x_3 == 1)
{
return x_2;
}
else
{
lean_object* x_4; lean_object* x_5; 
x_4 = lean_unsigned_to_nat(1u);
x_5 = lean_nat_sub(x_1, x_4);
return x_5;
}
}
}
LEAN_EXPORT lean_object* l_LoVe_pred___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_LoVe_pred(x_1);
lean_dec(x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_someEnv___closed__0() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("x", 1, 1);
return x_1;
}
}
static lean_object* _init_l_LoVe_someEnv___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("y", 1, 1);
return x_1;
}
}
static lean_object* _init_l_LoVe_someEnv___closed__2() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(201u);
x_2 = lean_nat_to_int(x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_someEnv___closed__3() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(17u);
x_2 = lean_nat_to_int(x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_someEnv___closed__4() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(3u);
x_2 = lean_nat_to_int(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_LoVe_someEnv(lean_object* x_1) {
_start:
{
lean_object* x_2; uint8_t x_3; 
x_2 = l_LoVe_someEnv___closed__0;
x_3 = lean_string_dec_eq(x_1, x_2);
if (x_3 == 0)
{
lean_object* x_4; uint8_t x_5; 
x_4 = l_LoVe_someEnv___closed__1;
x_5 = lean_string_dec_eq(x_1, x_4);
if (x_5 == 0)
{
lean_object* x_6; 
x_6 = l_LoVe_someEnv___closed__2;
return x_6;
}
else
{
lean_object* x_7; 
x_7 = l_LoVe_someEnv___closed__3;
return x_7;
}
}
else
{
lean_object* x_8; 
x_8 = l_LoVe_someEnv___closed__4;
return x_8;
}
}
}
LEAN_EXPORT lean_object* l_LoVe_someEnv___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_LoVe_someEnv(x_1);
lean_dec_ref(x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_aexp__0___closed__0() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(0u);
x_2 = lean_nat_to_int(x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_aexp__0___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l_LoVe_aexp__0___closed__0;
x_2 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_aexp__0() {
_start:
{
lean_object* x_1; 
x_1 = l_LoVe_aexp__0___closed__1;
return x_1;
}
}
static lean_object* _init_l_LoVe_aexp__5___closed__0() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(5u);
x_2 = lean_nat_to_int(x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_aexp__5___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l_LoVe_aexp__5___closed__0;
x_2 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_aexp__5() {
_start:
{
lean_object* x_1; 
x_1 = l_LoVe_aexp__5___closed__1;
return x_1;
}
}
static lean_object* _init_l_LoVe_aexp__x___closed__0() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l_LoVe_someEnv___closed__0;
x_2 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_aexp__x() {
_start:
{
lean_object* x_1; 
x_1 = l_LoVe_aexp__x___closed__0;
return x_1;
}
}
static lean_object* _init_l_LoVe_aexp__y___closed__0() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l_LoVe_someEnv___closed__1;
x_2 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_aexp__y() {
_start:
{
lean_object* x_1; 
x_1 = l_LoVe_aexp__y___closed__0;
return x_1;
}
}
static lean_object* _init_l_LoVe_aexp__z___closed__0() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_unchecked("z", 1, 1);
return x_1;
}
}
static lean_object* _init_l_LoVe_aexp__z___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l_LoVe_aexp__z___closed__0;
x_2 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_aexp__z() {
_start:
{
lean_object* x_1; 
x_1 = l_LoVe_aexp__z___closed__1;
return x_1;
}
}
static lean_object* _init_l_LoVe_aexp__add__xy___closed__0() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l_LoVe_aexp__y;
x_2 = l_LoVe_aexp__x;
x_3 = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(x_3, 0, x_2);
lean_ctor_set(x_3, 1, x_1);
return x_3;
}
}
static lean_object* _init_l_LoVe_aexp__add__xy() {
_start:
{
lean_object* x_1; 
x_1 = l_LoVe_aexp__add__xy___closed__0;
return x_1;
}
}
static lean_object* _init_l_LoVe_aexp__sub__yz___closed__0() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l_LoVe_aexp__z;
x_2 = l_LoVe_aexp__y;
x_3 = lean_alloc_ctor(3, 2, 0);
lean_ctor_set(x_3, 0, x_2);
lean_ctor_set(x_3, 1, x_1);
return x_3;
}
}
static lean_object* _init_l_LoVe_aexp__sub__yz() {
_start:
{
lean_object* x_1; 
x_1 = l_LoVe_aexp__sub__yz___closed__0;
return x_1;
}
}
static lean_object* _init_l_LoVe_aexp__mul__z5___closed__0() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l_LoVe_aexp__5;
x_2 = l_LoVe_aexp__z;
x_3 = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(x_3, 0, x_2);
lean_ctor_set(x_3, 1, x_1);
return x_3;
}
}
static lean_object* _init_l_LoVe_aexp__mul__z5() {
_start:
{
lean_object* x_1; 
x_1 = l_LoVe_aexp__mul__z5___closed__0;
return x_1;
}
}
static lean_object* _init_l_LoVe_aexp__div__50___closed__0() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l_LoVe_aexp__0;
x_2 = l_LoVe_aexp__5;
x_3 = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(x_3, 0, x_2);
lean_ctor_set(x_3, 1, x_1);
return x_3;
}
}
static lean_object* _init_l_LoVe_aexp__div__50() {
_start:
{
lean_object* x_1; 
x_1 = l_LoVe_aexp__div__50___closed__0;
return x_1;
}
}
static lean_object* _init_l_LoVe_simplify___closed__0() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(1u);
x_2 = lean_nat_to_int(x_1);
return x_2;
}
}
static lean_object* _init_l_LoVe_simplify___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l_LoVe_simplify___closed__0;
x_2 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_LoVe_simplify(lean_object* x_1) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 2:
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_4 = lean_ctor_get(x_1, 0);
lean_inc_ref(x_4);
x_5 = lean_ctor_get(x_1, 1);
lean_inc_ref(x_5);
if (lean_is_exclusive(x_1)) {
 lean_ctor_release(x_1, 0);
 lean_ctor_release(x_1, 1);
 x_6 = x_1;
} else {
 lean_dec_ref(x_1);
 x_6 = lean_box(0);
}
if (lean_obj_tag(x_4) == 0)
{
lean_object* x_11; lean_object* x_12; uint8_t x_13; 
x_11 = lean_ctor_get(x_4, 0);
x_12 = l_LoVe_aexp__0___closed__0;
x_13 = lean_int_dec_eq(x_11, x_12);
if (x_13 == 0)
{
if (lean_obj_tag(x_5) == 0)
{
lean_object* x_14; uint8_t x_15; 
x_14 = lean_ctor_get(x_5, 0);
x_15 = lean_int_dec_eq(x_14, x_12);
if (x_15 == 0)
{
goto block_10;
}
else
{
lean_dec(x_6);
lean_dec_ref(x_5);
x_1 = x_4;
goto _start;
}
}
else
{
goto block_10;
}
}
else
{
lean_dec(x_6);
lean_dec_ref(x_4);
if (lean_obj_tag(x_5) == 0)
{
lean_object* x_17; uint8_t x_18; 
x_17 = lean_ctor_get(x_5, 0);
x_18 = lean_int_dec_eq(x_17, x_12);
if (x_18 == 0)
{
x_1 = x_5;
goto _start;
}
else
{
lean_object* x_20; 
lean_dec_ref(x_5);
x_20 = l_LoVe_aexp__0___closed__1;
x_1 = x_20;
goto _start;
}
}
else
{
x_1 = x_5;
goto _start;
}
}
}
else
{
if (lean_obj_tag(x_5) == 0)
{
lean_object* x_23; lean_object* x_24; uint8_t x_25; 
x_23 = lean_ctor_get(x_5, 0);
x_24 = l_LoVe_aexp__0___closed__0;
x_25 = lean_int_dec_eq(x_23, x_24);
if (x_25 == 0)
{
goto block_10;
}
else
{
lean_dec(x_6);
lean_dec_ref(x_5);
x_1 = x_4;
goto _start;
}
}
else
{
goto block_10;
}
}
block_10:
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; 
x_7 = l_LoVe_simplify(x_4);
x_8 = l_LoVe_simplify(x_5);
if (lean_is_scalar(x_6)) {
 x_9 = lean_alloc_ctor(2, 2, 0);
} else {
 x_9 = x_6;
}
lean_ctor_set(x_9, 0, x_7);
lean_ctor_set(x_9, 1, x_8);
return x_9;
}
}
case 3:
{
lean_object* x_27; lean_object* x_28; lean_object* x_29; 
x_27 = lean_ctor_get(x_1, 0);
lean_inc_ref(x_27);
x_28 = lean_ctor_get(x_1, 1);
lean_inc_ref(x_28);
if (lean_is_exclusive(x_1)) {
 lean_ctor_release(x_1, 0);
 lean_ctor_release(x_1, 1);
 x_29 = x_1;
} else {
 lean_dec_ref(x_1);
 x_29 = lean_box(0);
}
if (lean_obj_tag(x_28) == 0)
{
lean_object* x_34; lean_object* x_35; uint8_t x_36; 
x_34 = lean_ctor_get(x_28, 0);
x_35 = l_LoVe_aexp__0___closed__0;
x_36 = lean_int_dec_eq(x_34, x_35);
if (x_36 == 0)
{
goto block_33;
}
else
{
lean_dec(x_29);
lean_dec_ref(x_28);
x_1 = x_27;
goto _start;
}
}
else
{
goto block_33;
}
block_33:
{
lean_object* x_30; lean_object* x_31; lean_object* x_32; 
x_30 = l_LoVe_simplify(x_27);
x_31 = l_LoVe_simplify(x_28);
if (lean_is_scalar(x_29)) {
 x_32 = lean_alloc_ctor(3, 2, 0);
} else {
 x_32 = x_29;
}
lean_ctor_set(x_32, 0, x_30);
lean_ctor_set(x_32, 1, x_31);
return x_32;
}
}
case 4:
{
lean_object* x_38; lean_object* x_39; lean_object* x_40; 
x_38 = lean_ctor_get(x_1, 0);
lean_inc_ref(x_38);
x_39 = lean_ctor_get(x_1, 1);
lean_inc_ref(x_39);
if (lean_is_exclusive(x_1)) {
 lean_ctor_release(x_1, 0);
 lean_ctor_release(x_1, 1);
 x_40 = x_1;
} else {
 lean_dec_ref(x_1);
 x_40 = lean_box(0);
}
if (lean_obj_tag(x_38) == 0)
{
lean_object* x_45; lean_object* x_46; uint8_t x_47; 
x_45 = lean_ctor_get(x_38, 0);
x_46 = l_LoVe_aexp__0___closed__0;
x_47 = lean_int_dec_eq(x_45, x_46);
if (x_47 == 0)
{
lean_object* x_48; uint8_t x_49; 
x_48 = l_LoVe_simplify___closed__0;
x_49 = lean_int_dec_eq(x_45, x_48);
if (x_49 == 0)
{
if (lean_obj_tag(x_39) == 0)
{
lean_object* x_50; uint8_t x_51; 
x_50 = lean_ctor_get(x_39, 0);
x_51 = lean_int_dec_eq(x_50, x_46);
if (x_51 == 0)
{
uint8_t x_52; 
x_52 = lean_int_dec_eq(x_50, x_48);
if (x_52 == 0)
{
goto block_44;
}
else
{
lean_dec(x_40);
lean_dec_ref(x_39);
x_1 = x_38;
goto _start;
}
}
else
{
lean_dec(x_40);
lean_dec_ref(x_39);
lean_dec_ref(x_38);
goto block_3;
}
}
else
{
goto block_44;
}
}
else
{
lean_dec(x_40);
lean_dec_ref(x_38);
if (lean_obj_tag(x_39) == 0)
{
lean_object* x_54; uint8_t x_55; 
x_54 = lean_ctor_get(x_39, 0);
x_55 = lean_int_dec_eq(x_54, x_46);
if (x_55 == 0)
{
uint8_t x_56; 
x_56 = lean_int_dec_eq(x_54, x_48);
if (x_56 == 0)
{
x_1 = x_39;
goto _start;
}
else
{
lean_object* x_58; 
lean_dec_ref(x_39);
x_58 = l_LoVe_simplify___closed__1;
x_1 = x_58;
goto _start;
}
}
else
{
lean_dec_ref(x_39);
goto block_3;
}
}
else
{
x_1 = x_39;
goto _start;
}
}
}
else
{
lean_dec(x_40);
lean_dec_ref(x_38);
if (lean_obj_tag(x_39) == 0)
{
lean_dec_ref(x_39);
goto block_3;
}
else
{
lean_dec_ref(x_39);
goto block_3;
}
}
}
else
{
if (lean_obj_tag(x_39) == 0)
{
lean_object* x_61; lean_object* x_62; uint8_t x_63; 
x_61 = lean_ctor_get(x_39, 0);
x_62 = l_LoVe_aexp__0___closed__0;
x_63 = lean_int_dec_eq(x_61, x_62);
if (x_63 == 0)
{
lean_object* x_64; uint8_t x_65; 
x_64 = l_LoVe_simplify___closed__0;
x_65 = lean_int_dec_eq(x_61, x_64);
if (x_65 == 0)
{
goto block_44;
}
else
{
lean_dec(x_40);
lean_dec_ref(x_39);
x_1 = x_38;
goto _start;
}
}
else
{
lean_dec(x_40);
lean_dec_ref(x_39);
lean_dec_ref(x_38);
goto block_3;
}
}
else
{
goto block_44;
}
}
block_44:
{
lean_object* x_41; lean_object* x_42; lean_object* x_43; 
x_41 = l_LoVe_simplify(x_38);
x_42 = l_LoVe_simplify(x_39);
if (lean_is_scalar(x_40)) {
 x_43 = lean_alloc_ctor(4, 2, 0);
} else {
 x_43 = x_40;
}
lean_ctor_set(x_43, 0, x_41);
lean_ctor_set(x_43, 1, x_42);
return x_43;
}
}
case 5:
{
lean_object* x_67; lean_object* x_68; lean_object* x_69; 
x_67 = lean_ctor_get(x_1, 0);
lean_inc_ref(x_67);
x_68 = lean_ctor_get(x_1, 1);
lean_inc_ref(x_68);
if (lean_is_exclusive(x_1)) {
 lean_ctor_release(x_1, 0);
 lean_ctor_release(x_1, 1);
 x_69 = x_1;
} else {
 lean_dec_ref(x_1);
 x_69 = lean_box(0);
}
if (lean_obj_tag(x_67) == 0)
{
lean_object* x_74; lean_object* x_75; uint8_t x_76; 
x_74 = lean_ctor_get(x_67, 0);
x_75 = l_LoVe_aexp__0___closed__0;
x_76 = lean_int_dec_eq(x_74, x_75);
if (x_76 == 0)
{
if (lean_obj_tag(x_68) == 0)
{
lean_object* x_77; uint8_t x_78; 
x_77 = lean_ctor_get(x_68, 0);
x_78 = lean_int_dec_eq(x_77, x_75);
if (x_78 == 0)
{
lean_object* x_79; uint8_t x_80; 
x_79 = l_LoVe_simplify___closed__0;
x_80 = lean_int_dec_eq(x_77, x_79);
if (x_80 == 0)
{
goto block_73;
}
else
{
lean_dec(x_69);
lean_dec_ref(x_68);
x_1 = x_67;
goto _start;
}
}
else
{
lean_dec(x_69);
lean_dec_ref(x_68);
lean_dec_ref(x_67);
goto block_3;
}
}
else
{
goto block_73;
}
}
else
{
lean_dec(x_69);
lean_dec_ref(x_67);
if (lean_obj_tag(x_68) == 0)
{
lean_dec_ref(x_68);
goto block_3;
}
else
{
lean_dec_ref(x_68);
goto block_3;
}
}
}
else
{
if (lean_obj_tag(x_68) == 0)
{
lean_object* x_82; lean_object* x_83; uint8_t x_84; 
x_82 = lean_ctor_get(x_68, 0);
x_83 = l_LoVe_aexp__0___closed__0;
x_84 = lean_int_dec_eq(x_82, x_83);
if (x_84 == 0)
{
lean_object* x_85; uint8_t x_86; 
x_85 = l_LoVe_simplify___closed__0;
x_86 = lean_int_dec_eq(x_82, x_85);
if (x_86 == 0)
{
goto block_73;
}
else
{
lean_dec(x_69);
lean_dec_ref(x_68);
x_1 = x_67;
goto _start;
}
}
else
{
lean_dec(x_69);
lean_dec_ref(x_68);
lean_dec_ref(x_67);
goto block_3;
}
}
else
{
goto block_73;
}
}
block_73:
{
lean_object* x_70; lean_object* x_71; lean_object* x_72; 
x_70 = l_LoVe_simplify(x_67);
x_71 = l_LoVe_simplify(x_68);
if (lean_is_scalar(x_69)) {
 x_72 = lean_alloc_ctor(5, 2, 0);
} else {
 x_72 = x_69;
}
lean_ctor_set(x_72, 0, x_70);
lean_ctor_set(x_72, 1, x_71);
return x_72;
}
}
default: 
{
return x_1;
}
}
block_3:
{
lean_object* x_2; 
x_2 = l_LoVe_aexp__0___closed__1;
return x_2;
}
}
}
LEAN_EXPORT lean_object* l_LoVe_map___redArg(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_2) == 0)
{
lean_object* x_3; 
lean_dec(x_1);
x_3 = lean_box(0);
return x_3;
}
else
{
uint8_t x_4; 
x_4 = !lean_is_exclusive(x_2);
if (x_4 == 0)
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; 
x_5 = lean_ctor_get(x_2, 0);
x_6 = lean_ctor_get(x_2, 1);
lean_inc(x_1);
x_7 = lean_apply_1(x_1, x_5);
x_8 = l_LoVe_map___redArg(x_1, x_6);
lean_ctor_set(x_2, 1, x_8);
lean_ctor_set(x_2, 0, x_7);
return x_2;
}
else
{
lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; 
x_9 = lean_ctor_get(x_2, 0);
x_10 = lean_ctor_get(x_2, 1);
lean_inc(x_10);
lean_inc(x_9);
lean_dec(x_2);
lean_inc(x_1);
x_11 = lean_apply_1(x_1, x_9);
x_12 = l_LoVe_map___redArg(x_1, x_10);
x_13 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_13, 0, x_11);
lean_ctor_set(x_13, 1, x_12);
return x_13;
}
}
}
}
LEAN_EXPORT lean_object* l_LoVe_map(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l_LoVe_map___redArg(x_3, x_4);
return x_5;
}
}
lean_object* initialize_Init(uint8_t builtin, lean_object*);
lean_object* initialize_LoVe_LoVe02__ProgramsAndTheorems__Demo(uint8_t builtin, lean_object*);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_LoVe_LoVe02__ProgramsAndTheorems__ExerciseSheet(uint8_t builtin, lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_LoVe_LoVe02__ProgramsAndTheorems__Demo(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_LoVe_someEnv___closed__0 = _init_l_LoVe_someEnv___closed__0();
lean_mark_persistent(l_LoVe_someEnv___closed__0);
l_LoVe_someEnv___closed__1 = _init_l_LoVe_someEnv___closed__1();
lean_mark_persistent(l_LoVe_someEnv___closed__1);
l_LoVe_someEnv___closed__2 = _init_l_LoVe_someEnv___closed__2();
lean_mark_persistent(l_LoVe_someEnv___closed__2);
l_LoVe_someEnv___closed__3 = _init_l_LoVe_someEnv___closed__3();
lean_mark_persistent(l_LoVe_someEnv___closed__3);
l_LoVe_someEnv___closed__4 = _init_l_LoVe_someEnv___closed__4();
lean_mark_persistent(l_LoVe_someEnv___closed__4);
l_LoVe_aexp__0___closed__0 = _init_l_LoVe_aexp__0___closed__0();
lean_mark_persistent(l_LoVe_aexp__0___closed__0);
l_LoVe_aexp__0___closed__1 = _init_l_LoVe_aexp__0___closed__1();
lean_mark_persistent(l_LoVe_aexp__0___closed__1);
l_LoVe_aexp__0 = _init_l_LoVe_aexp__0();
lean_mark_persistent(l_LoVe_aexp__0);
l_LoVe_aexp__5___closed__0 = _init_l_LoVe_aexp__5___closed__0();
lean_mark_persistent(l_LoVe_aexp__5___closed__0);
l_LoVe_aexp__5___closed__1 = _init_l_LoVe_aexp__5___closed__1();
lean_mark_persistent(l_LoVe_aexp__5___closed__1);
l_LoVe_aexp__5 = _init_l_LoVe_aexp__5();
lean_mark_persistent(l_LoVe_aexp__5);
l_LoVe_aexp__x___closed__0 = _init_l_LoVe_aexp__x___closed__0();
lean_mark_persistent(l_LoVe_aexp__x___closed__0);
l_LoVe_aexp__x = _init_l_LoVe_aexp__x();
lean_mark_persistent(l_LoVe_aexp__x);
l_LoVe_aexp__y___closed__0 = _init_l_LoVe_aexp__y___closed__0();
lean_mark_persistent(l_LoVe_aexp__y___closed__0);
l_LoVe_aexp__y = _init_l_LoVe_aexp__y();
lean_mark_persistent(l_LoVe_aexp__y);
l_LoVe_aexp__z___closed__0 = _init_l_LoVe_aexp__z___closed__0();
lean_mark_persistent(l_LoVe_aexp__z___closed__0);
l_LoVe_aexp__z___closed__1 = _init_l_LoVe_aexp__z___closed__1();
lean_mark_persistent(l_LoVe_aexp__z___closed__1);
l_LoVe_aexp__z = _init_l_LoVe_aexp__z();
lean_mark_persistent(l_LoVe_aexp__z);
l_LoVe_aexp__add__xy___closed__0 = _init_l_LoVe_aexp__add__xy___closed__0();
lean_mark_persistent(l_LoVe_aexp__add__xy___closed__0);
l_LoVe_aexp__add__xy = _init_l_LoVe_aexp__add__xy();
lean_mark_persistent(l_LoVe_aexp__add__xy);
l_LoVe_aexp__sub__yz___closed__0 = _init_l_LoVe_aexp__sub__yz___closed__0();
lean_mark_persistent(l_LoVe_aexp__sub__yz___closed__0);
l_LoVe_aexp__sub__yz = _init_l_LoVe_aexp__sub__yz();
lean_mark_persistent(l_LoVe_aexp__sub__yz);
l_LoVe_aexp__mul__z5___closed__0 = _init_l_LoVe_aexp__mul__z5___closed__0();
lean_mark_persistent(l_LoVe_aexp__mul__z5___closed__0);
l_LoVe_aexp__mul__z5 = _init_l_LoVe_aexp__mul__z5();
lean_mark_persistent(l_LoVe_aexp__mul__z5);
l_LoVe_aexp__div__50___closed__0 = _init_l_LoVe_aexp__div__50___closed__0();
lean_mark_persistent(l_LoVe_aexp__div__50___closed__0);
l_LoVe_aexp__div__50 = _init_l_LoVe_aexp__div__50();
lean_mark_persistent(l_LoVe_aexp__div__50);
l_LoVe_simplify___closed__0 = _init_l_LoVe_simplify___closed__0();
lean_mark_persistent(l_LoVe_simplify___closed__0);
l_LoVe_simplify___closed__1 = _init_l_LoVe_simplify___closed__1();
lean_mark_persistent(l_LoVe_simplify___closed__1);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
