// Lean compiler output
// Module: LoVe.LoVe02_ProgramsAndTheorems_HomeworkSheet
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
LEAN_EXPORT lean_object* l_LoVe_snoc___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_minusTwo(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_sum(lean_object*);
LEAN_EXPORT lean_object* l_LoVe_minusTwo___boxed(lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_sum___boxed(lean_object*);
LEAN_EXPORT lean_object* l_LoVe_snoc(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_LoVe_snoc___redArg(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
lean_object* x_3; 
x_3 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_3, 0, x_2);
lean_ctor_set(x_3, 1, x_1);
return x_3;
}
else
{
uint8_t x_4; 
x_4 = !lean_is_exclusive(x_1);
if (x_4 == 0)
{
lean_object* x_5; lean_object* x_6; 
x_5 = lean_ctor_get(x_1, 1);
x_6 = l_LoVe_snoc___redArg(x_5, x_2);
lean_ctor_set(x_1, 1, x_6);
return x_1;
}
else
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; 
x_7 = lean_ctor_get(x_1, 0);
x_8 = lean_ctor_get(x_1, 1);
lean_inc(x_8);
lean_inc(x_7);
lean_dec(x_1);
x_9 = l_LoVe_snoc___redArg(x_8, x_2);
x_10 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_10, 0, x_7);
lean_ctor_set(x_10, 1, x_9);
return x_10;
}
}
}
}
LEAN_EXPORT lean_object* l_LoVe_snoc(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l_LoVe_snoc___redArg(x_2, x_3);
return x_4;
}
}
LEAN_EXPORT lean_object* l_LoVe_minusTwo(lean_object* x_1) {
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
lean_object* x_4; lean_object* x_5; uint8_t x_6; 
x_4 = lean_unsigned_to_nat(1u);
x_5 = lean_nat_sub(x_1, x_4);
x_6 = lean_nat_dec_eq(x_5, x_2);
if (x_6 == 1)
{
lean_dec(x_5);
return x_2;
}
else
{
lean_object* x_7; 
x_7 = lean_nat_sub(x_5, x_4);
lean_dec(x_5);
return x_7;
}
}
}
}
LEAN_EXPORT lean_object* l_LoVe_minusTwo___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_LoVe_minusTwo(x_1);
lean_dec(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_LoVe_sum(lean_object* x_1) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
lean_object* x_2; 
x_2 = lean_unsigned_to_nat(0u);
return x_2;
}
else
{
lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_3 = lean_ctor_get(x_1, 0);
x_4 = lean_ctor_get(x_1, 1);
x_5 = l_LoVe_sum(x_4);
x_6 = lean_nat_add(x_3, x_5);
lean_dec(x_5);
return x_6;
}
}
}
LEAN_EXPORT lean_object* l_LoVe_sum___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_LoVe_sum(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* initialize_Init(uint8_t builtin, lean_object*);
lean_object* initialize_LoVe_LoVe02__ProgramsAndTheorems__Demo(uint8_t builtin, lean_object*);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_LoVe_LoVe02__ProgramsAndTheorems__HomeworkSheet(uint8_t builtin, lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_LoVe_LoVe02__ProgramsAndTheorems__Demo(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
